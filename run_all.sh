# test.sh

###################################################
## Date: 2018 Nov 22
## Author: Mengda (Albert) Yu [aut cre] and Gilbert Lei [ctb]
## Script purpose: NULL
## Usage: bash run_all.sh
##################################################

# step 1
Rscript src/01_clean_data.R data/BlackFriday.csv data/BlackFriday_tidy.csv

# step 2 
Rscript src/02_visualize_data.R data/BlackFriday_tidy.csv imgs

# step 3
Rscript src/03_analyze_data.R data/BlackFriday_tidy.csv results

# step 4
Rscript src/04_generate_final_result.R results imgs

# step 5 make report
Rscript -e "rmarkdown::render('./doc/report.Rmd')"