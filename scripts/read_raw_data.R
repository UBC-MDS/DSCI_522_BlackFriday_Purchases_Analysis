#! /usr/bin/env python

# Author: Mengda Yu & Gilbert gilbertlei
# Date: 2018 Nov 15

# This script read raw data from BlackFriday.csv and print first few lines
# This script takes a column name as the variable argument.

# library
suppressPackageStartupMessages(library(tidyverse))

# define main function
main <- function(){

  # read from commend line
  args <- commandArgs(trailingOnly = TRUE)
  file <- args[1]
  lines <- args[2]

  # read in data
  data <- suppressMessages(read_csv(file))
  head(data, lines)
}

# call main function
main()
