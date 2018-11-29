# Makefile
# author: Mengda (Albert) Yu and Gilbert Lei
# Date: 2018 Nov 28
# Purpose:
#
#
# Example : make <Filename>

###################################################
### Run a specific
###################################################
# step 1 clean data
data/BlackFriday_tidy.csv : data/BlackFriday.csv src/01_clean_data.R
		Rscript src/01_clean_data.R data/BlackFriday.csv data/BlackFriday_tidy.csv

# step 2 run exploratory data analysis
imgs/gender_bar.png imgs/purch_dist.png imgs/gender_pur_hist.png : data/BlackFriday_tidy.csv src/02_visualize_data.R
		Rscript src/02_visualize_data.R data/BlackFriday_tidy.csv imgs

# step 3 analyze data via t-test and CLT-based estimation
results/blackfriday_est.csv results/t_test_result.csv : data/BlackFriday_tidy.csv src/03_analyze_data.R
		Rscript src/03_analyze_data.R data/BlackFriday_tidy.csv results

# step 4 make plots to visualize analysis results
imgs/errorbar.png imgs/tdist.png : results/blackfriday_est.csv results/t_test_result.csv src/04_generate_final_result.R
		Rscript src/04_generate_final_result.R results imgs

# step 5 Render Markdown file to generate project report
doc/report.md : doc/Report.Rmd imgs/gender_bar.png imgs/purch_dist.png imgs/gender_pur_hist.png results/blackfriday_est.csv results/t_test_result.csv imgs/errorbar.png imgs/tdist.png
		Rscript -e "rmarkdown::render('./doc/Report.Rmd', 'github_document')"


###################################################
### Run all targets
###################################################
all : doc/report.md

###################################################
### Remove all files
###################################################
clean :
	rm -f data/BlackFriday_tidy.csv results/blackfriday_est.csv results/t_test_result.csv # all data files
	rm -f imgs/gender_bar.png imgs/purch_dist.png imgs/gender_pur_hist.png imgs/errorbar.png imgs/tdist.png # all figures
	rm -f doc/report.md doc/report.html
