# Docker file for the Black Friday Purchase Analysis project
# Gilbert Lei & Albert Yu, Dec, 2018

FROM rocker/tidyverse

RUN R -e "install.packages('broom')"
RUN R -e "install.packages('scales')"
RUN R -e "install.packages('testthat')"
