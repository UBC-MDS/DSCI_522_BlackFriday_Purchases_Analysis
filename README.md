# Project: Black Friday Analysis

Analyze whether male and female make the same amount of purchase on the Black Friday.

# Team

__Instructor__ : Tiffany Timbers

__Teaching Assistant__ : Ali Mirza

| Name  | Slack Handle | Github.com | Link |
| :------: | :---: | :----------: | :---: |
| Gilbert Lei | `@Gilbert Lei` | `@gilbertlei` | [Gilbert's link](https://github.ubc.ca/mds-2018-19/DSCI_522_proposal_junxiong)|
| Mengda Yu | `@Mengda(Albert) Yu` | `@mru4913` | [Albert's link](https://github.com/mru4913/DSCI_522_BlackFriday_Analysis) |

# Data Source

The data set we use for this project is [BlackFriday.csv](https://www.kaggle.com/mehdidag/black-friday)(5 MB), which contains over 500 000 observations about the Black Friday in a retail store. It involves different kinds of numerical variables, such as `purchase`, and categorical variables, such as `gender`. This dataset is originally used for people to make a better understanding of customer purchase behaviour.

##### Acknowledgements

The data set is downloaded from Kaggle.com ([download link](https://www.kaggle.com/mehdidag/black-friday)). It
originally comes from a competition hosted by `Analytics Vidhya`.

---
To read first 5 lines from `BlackFriday.csv`, we run the following script in R.

```R
Rscript src/00_read_raw_data.R data/BlackFriday.csv 5
```
![raw data](./imgs/read_raw_data_R.png)

### Dependencies

- R version 3.5.1
- tidyverse, *manipulate and organize dataset*
- ggplot2, *generate graphics*
- scales, *scale tools for graphics*
- broom, *tidy dataset*

# Project Objective

The data set contains the transactions made in a retail store on the Black Friday. We want to understand better the difference of the purchase behaviour between male and female. A specific question to be addressed by this project:

Is the amount of purchase made by male different than that made by female during Black Friday?

This question is inferential.

# Analysis Plan

The data set contains 12 columns or features. Two main features are useful in our project. One is `purchase`, which is quantitive and represents the purchase amount in dollars, and another is `gender`, which is categorical and has two possible values: male (M) and female (F).

To answer the question, we will follow the standard hypothesis test process.

1. We will define our null and alternative hypotheses.
  - Null hypothesis $H_0$: The mean purchase amount made by male is not different than the mean purchase amount made by female.
  - Alternative hypothesis $H_1$: The mean purchase amount made by male is different than the mean purchase amount made by female.
2. We will compute a t-statistic that corresponds to the null hypothesis.
3. We will create a model of null hypothesis and plot a t-distribution, with degrees of freedom equal to the Welch approximation to the degrees of freedom.
4. We will observe where our statistic falls on this distribution and calculate a p-value.
5. Depends on the observation and the p-value, we will interpret the test and make a conclusion on whether to reject the null hypothesis or not. If the p-value is less than 0.05, then we will reject the null hypothesis. Otherwise we will fail to reject the null hypothesis. With that, we will know whether male and female spent the same amount on Black Friday.  

To assist our hypothesis test, we will also use the Central Limit Theorem to calculate the mean purchase amount of male and female with 95% confidence intervals. Next we will look into whether there is an overlap between the 95% confidence intervals of these two samples and draw a conclusion.

# Summary Presentation

A summary statement regarding the results of this project will include the following:

- A table to summarize the means and 95% confidence intervals of male and female purchases on Black Friday.  
- An error bar plot to show the 95% confidence intervals obtained from the two bootstrapping distributions.  
- A distribution plot to show the distribution of the null hypothesis, with vertical lines to represent 95% confidence interval and t-statistic.  

We will also comment on what we observe and make a conclusion on the results of our analysis.

# Project Execution

We followed the data analysis methodology shown in below to carry out the analysis work in this project.  
![](imgs/data-science.png)  
<i>Source: [R for Data Science](https://r4ds.had.co.nz/introduction.html) by Grolemund & Wickham</i>  

Firstly, we imported the original csv file into R and had a quick look at it so as to understand how it is organized.  

Secondly, we used a script to extract columns `Gender` and `Purchase` from the original data set and saved them into a new csv file.

Thirdly, based on the question we asked in this project, we defined our null hypothesis and alternative hypothesis. Then we run a t-test and saved the outputs into a csv file. At the same time, we used asymptotic theory to calculate the confidence intervals of the mean purchases made by male and female respectively and saved the results into another csv file.

Fourthly, using the output from the third step, we made a t-distribution plot and an error bar plot.

Lastly, we wrote our analysis report in a R Markdown file. 
