# DSCI_522_BlackFriday_Analysis

Analyze whether male and female make the same amount of purchase on the Black Friday.

# Team

__Instructor__ : Tiffany Timbers

__Teaching Assistant__ : Ali Mirza

| Name  | Slack Handle | Github.com | Link |
| :------: | :---: | :----------: | :---: |
| Gilbert Lei | `@Gilbert Lei` | `@gilbertlei` | [Gilbert's link](https://github.ubc.ca/mds-2018-19/DSCI_522_proposal_junxiong)|
| Mengda Yu | `@Mengda(Albert) Yu` | `@mru4913` | [Albert's link](https://github.com/mru4913/DSCI_522_BlackFriday_Analysis) |

# Data Source

The main data source for this project is.
  - [BlackFriday.csv](https://www.kaggle.com/mehdidag/black-friday)(5 MB), which is a dataset of over 500 000 observations about the Black Friday in a retail store. It involves different kinds of numerical and categorical variables for people to make a better understanding of customer purchase behaviour.

###### Acknowledgements

The data set comes from a competition hosted by `Analytics Vidhya`.

---
To read first 5 lines from `BlackFriday.csv`, you can run the following script in R.

```R
Rscript read_raw_data.R ../data/BlackFriday.csv 5
```
![raw data](./imgs/read_raw_data_R.png)

# Dependencies

- R version 3.5.1
  - tidyverse

# Objective

The data set contains the transactions made in a retail store on the Black Friday. We want to understand better the difference of the purchase behaviour between male and female. A specific question to be addressed by this project is whether the amount of purchase made by male is different than that made by female during Black Friday. This question is inferential.

# Analysis Plan

The data set contains 12 columns or features. Two main features are useful in our project, one for purchase amount in dollars `purchase` which is quantitive, and the other for gender `gender` which is categorical and has two possibilities male (M) and female (F).

To answer the question, we will follow the standard hypothesis test process.

1. We will define our null and alternative hypotheses.
  - Null hypothesis $H_0$: The mean purchase amount made by male is not different than the mean purchase amount made by female.
  - Alternative hypothesis $H_1$: The mean purchase amount made by male is different than the mean purchase amount made by female.
2. We will compute a test statistic that corresponds to the null hypothesis. A reasonable test statistic could be the difference between two means.
3. We will will use R's hypotheses test functions to generate a specified number of simulated test statistics based on a model of the null hypothesis and further generate a distribution of null hypothesis.
4. We will observe our test statistic from our sample(s) falls on this distribution and calculate a p-value.
5. Depends on the observation and the p-value, we will interpret the test and make a conclusion on whether to reject the null hypothesis or not. If the p-value is less than 0.05, then we will reject the null hypothesis. Otherwise we will fail to reject the null hypothesis. With that, we will know whether male and female spent the same amount on Black Friday.  

To assist our hypothesis test, we will also use bootstrapping technique to generate 10000 mean values for male's purchase and female's purchase respectively. We then will calculate the 95% confidence intervals for these two bootstrapping distributions. Lastly we will look into whether there is an overlap between the two confidence intervals and draw a conclusion.

# Summary Presentation

A summary statement regarding the results of this project includes the following.

- A table to summarize 95% confidence intervals of the bootstrapping distributions and means associated with gender
- An error bar plot to show the 95% confidence intervals obtained from the two bootstrapping distributions
- A histogram or rigeplot to show the distribution of the null hypothesis with a vertical line of p-value

We will also comment on what we observe and make a conclusion on the results of our test.
