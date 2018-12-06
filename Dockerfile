# Docker file for BlackFriday_analysis

###################################################
## author: Gilbert Lei and Mengda (Albert) Yu
## Date: 2018 Dec 05
## Purpose: This Docker file is used to build a docker image with R packages/dependencies
##         for the project
##
##
###################################################

# Create from a base image
FROM rocker/tidyverse

# Install extra R packages 
RUN R -e "install.packages('broom')"
RUN R -e "install.packages('scales')"
RUN R -e "install.packages('testthat')"
