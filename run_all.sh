# run_all.sh

###################################################
## Date: 2018 Nov 22
## Author: Mengda (Albert) Yu [aut cre] and Gilbert Lei [ctb]
## Script purpose: This driver script completes the data analysis of the project.
##                 This script takes no arguments.
## Usage: bash run_all.sh
##################################################

# step 1, clean data and generate tidy data set
Rscript src/01_clean_data.R data/BlackFriday.csv data/BlackFriday_tidy.csv

# step 2, run exploratory data analysis and save three plots
Rscript src/02_visualize_data.R data/BlackFriday_tidy.csv imgs

# step 3, run CLT-based estimation and hypothesis test,
# save analysis results into two csv files
Rscript src/03_analyze_data.R data/BlackFriday_tidy.csv results

# step 4, make plots to visualize analysis results
Rscript src/04_generate_final_result.R results imgs

# step 5, Render R Markdown file to generate project report
Rscript -e "rmarkdown::render('./doc/Report.Rmd', 'github_document')"
