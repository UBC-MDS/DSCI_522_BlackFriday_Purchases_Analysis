# Docker file for BlackFriday_analysis

###################################################
## author: Gilbert Lei and Mengda (Albert) Yu
## Date: 2018 Dec 05
## Purpose: This Docker file is used to build a docker image with R packages/dependencies
##         for the project
##
## Example : docker pull mru4913/dsci_522_blackfriday_purchases_analysis
##           docker run --rm -v <PATH_ON_YOUR_COMPUTER>:/home/data_analysis mru4913/dsci_522_blackfriday_purchases_analysis make -C '/home/data_analysis' all
###################################################

# Create from a base image
FROM rocker/tidyverse

# Install extra R packages
RUN R -e "install.packages('broom')"
RUN R -e "install.packages('scales')"
RUN R -e "install.packages('testthat')"

# From Tiffany's Docker file https://hub.docker.com/r/ttimbers/makefile2graph/~/dockerfile/

# install graphviz
RUN apt-get install -y graphviz

# clone, build makefile2graph,
# then copy key makefile2graph files to usr/bin so they will be in $PATH
RUN git clone https://github.com/lindenb/makefile2graph.git

RUN make -C makefile2graph/.

RUN cp makefile2graph/makefile2graph usr/bin
RUN cp makefile2graph/make2graph usr/bin
