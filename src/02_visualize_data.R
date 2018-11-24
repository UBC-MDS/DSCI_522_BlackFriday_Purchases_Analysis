#! /usr/bin/env python

##################################################
## Project: visualize_data.R
## Date: 2018 Nov 20 
## Author: Mengda (Albert) Yu [aut cre] and Gilbert Lei [ctb]
## Script purpose: This script reads in a tidy data set from a csv file
##          and creates an exploratory visualization to help us understand the dataset
##  
## Example: Rscript visualize_data.R data/data_tidy.csv imgs
##################################################

# Library
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(scales))

# define main function 
main <- function(){
  
  # read in command line arguments
  args <- commandArgs(trailingOnly = TRUE)
  input_file <- args[1]
  out_file_prefix <- args[2]
  
  # read in data 
  data <- suppressMessages(read_csv(input_file))
  
  # create EDA figures
  gender_bar <- create_gender_barplot(data)
  purch_dist <- create_purch_hist(data)
  gender_pur_hist <- create_gender_pur_hist(data)
  
  # save the figures
  ggsave("gender_bar.png", plot = gender_bar, path = out_file_prefix,
         width = 8, height = 5)
  ggsave("purch_dist.png", plot = purch_dist, path = out_file_prefix,
         width = 8, height = 5)
  ggsave("gender_pur_hist.png", plot = gender_pur_hist, path = out_file_prefix,
         width = 8, height = 5)
  
  cat("EDA......Complete!\n")
}

# create a barplot for gender feature 
create_gender_barplot <- function(data){
  
  temp <-
    data %>%
    ggplot(aes(x = Gender, fill = Gender)) +
    geom_bar() +
    scale_x_discrete(breaks = c("F", "M"), labels = c("Female", "Male")) +
    scale_y_continuous(labels = comma) +
    xlab("Gender") + 
    ylab("The number of observations") +
    ggtitle("The number Black Friday purchase made by female and male") +
    theme_bw() +
    theme(plot.title = element_text(size = 13, face = "bold", hjust = 0.5))
  
  return (temp)
}

# create a historgram of purchase 
create_purch_hist <- function(data){
  
  # calculate the mean of purchase
  mean_purchase <- mean(data$Purchase)
  
  # use ggplot to draw the graph 
  temp <- 
    temp <-
    data %>%
    ggplot(aes(x = Purchase)) +
    geom_histogram(bins = 35, color = "white", fill = "#0099ff" ) + 
    geom_vline(xintercept = mean_purchase, alpha = 0.7, 
               color = "red", linetype = "dashed") +
    annotate("text", x = 11000, y = 45000, label = 'mean', alpha = 0.8) +
    scale_y_continuous(labels = comma) +
    scale_x_continuous(limits = c(0, 26000), breaks = seq(0, 25000, by=5000), labels = dollar_format()) +
    xlab("Purchase") + 
    ylab("The number of observation") +
    ggtitle("The distribution of purchase amount on Black Friday") +
    theme_bw() +
    theme(plot.title = element_text(size = 13, face = "bold", hjust = 0.5))
  
  return (temp)
}

# create a historgram of female and male 
create_gender_pur_hist <- function(data){
  
  # calculate the mean purchase for each gender
  mean_tib <-
    data %>% 
    group_by(Gender) %>% 
    summarise(mu = mean(Purchase))
  
  # use ggplot to draw the graph 
  temp <- 
    temp <-
    data %>%
    ggplot(aes(x = Purchase)) +
    geom_histogram(bins = 35, color = "white", fill = "#0099ff" ) +
    geom_vline(data = mean_tib, aes(xintercept = mu), 
               color = "red", linetype = "dashed") +
    facet_wrap(~Gender, nrow = 2, ncol = 1, 
               labeller = as_labeller(c("F"="Female", "M"="Male"))) +
    scale_y_continuous(labels = comma) +
    scale_x_continuous(limits = c(0, 26000), breaks = seq(0, 25000, by=5000), labels = dollar_format()) +
    xlab("Purchase") + 
    ylab("The number of observation") +
    ggtitle("The distribution of purchase amount for each gender on Black Friday.") +
    theme_bw() +
    theme(plot.title = element_text(size = 13, face = "bold", hjust = 0.5))
  
  return (temp)
}

# call main funciton 
main()
