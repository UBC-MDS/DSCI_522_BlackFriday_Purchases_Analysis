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

# test if a file exist or not. If not, stop the execution.
if (file_test("-f", "data/BlackFriday_tidy.csv")) {
    cat("BlackFriday_tidy does exist")
} else {
    cat("BlackFriday_tidy.csv does not exsit.")
    stop()
}
  
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
  

cat("01_clean_data.R unit test....PASS!!!\n")