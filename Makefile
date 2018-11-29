# Makefile
# author: Mengda (Albert) Yu and Gilbert Lei
# Date: 2018 Nov 28
# Purpose: This script is to create a fully automated data analysis pipeline.
#
#
# Example : make <Filenames or rules>

###################################################
### Run a specific
###################################################
# step 1 clean data
data/BlackFriday_tidy.csv : src/01_clean_data.R data/BlackFriday.csv
		Rscript $^  $@

# step 2 run exploratory data analysis
imgs/gender_bar.png imgs/purch_dist.png imgs/gender_pur_hist.png : src/02_visualize_data.R data/BlackFriday_tidy.csv
		Rscript $^ imgs

# step 3 analyze data via t-test and CLT-based estimation
results/blackfriday_est.csv results/t_test_result.csv : src/03_analyze_data.R data/BlackFriday_tidy.csv
		Rscript $^ results

# step 4 make plots to visualize analysis results
imgs/errorbar.png imgs/tdist.png : src/04_generate_final_result.R results/blackfriday_est.csv results/t_test_result.csv
		Rscript $< results imgs

# step 5 Render Markdown file to generate project report
doc/report.md : doc/Report.Rmd imgs/gender_bar.png imgs/purch_dist.png imgs/gender_pur_hist.png results/blackfriday_est.csv results/t_test_result.csv imgs/errorbar.png imgs/tdist.png
		Rscript -e "rmarkdown::render('./doc/Report.Rmd', 'github_document')"


###################################################
### Run all targets
###################################################
.PHONY : all
all : doc/report.md

###################################################
### Remove all files
###################################################
.PHONY : clean
clean :
	rm -f data/BlackFriday_tidy.csv results/blackfriday_est.csv results/t_test_result.csv # all data files
	rm -f imgs/gender_bar.png imgs/purch_dist.png imgs/gender_pur_hist.png imgs/errorbar.png imgs/tdist.png # all figures
	rm -f doc/report.md doc/report.html

###################################################
### Remove reports rendered
###################################################
.PHONY : clean_report
clean_report :
	rm -f doc/report.md doc/report.html
