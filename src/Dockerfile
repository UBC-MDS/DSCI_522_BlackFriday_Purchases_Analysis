# Docker file for BlackFriday_analysis

###################################################
## author: Mengda (Albert) Yu and Gilbert Lei
## Date: 2018 Dec 05
## Purpose:
##
##
###################################################

# use rocker/tidyverse as the base image and
FROM rocker/tidyverse

# Install the R packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
    tidyverse \
    ggplot2 \
    scales \
    broom \
    testthat
