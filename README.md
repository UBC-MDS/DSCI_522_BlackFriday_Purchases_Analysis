# DSCI_522_BlackFriday_Analysis
Analyze the purchase made by male and female during Black Friday.

# Team
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
To read first 5 lines from `BlackFriday.csv` in `R`
```R
Rscript read_raw_data.R ../data/BlackFriday.csv 5
```
![raw data](./imgs/read_raw_data_R.png)

# Question
We are interested in knowing the difference between the purchases made by male and female during Black Friday, so the question we want to ask is whether male and female spent the same amount during Black Friday.  The question type is inferential. 

# Analysis Plan
To answer the question, we will follow the standard hypothesis testing process. Firstly, we will define our null and alternative hypotheses. Secondly, we will compute a test statistic that corresponds to the null hypothesis. Thirdly, we will use R's hypotheses test functions to generate a specified number of simulated test statistics. Fourthly, we will calculate p-value. Lastly, based on p-value, we make a conclusion on whether to reject the null hypothesis or not. With that, we will know whether male and female spent the same amount on Black Friday.  

# Summarization Plan
After all the analysis work done, we will present a p-value and with which we will draw a conclusion to the initial question.
