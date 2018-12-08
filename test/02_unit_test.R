#! /usr/bin/env Rscript

##################################################
## Project: 02_unit_test.R
## Date: 2018 Dec 7
## Author: Mengda (Albert) Yu [aut cre] and Gilbert Lei
## Script purpose: This scripts is an unit test for the output of 02_visualize_data.R
##  
## Example: Rscript test/02_unit_test.R
##################################################

# library
suppressPackageStartupMessages(library(testthat))
suppressPackageStartupMessages(library(tidyverse))

# Grab functions
source("src/02_visualize_data.R")

# Create sample data 
data1 <- tibble( 
  Gender = c("M", "M", "F", "F"),
  Purchase = c(0, 0, 0, 0)
)

data2 <- tibble(
  Gender = sample(c("M", "F"), 1000, replace=TRUE, prob=c(0.75, 0.25)),
  Purchase = rnorm(1000, 3000, 300)
)

# Check if the imgs/gender_bar.png exists or not
if (file_test("-f", "imgs/gender_bar.png")) {
  cat("gender_bar.png does exist")
} else {
  cat("gender_bar.png does not exsit.")
  stop()
}

# Check if the imgs/purch_dist.png exists or not
if (file_test("-f", "imgs/purch_dist.png")) {
  cat("purch_dist.png does exist")
} else {
  cat("purch_dist.png does not exsit.")
  stop()
}

# Check if the imgs/gender_pur_hist.png exists or not
if (file_test("-f", "imgs/gender_pur_hist.png")) {
  cat("gender_pur_hist.png does exist")
} else {
  cat("gender_pur_hist.png does not exsit.")
  stop()
}

test_that("Check the ouptut of create_gender_barplot()",{
  
  barplot_1 <- create_gender_barplot(data1)
  barplot_2 <- create_gender_barplot(data2)
  
  # Check if it is a ggplot object 
  expect_true(is.ggplot(barplot_1))
  expect_true(is.ggplot(barplot_2))
  
  # check if the lalbel is the expected 
  expect_identical(barplot_1$labels$y, "Number of Purchase Orders")
  expect_identical(barplot_2$labels$y, "Number of Purchase Orders")
  
  # check if the plots can be plotted 
  expect_error(print(barplot_1), NA)
  expect_error(print(barplot_2), NA)
})

test_that("Check the ouptut of create_purch_hist()",{
  
  hist_1 <- create_purch_hist(data1)
  hist_2 <- create_purch_hist(data2)
  
  # Check if it is a ggplot object 
  expect_true(is.ggplot(hist_1))
  expect_true(is.ggplot(hist_2))
  
  # check if the lalbel is the expected 
  expect_identical(hist_1$labels$y, "Number of Purchase Orders")
  expect_identical(hist_2$labels$y, "Number of Purchase Orders")
  
  # check if the plots can be plotted 
  expect_error(print(hist_1), NA)
  expect_error(print(hist_2), NA)
})

test_that("Check the ouptut of create_gender_pur_hist()",{
  
  hist_1 <- create_gender_pur_hist(data1)
  hist_2 <- create_gender_pur_hist(data2)
  
  # Check if it is a ggplot object 
  expect_true(is.ggplot(hist_1))
  expect_true(is.ggplot(hist_2))
  
  # check if the lalbel is the expected 
  expect_identical(hist_1$labels$y, "Number of Purchase Orders")
  expect_identical(hist_2$labels$y, "Number of Purchase Orders")
  
  # check if the plots can be plotted 
  expect_error(print(hist_1), NA)
  expect_error(print(hist_2), NA)
})

cat("02_visualize_data.R unit test....PASS!!!\n")