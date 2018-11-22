#! /usr/bin/env python

##################################################
## Project: analyze_data.R 
## Date: 2018 Nov 21
## Author: Mengda (Albert) Yu [aut cre] and Gilbert Lei [ctb]
## Script purpose: 
## Example: Rscript analyze_data.R data/data_tidy.csv results
##################################################

# Library
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(infer))
set.seed(4)

# define main function
main <- function(){
  
  # read arguments from commend line
  args <- commandArgs(trailingOnly = TRUE)
  in_file <- args[1]
  out_file_prefix <- args[2]
  
  # read in data
  data <- suppressMessages(read_csv(in_file))
  
  # analyze data
  sum_table <- generate_sum_table(data)
  null_dist <- generate_null_dist(data)

  # save the results
  write_csv(sum_table, paste(out_file_prefix, "sum_table.csv", sep = '/'))
  
  write_csv(null_dist, paste(out_file_prefix, "null_dist.csv", sep = '/'))
  
  cat("Analyzing......Complete!\n")
}

# calculate the mean of each gender 
calculate_mean_est <- function(data){
  
  purchase_est <-
    data %>% 
    group_by(Gender) %>% 
    summarise(mean_est = mean(Purchase))
    
  return (purchase_est)  
}

# calculate 95% confidence interval 
calculate_ci <- function(data, sex){
  
  purchase_est <- 
    data %>% 
    filter(Gender == sex) %>% 
    specify(response = Purchase) %>% 
    generate(reps = 10000, type = "bootstrap") %>% 
    calculate(stat = "mean") %>% 
    get_ci()
  
  purchase_est$Gender <- sex
  
  return (purchase_est)
}

# generate a summary table that contains mean and 95% confidence interval 
generate_sum_table <- function(data){
  
  # calculate the means
  purchase_est <- calculate_mean_est(data)
  
  # calculate 95% CI
  purch_female <- calculate_ci(data, "F")
  purch_male <- calculate_ci(data, "M")
  cis <- bind_rows(purch_female, purch_male)
  
  # Create a table 
  sum_table <-
    purchase_est %>% 
    left_join(cis, by = "Gender")
  
  # rename column names
  colnames(sum_table) <- c("Gender", "mean_purchase", "lower_ci", "upper_ci")
  
  return (sum_table)
}

# generate a distribution under the model of H_0
generate_null_dist <- function(data){
  
  null_dist <-
    data %>% 
    specify(formula = Purchase ~ Gender)  %>% 
    hypothesize(null = "independence") %>% 
    generate(reps = 15000)  %>% 
    calculate(stat = "diff in means", order = c("F", "M"))
  
  return (null_dist)
}


# call main function
main()