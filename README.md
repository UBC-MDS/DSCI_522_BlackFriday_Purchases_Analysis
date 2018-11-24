# Project: Black Friday Analysis

# Overview

This project is to analyze whether male and female make the same amount of purchase on Black Friday via a hypothesis test.

It follows the data analysis methodology shown below.  

<center><img src="imgs/data-science.png"> </center>
<center><i>Source: [R for Data Science](https://r4ds.had.co.nz/introduction.html) by Grolemund & Wickham</i></center>


This project repository includes data, scripts, documents and results.

# Team

__Instructor__ : Tiffany Timbers

__Teaching Assistant__ : Ali Mirza

| Name  | Slack Handle | Github.com | Link |
| :------: | :---: | :----------: | :---: |
| Gilbert Lei | `@Gilbert Lei` | `@gilbertlei` | [Gilbert's link](https://github.ubc.ca/mds-2018-19/DSCI_522_proposal_junxiong)|
| Mengda Yu | `@Mengda(Albert) Yu` | `@mru4913` | [Albert's link](https://github.com/mru4913/DSCI_522_BlackFriday_Analysis) |

# Data Source

The data set we use for this project is [BlackFriday.csv](https://www.kaggle.com/mehdidag/black-friday)(5 MB), which contains over 500 000 observations about the Black Friday sales in a retail store. It involves different kinds of numerical variables, such as `purchase`, and categorical variables, such as `gender`. This dataset is originally used for people to make a better understanding of customer purchase behaviour.

##### Acknowledgements

The data set is downloaded from Kaggle.com ([download link](https://www.kaggle.com/mehdidag/black-friday)). It
originally comes from a competition hosted by `Analytics Vidhya`.

---
To read the first 5 lines from `BlackFriday.csv`, we run the following script in R. The output is shown in below image.

```
Rscript src/00_read_raw_data.R data/BlackFriday.csv 5
```
![raw data](./imgs/read_raw_data_R.png)

# Dependencies

- R version 3.5.1
- R libraries
  - tidyverse, *manipulate and organize dataset*
  - ggplot2, *generate graphics*
  - scales, *scale tools for graphics*
  - broom, *tidy dataset*

# Project Objective

The data set contains the transactions made in a retail store on the Black Friday. We want to understand better the difference of the purchase behaviour between male and female. An inferential question to be addressed by this project:

Is the amount of purchase made by male different from that made by female during Black Friday?

# Analysis Plan

The original data set contains 12 columns or features. In our project, we will focus on two features. One is `Purchase`, which is quantitative and represents the purchase amount in dollars, and another is `Gender`, which is categorical and has two possible values: M (male) and F (female).

To find an answer to the question, we will follow the standard hypothesis test process.

1. We will define our null and alternative hypotheses.
  - Null hypothesis $H_0$: The mean purchase amount made by male is not different from the mean purchase amount made by female.
  - Alternative hypothesis $H_1$: The mean purchase amount made by male is different from the mean purchase amount made by female.
2. We will compute a t-statistic that corresponds to the null hypothesis.
3. We will create a model of null hypothesis and plot a t-distribution, with degrees of freedom equal to the Welch approximation to the degrees of freedom.
4. We will observe where our statistic falls on this distribution and calculate a p-value.
5. Depends on the observation and the p-value, we will interpret the test and make a conclusion on whether to reject the null hypothesis or not. If the p-value is less than 0.05, then we will reject the null hypothesis. Otherwise we will fail to reject it. With that, we will know whether male and female spent the same amount on Black Friday.  

To assist our hypothesis test, we will also use the Central Limit Theorem to calculate the mean purchase amount of male and female with 95% confidence intervals. Next we will look into whether there is an overlap between the 95% confidence intervals of these two groups and draw a conclusion.

# Summary Presentation

A summary statement regarding the results of this project will include the following:

- A table to summarize the means and 95% confidence intervals of male and female purchases on Black Friday.  
- An error bar plot to show the 95% confidence intervals of male and female purchases.  
- A t distribution plot to show the distribution of the null hypothesis, with vertical lines to show 95% confidence interval and t-statistic.  

We will also comment on what we observe and make a conclusion on the results of our analysis.

# Procedure

The data analysis in this project comprises of 5 steps, including clearning data, visualizing data, analyzing data, generating results and generating a final report, as shown below chart.

![](imgs/procedure.png)

To process the data analysis, we run the following command in the `root` directory. We start with cleaning data via R script `01_clean_data.R`, which takes two arguments, a file path that points to the raw data and another file path that specifies where to store the output from the script. Then we do exploratory data analysis via R script `02_visualize_data.R`. This script loads the tidy data generated by the first script and generates a group of figures to show any patterns in the data set. In the third R script `03_analyze_data.R`, we base on asymptotic theory to calculate sampling estimates and run t-test. The results are stored in csv files in `results` folder. After that, we use `04_generate_final_result.R` to plot some figures to visualize these results and save these figures in `imgs` folder. In the end, we create a R Markdown file `report.Rmd` which includes all above mentioned information and could be rendered into a final report in .md format in `doc` folder.

This is how we should run these scripts step by step:
```
# step 1 clean data
Rscript src/01_clean_data.R data/BlackFriday.csv data/BlackFriday_tidy.csv

# step 2 run exploratory data analysis
Rscript src/02_visualize_data.R data/BlackFriday_tidy.csv imgs

# step 3 analyze data via t-test and CLT-based estimation
Rscript src/03_analyze_data.R data/BlackFriday_tidy.csv results

# step 4 make plots to visualize analysis results
Rscript src/04_generate_final_result.R results imgs

# step 5 Render Markdown file to generate project report
Rscript -e "rmarkdown::render('./doc/Report.Rmd', 'github_document')"
```

Or, we can run all scripts via a shell script.

```
bash run_all.sh
```
