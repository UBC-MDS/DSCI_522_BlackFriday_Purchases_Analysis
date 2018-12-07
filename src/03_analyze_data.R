#! /usr/bin/env Rscript

###################################################
## Project: analyze_data.R
## Date: 2018 Nov 22
## Author: Gilbert Lei [aut cre] and Mengda (Albert) Yu [ctb aut]
## Script purpose: use CLT to estimate the male and female purchases. 
##                use t.test to test whether male and female spent the same amount on Black Friday. 
## Example: Rscript analyze_data.R data/BlackFriday_tidy.csv results
##################################################

# libraries
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(broom))

# define main function
main <- function() {

  # read arguments from command line
  args <- commandArgs(trailingOnly = TRUE)
  in_file <- args[1]
  out_file_prefix <- args[2]
  # out_file_t_test <- args[3]

  # in_file <- "data/BlackFriday_tidy.csv"
  # out_file_est <- "results/est.csv"
  # out_file_t_test <- "results/t_test.csv"
  
  # calculate confidence interval 
  data <- suppressMessages(read_csv(in_file))
  BF_est <- calc_estimation(data)
 
  # get p-value 
  t_test_result <- calc_t_test(data)
  
  # save in csv 
  write.csv(BF_est, paste(out_file_prefix, "blackfriday_est.csv", sep = '/'))
  write.csv(t_test_result, paste(out_file_prefix, "t_test_result.csv", sep = '/'))
  
  cat("Analyzing...Complete!\n")
}

# calculate estimation using CLT 
calc_estimation <- function(data) {
  
  BF_est <- 
    data %>% 
    group_by(Gender) %>% 
    summarize(purchase_mean = mean(Purchase), 
              n = n(), 
              se = sd(Purchase) / sqrt(n)) %>% 
    mutate(lower_95 = purchase_mean - (qnorm(0.975) * se), 
           upper_95 = purchase_mean + (qnorm(0.975) * se))

  return(BF_est)
}

# calculate p-value using t.test 
calc_t_test <- function(data) {
  
  t_test_result <- 
    t.test(Purchase ~ Gender, data = data, var.equal = FALSE) %>% 
    tidy()
  
  return(t_test_result)
}

# call main function
main()
