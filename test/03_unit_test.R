#! /usr/bin/env Rscript

##################################################
## Project: 03_unit_test.R
## Date: 2018 Dec 7
## Author: Mengda (Albert) Yu [aut cre] and Gilbert Lei
## Script purpose: This scripts is an unit test for the functions of 03_analyze_data.R
##  
## Example: Rscript test/03_unit_test.R
##################################################

# library
suppressPackageStartupMessages(library(testthat))
suppressPackageStartupMessages(library(tidyverse))

# Grab functions 
source("src/03_analyze_data.R")


# Create sample data 
data1 <- tibble(
  Gender = c("M", "M", "F", "F"),
  Purchase = c(0, 0, 0, 0)
)

data2 <- tibble(
  Gender = sample(c("M", "F"), 1000, replace=TRUE, prob=c(0.75, 0.25)),
  Purchase = rnorm(1000, 3000, 300)
)

test_that("Test the reasults of calc_estimation function", {
  
  # get results
  result1 <- calc_estimation(data1)
  result2 <- calc_estimation(data2)
  
  # Expect the number counted to be right 
  expect_equal(sum(result1$n), 4) 
  expect_equal(sum(result2$n), 1000) 
  
  # Expect the mean values calculated correctly
  expect_equal(result1$purchase_mean[1], 0)
  expect_equal(result1$purchase_mean[2], 0)
  
  result2_mean_f <- mean(filter(data2, Gender == "F")$Purchase)
  result2_mean_m <- mean(filter(data2, Gender == "M")$Purchase)
  expect_equal(result2$purchase_mean[1], result2_mean_f)
  expect_equal(result2$purchase_mean[2], result2_mean_m)
  
  # Expect the same SE
  expect_equal(result1$se[1], 0)
  expect_equal(result1$se[2], 0)
  
  result2_se_f <- sd(filter(data2, Gender == "F")$Purchase)/sqrt(nrow(filter(data2, Gender == "F")))
  result2_se_m <- sd(filter(data2, Gender == "M")$Purchase)/sqrt(nrow(filter(data2, Gender == "M")))
  expect_equal(result2$se[1], result2_se_f)
  expect_equal(result2$se[2], result2_se_m)

  # Expect the same 95% CI
  expect_equal(result1$lower_95, c(0,0))
  expect_equal(result1$upper_95, c(0,0))
  
  lower_95_f <- result2_mean_f - (qnorm(0.975) * result2_se_f)
  upper_95_f <- result2_mean_f + (qnorm(0.975) * result2_se_f)
  lower_95_m <- result2_mean_m - (qnorm(0.975) * result2_se_m)
  upper_95_m <- result2_mean_m + (qnorm(0.975) * result2_se_m)
  expect_equal(result2$lower_95, c(lower_95_f, lower_95_m))
  expect_equal(result2$upper_95, c(upper_95_f, upper_95_m))
})

test_that("Test the results of calc_t_test function", {
  
  # get t test results
  tresult1 <- calc_t_test(data1)
  tresult2 <- calc_t_test(data2)
  
  my_tresult1 <- tidy(t.test(Purchase ~ Gender, data = data1, var.equal = FALSE))
  my_tresult2 <- tidy(t.test(Purchase ~ Gender, data = data2, var.equal = FALSE))
  
  # Expect the same t statistic 
  expect_equal(tresult1$statistic, my_tresult1$statistic)
  expect_equal(tresult2$statistic, my_tresult2$statistic)
  
  # Expect the same estimators 
  expect_equal(tresult1$estimate, my_tresult1$estimate)
  expect_equal(tresult1$estimate1, my_tresult1$estimate1)
  expect_equal(tresult1$estimate2, my_tresult1$estimate2)
  
  expect_equal(tresult2$estimate2, my_tresult2$estimate2)
  expect_equal(tresult2$estimate1, my_tresult2$estimate1)
  expect_equal(tresult2$estimate2, my_tresult2$estimate2)
  
  # Expect the same p-value 
  expect_equal(tresult1$p.value, my_tresult1$p.value)
  expect_equal(tresult2$p.value, my_tresult2$p.value)
  
})

cat("03_analyze_data.R unit test....PASS!!!\n")