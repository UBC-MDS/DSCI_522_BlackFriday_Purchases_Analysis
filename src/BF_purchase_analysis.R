#! /usr/bin/env python

###################################################
## Project: BF_purchase_analysis.R
## Date: 22/11/2018
## Author: Gilbert Lei and Albert Yu
## Script purpose: use CLT to estimate the male and female purchases. 
##                use t.test to test whether male and female spent the same amount on Black Friday. 
## Example: Rscript BF_purchase_analysis.R data/BlackFriday_tidy.csv results/est.csv results/t_test.csv

# libraries
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(infer))

# define main function
main <- function() {

  # read arguments from command line
  args <- commandArgs(trailingOnly = TRUE)
  in_file <- args[1]
  out_file_est <- args[2]
  out_file_t_test <- args[3]

  # in_file <- "data/BlackFriday_tidy.csv"
  # out_file_est <- "results/est.csv"
  # out_file_t_test <- "results/t_test.csv"
  
  # calculate confidence interval 
  BF_data <- read_csv(in_file)    
  BF_est <- calc_estimation(BF_data)
  write.csv(BF_est, out_file_est)
  
  # get p-value 
  t_test_result <- calc_t_test(BF_data)
  write.csv(t_test_result, out_file_t_test)
}

# calculate estimation using CLT 
calc_estimation <- function(data) {
  BF_est <- data %>% 
    group_by(Gender) %>% 
    summarize(purchase_mean = mean(Purchase), n = n(), se = sd(Purchase)/sqrt(n))
  BF_est <- BF_est %>% 
    mutate(lower_95 = purchase_mean - (1.96 * se), 
           upper_95 = purchase_mean + (1.96 * se))
  return(BF_est)
}

# calculate p-value using t.test 
calc_t_test <- function(data) {
  t_test_results <- broom::tidy(t.test(Purchase ~ Gender, data = data, var.equal = FALSE))
  return(t_test_results)
}

# call main function
main()

