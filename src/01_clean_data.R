#! /usr/bin/env Rscript

##################################################
## Project: clean_data.R
## Date: 2o18 Nov 20 
## Author: Mengda (Albert) Yu [aut cre] and Gilbert Lei [ctb]
## Script purpose: This script reads in some raw data in csv format 
##            and saves a tidy version of it. It takes two arguments,
##            the path of input file and the path of output file.
##  
## Example: Rscript clean_data.R data/data.csv data/data_tidy.csv
##################################################

# library
suppressPackageStartupMessages(library(tidyverse))

# define main function
main <- function(){
  
  # read arguments from commend line
  args <- commandArgs(trailingOnly = TRUE)
  in_file <- args[1]
  out_file <- args[2]
  
  # read in data
  data <- suppressMessages(read_csv(in_file))
  
  # select feature 
  out_data <- select_data(data)
  
  # save a tidy version of raw data
  write_csv(out_data, out_file)
  
  cat("Cleaning......Complete!\n")
}

# retrieve column 'Gender' and 'Purchase'  
select_data <- function(data){
  
  temp <- 
    data %>% 
    select(Gender, Purchase) %>% 
    drop_na() 
    
  return(temp)
}

# call main function
main()