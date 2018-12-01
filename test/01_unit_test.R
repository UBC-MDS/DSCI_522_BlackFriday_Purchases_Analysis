#! /usr/bin/env Rscript

##################################################
## Project: 01_unit_test.R
## Date: 2018 Nov 30
## Author: Mengda (Albert) Yu [aut cre] and Gilbert Lei
## Script purpose: This scripts is an unit test for the output of 01_clean_data.R
##  
## Example: Rscript test/01_unit_test.R
##################################################

# library
suppressPackageStartupMessages(library(testthat))
suppressPackageStartupMessages(library(tidyverse))

# main function 
main <- function(){ 
  
  test_files_exist()
  run_test()
  
  cat("00_read_raw_data unit test....PASS!!!\n")
}

# test if a file exist or not. If not, stop the execution.
test_files_exist <- function(){
  
  if (file_test("-f", "data/BlackFriday_tidy.csv")) {
    cat("BlackFriday_tidy does exist")
  } else {
    car("BlackFriday_tidy.csv does not exsit.")
    stop()
  }
  
}

# run tests
run_test <- function () {
  
  # Load data 
  data <- suppressWarnings(suppressMessages(read_csv("data/BlackFriday_tidy.csv")))
  
  # first test 
  test_that("Test on the columns of the dataset in data/BlackFriday_tidy.csv", {
  
    # store the name
    col_name <- names(data)
    
    expect_equal(length(col_name), 2) # expect 2
    expect_true("Gender" %in% col_name) # expect "Gender" is in the data set
    expect_true("Purchase" %in% col_name) # expect "Purchase" is in the data set

  })
  
  # second test 
  test_that("Test if there is no null value", {
    expect_equal(sum(is.na(data)), 0 ) # expect no NA value
  })
  
}

# call main function 
main()