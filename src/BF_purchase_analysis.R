#! /usr/bin/env python

###################################################
## Project: BF_purchase_analysis.R
## Date: 22/11/2018
## Author: Gilbert Lei and Albert Yu
## Script purpose: run hypothesis test to test whether male and female
##                spent the same amount on Black Friday.
##                This script takes two arguments.
## Example: Rscript BF_purchase_analysis.R data/BlackFriday_tidy.csv results/analysis

# libraries
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(infer))
suppressPackageStartupMessages(library(ggplot2))

# define main function
main <- function() {

  # read arguments from command line
  args <- commandArgs(trailingOnly = TRUE)
  in_file <- args[1]
  out_path_n_prefix <- args[2]

  # read in data
  data <- read_csv(in_file)    
  
  male_one_sample <- data %>% 
    filter(Gender == 'M') %>% 
    select(Gender, Purchase) %>% 
    rep_sample_n(size = 10000) 
  
  female_one_sample <- data %>% 
    filter(Gender == 'F') %>% 
    select(Gender, Purchase) %>% 
    rep_sample_n(size = 10000)
  
  combined_sample <- bind_rows(male_one_sample, female_one_sample) 
  combined_sample <- combined_sample[c("Gender", "Purchase")]
  
  boostrapping(combined_sample, out_path_n_prefix)
  
  hypo_test(combined_sample, out_path_n_prefix)

}


##
##  boostrapping function. 
##  it compares the distribution of male purchases and female purchases
## 
boostrapping <- function(sample_data, out_path, file_prefix) {
  male_sample <- sample_data %>% 
    filter(Gender == 'M') 
  female_sample <- sample_data %>% 
    filter(Gender == 'F') 
  
  male_boostrapping <- male_sample %>% 
    rep_sample_n(size = 10000, reps = 10000, replace = TRUE) %>% 
    group_by(replicate) %>% 
    summarize(stat = mean(Purchase))
  
  female_boostrapping <- female_sample %>% 
    rep_sample_n(size = 10000, reps = 10000, replace = TRUE) %>% 
    group_by(replicate) %>% 
    summarize(stat = mean(Purchase))
  
  male_est <- get_ci(male_boostrapping) 
  male_est$Gender <- 'Male'
  male_est$Mean <- mean(male_boostrapping$stat)
  
  female_est <- get_ci(female_boostrapping) 
  female_est$Gender <- 'Female'
  female_est$Mean <- mean(female_boostrapping$stat)
  
  combined_est <- bind_rows(male_est, female_est)
  combined_est <- combined_est[c(3,4,1,2)]
  colnames(combined_est) <- c("Gender", "Mean", "Lower_ci", "Upper_ci") 
  # output estimation to external file 
  write_csv(combined_est, "results/estimation.csv")
  
  male_boostrapping$replicate <- NULL
  male_boostrapping$Gender <- 'Male' 
  female_boostrapping$replicate <- NULL
  female_boostrapping$Gender <- 'Female'
  combined_stats <- bind_rows(male_boostrapping, female_boostrapping)
  
  combined_stats %>% ggplot(aes(x = Gender)) +
    geom_violin(aes(y = stat, group = Gender)) + 
    geom_point(data = combined_est, aes(x = Gender, y = Mean)) + 
    geom_errorbar(data = combined_est, aes(x = Gender, ymin = Lower_ci, ymax = Upper_ci))
}

#
# hypothesis test function
# null hypothesis (H_0): male and female spent the same amount on Black Friday.
# alternative hypothesis (H_A): male and female spent different amounts on Black Friday.
#
hypo_test <- function(sample_data, out_path, file_prefix) {
  # calculate delta sample 
  purchase_est <- sample_data %>% 
    group_by(Gender) %>% 
    summarise(mean_purchase = mean(Purchase)) 
  delta_sample <- diff(purchase_est$mean_purchase)
  
  # simulate 10000 times to generate 10000 simulated test statistics 
  null_dist <- sample_data %>% 
    specify(formula = Purchase ~ Gender) %>% 
    hypothesize(null = "independence") %>%   # independence??? 
    generate(reps = 10000) %>% 
    calculate(stat = "diff in means", order = c("M", "F"))  # order???
  
  # calculate confidence interval 
  threshold <- quantile(null_dist$stat, c(0.025, 0.975)) 
  
  # visualize the null distribution 
  null_dist_plot <- null_dist %>% 
    visualize() + 
    geom_vline(xintercept = c(threshold[[1]], threshold[[2]]), color = "blue", lty = 2) + 
    geom_vline(xintercept = delta_sample, color = "red") 
  
  # calculate p-value 
  pvalue <- null_dist %>% 
    get_pvalue(obs_stat = delta_sample, direction = "both")
  
}

# call main function
main()






