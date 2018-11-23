#! /usr/bin/env python

###################################################
## Project: BF_purchase_analysis.R
## Date: 2018 Nov 
## Author: Mengda (Albert) Yu [aut cre] and Gilbert Lei [ctb]
## Script purpose: This script is to read in the analysis result and generate 
##              a summary figure and a hypothesis distribution. It take two arguments
##              a path prefix pointing to the data and a path prefix where to save the figures
## Example: Rscript src/generate_final_result.R results imgs
##################################################

# libraries
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(scales))

# define main function
main <- function() {

  # read arguments from commend line
  args <- commandArgs(trailingOnly = TRUE)
  in_file_prefix <- args[1]
  out_file_prefix <- args[2]
  
  # in_file_prefix <- "results"
  # out_file_prefix <- "imgs"
  
  # read in data
  bf_est_path <- paste(in_file_prefix, "blackfriday_est.csv", sep = '/')
  bf_est <- suppressWarnings(suppressMessages(read_csv(bf_est_path)))
  t_test_result_path <- paste(in_file_prefix, "t_test_result.csv", sep = '/')
  t_test_result <- suppressWarnings(suppressMessages(read_csv(t_test_result_path)))
  
  # create plot
  errorbar <- plot_errorbar(bf_est)
  tdist <- plot_tdist(t_test_result)
  
  # save the figures
  ggsave("errorbar.png", plot = errorbar, path = out_file_prefix,
         width = 8, height = 5)
  ggsave("tdist.png", plot = tdist, path = out_file_prefix,
         width = 8, height = 5)
  
  cat("Generating...Complete!\n")
}

# plot errorbar show the 95% confidence intervals and mean for each gender
plot_errorbar <- function(bf_est) {
  
  errorbar <-
    bf_est %>% 
    ggplot() +
    geom_point(aes(x = Gender, y = purchase_mean), color = "red") +
    geom_errorbar(aes(x = Gender, ymin = lower_95, ymax = upper_95), 
                  colour = "blue") +
    scale_y_continuous(labels = dollar_format()) +
    scale_x_discrete(labels = c("Female", "Male")) +
    xlab("Gender") + 
    ylab("The amount of purchase") +
    ggtitle("The mean purchase with 95% confidence interval of female and male") +
    theme_bw() +
    theme(plot.title = element_text(size = 15, face = "bold", hjust = 0.5))
    
  return (errorbar)
}

# plot t distribution and t-statistic
plot_tdist <- function(t_test_result){
  
  tdist<- 
    ggplot(data.frame(x = c(-4, 4)), aes(x = x)) +
    stat_function(fun = dt, args = list(df = t_test_result$parameter), 
                 lwd = 0.7) +
    geom_vline(xintercept = t_test_result$statistic, color = "red", linetype = 'dashed') +
    annotate("text", x = -40, y = 0.25, size = 3.5, 
             label= paste("t-statistic\n", round(t_test_result$statistic, 2))) +
    xlim(c(-47, 15)) +
    ylab("density") +
    xlab("") +
    ggtitle("The T distribution under the null hypothesis H_0") +
    theme_bw() +
    theme(plot.title = element_text(size = 15, face = "bold", hjust = 0.5),
          axis.title.y = element_text(face = "bold"))
  
   return (tdist)
}

# call main function
main()

