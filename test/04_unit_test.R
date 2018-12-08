#! /usr/bin/env Rscript

##################################################
## Project: 04_unit_test.R
## Date: 2018 Dec 7
## Author: Mengda (Albert) Yu [aut cre] and Gilbert Lei
## Script purpose: This scripts is an unit test for the functions of 04_generate_final_result.R
##  
## Example: Rscript test/04_unit_test.R
##################################################

# library
suppressPackageStartupMessages(library(testthat))
suppressPackageStartupMessages(library(tidyverse))

# Grab functions
source("./src/03_analyze_data.R")
source("./src/04_generate_final_result.R")

# Create sample data 
data1 <- tibble( 
  Gender = c("M", "M", "F", "F"),
  Purchase = c(0, 0, 0, 0)
)

data2 <- tibble(
  Gender = sample(c("M", "F"), 1000, replace=TRUE, prob=c(0.75, 0.25)),
  Purchase = rnorm(1000, 3000, 300)
)

# get estimates results
est1 <- calc_estimation(data1)
est2 <- calc_estimation(data2)
# get t test results
tresult1 <- calc_t_test(data1)
tresult2 <- calc_t_test(data2)

# Check if the imgs/errorbar.png exists or not
if (file_test("-f", "imgs/errorbar.png")) {
  cat("errorbar.png does exist")
} else {
  cat("errorbar.png does not exsit.")
  stop()
}

# Check if the imgs/tdist.png exists or not
if (file_test("-f", "imgs/tdist.png")) {
  cat("tdist.png does exist")
} else {
  cat("tdist.png does not exsit.")
  stop()
}


test_that("Check the ouptut of plot_errorbar()",{
  
  barplot_1 <- plot_errorbar(est1)
  barplot_2 <- plot_errorbar(est2)
  
  # Check if it is a ggplot object 
  expect_true(is.ggplot(barplot_1))
  expect_true(is.ggplot(barplot_2))
  
  # check if the lalbel is the expected 
  expect_identical(barplot_1$labels$y, "The amount of purchase")
  expect_identical(barplot_2$labels$y, "The amount of purchase")
  expect_identical(barplot_1$labels$x, "Gender")
  expect_identical(barplot_2$labels$x, "Gender")
  
  # check if the plots can be plotted 
  expect_error(print(barplot_1), NA)
  expect_error(print(barplot_2), NA)
})

test_that("Check the ouptut of plot_tdist()",{
  
  hist_1 <- plot_tdist(tresult1)
  hist_2 <- plot_tdist(tresult2)
  
  # Check if it is a ggplot object 
  expect_true(is.ggplot(hist_1))
  expect_true(is.ggplot(hist_2))
  
  # check if the lalbel is the expected 
  expect_identical(hist_1$labels$y, "density")
  expect_identical(hist_2$labels$y, "density")
  
  # check if the plots can be plotted 
  expect_error(print(hist_1), NA)
  expect_error(print(hist_2), NA)
})

cat("04_generate_final_result.R unit test....PASS!!!\n")