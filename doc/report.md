Black Friday Analysis
================
Gilber Lei and Mengda (Albert) Yu
2018 Nov 22

-   [1.0 Introduction](#introduction)
-   [2.0 Data source presentation](#data-source-presentation)
-   [3.0 Exploratory Data Analysis](#exploratory-data-analysis)
-   [4.0 Analysis](#analysis)
    -   [4.1 Estimation](#estimation)
    -   [4.2 Hypothesis Test](#hypothesis-test)
-   [5.0 Assumptions](#assumptions)
-   [6.0 Limitations and Future Directions](#limitations-and-future-directions)
-   [7.0 References](#references)

<style>
body {
text-align: justify}
</style>
1.0 Introduction
================

Black Friday is the name given to the shopping day after Thanksgiving. Many people go out to shop and spend a large amount of money. People might be curious about how male's purchase behavior on Black Friday differs from that of female. One specific question to ask is whether male and female spend the same amount on Black Friday. In this project, we will apply data analysis techniques and give an answer to this question.

2.0 Data source presentation
============================

The data set used in this project contains the transactions made in a retail store on Black Friday. It contains 12 features.

|  User\_ID| Product\_ID | Gender | Age  |  Occupation| City\_Category | Stay\_In\_Current\_City\_Years |  Marital\_Status|  Product\_Category\_1|  Product\_Category\_2|  Product\_Category\_3|  Purchase|
|---------:|:------------|:-------|:-----|-----------:|:---------------|:-------------------------------|----------------:|---------------------:|---------------------:|---------------------:|---------:|
|   1000001| P00069042   | F      | 0-17 |          10| A              | 2                              |                0|                     3|                    NA|                    NA|      8370|
|   1000001| P00248942   | F      | 0-17 |          10| A              | 2                              |                0|                     1|                     6|                    14|     15200|
|   1000001| P00087842   | F      | 0-17 |          10| A              | 2                              |                0|                    12|                    NA|                    NA|      1422|
|   1000001| P00085442   | F      | 0-17 |          10| A              | 2                              |                0|                    12|                    14|                    NA|      1057|
|   1000002| P00285442   | M      | 55+  |          16| C              | 4+                             |                0|                     8|                    NA|                    NA|      7969|

*Table 1. Black Friday raw data*

To perform our hypothesis test, we extract two features from the data set, One is `purchase`, which is quantitive and represents the purchase amount in dollars, and another is `gender`, which is categorical and has two possible values: male (M) and female (F).

| Gender |  Purchase|
|:-------|---------:|
| F      |      8370|
| F      |     15200|
| F      |      1422|
| F      |      1057|
| M      |      7969|

*Table 2. A tidy version of Black Friday data used in the porject*

3.0 Exploratory Data Analysis
=============================

Let's us start with initial investigations on the new data set so as to discover patterns and to test hypothesis with the help of visualizations.

![](../imgs/gender_bar.png)

*Figure 1. The number of female and male made purchase on Black Friday.*

We plot a bar plot to show the number of femal and male made purchases on Black Friday in this sample. As can be seen above, An aggregate of over 400,000 males made purchases on Black Friday, three times more than the number of female.

![](../imgs/purch_dist.png)

*Figure 2. The distribution of purchase amount with its mean on Black Friday.*

The histogram reveals that the amount of majority purchases made on Black Friday are centralized in a range from about $5,000 to $13,000. The mean purchase amount is around $10,000.

![](../imgs/gender_pur_hist.png)

*Figure 3. The distribution of purchase amount with mean for each gender on Black Friday.*

The shape of the distribution of purchase made by female on Black Friday is simliar to that made by male, with three main purchase ranges. The difference between the mean purchase of female and the mean purchase of male is not huge, but it does not provide convincing evidence that The mean purchase amount made by male is different than that made by female.

4.0 Analysis
============

The process of our analysis begins with the definition of null hypothesis and alternative hypothesis. The null hypothesis *H*<sub>0</sub> is the mean purchase amount made by male is not different than the mean purchase amount made by female, while the alternative hypothesis *H*<sub>1</sub> is the mean purchase amount made by male is different than the mean purchase amount made by female.

### 4.1 Estimation

We use the Central Limit Theorem (CLT) to calculate the standard error (SE) of the sample statistic of interest in order to estimate the mean of a population. The standard error is the standard deviation of the sampling distribution, which can be calculated by the following.

> SE = s/sqrt(n)

where *s* is the sample standard deviation and *n* is the number of observations in the sample.

We then apply a mathematical short cut to calculate the 95% confidence intervals around the sample mean. This is the plausible range for the true populaiton mean we are estimating.

> 95% confidence interval = point estimate +/- z \* SE

The multipliers (*z*) for the 95% confidence interval formula is the quantiles of 2.5% and 97.5%. The results are summarized below.

|   X1| Gender |  purchase\_mean|       n|        se|  lower\_95|  upper\_95|
|----:|:-------|---------------:|-------:|---------:|----------:|----------:|
|    1| F      |        8809.761|  132197|  12.98565|   8784.310|   8835.213|
|    2| M      |        9504.772|  405380|   7.93325|   9489.223|   9520.321|

*Table 3. The mean purchase amount with 95% confidence interval*

Next we plot the mean with 95% confidence interval for each gender in an error bar plot.

![](../imgs/errorbar.png)

*Figure 4. The mean purcahse amount with 95% confidene interval of female and male.*

The estimate for the population mean purchase amount made by femal is 8809.761 with a 95% confidence interval of 8784.310 and 8835.213. The estimate for the population mean purchase amount made by male is 9504.772 with a 95% confidence interval of 9489.223 and 9520.321. It should be noticed that the 95% confidence interval of our sample estimates are not overlapped. They are completely separated from each other. Therefore we get a sense of that we might not have evidence to claim the null hypothesis.

### 4.2 Hypothesis Test

We apply t-test to further investigate on whether the mean purchases are no different. The results of t-test are shown below.

|   X1|   estimate|  estimate1|  estimate2|  statistic|  p.value|  parameter|   conf.low|  conf.high| method                  | alternative |
|----:|----------:|----------:|----------:|----------:|--------:|----------:|----------:|----------:|:------------------------|:------------|
|    1|  -695.0104|   8809.761|   9504.772|  -45.67265|        0|   238457.3|  -724.8357|   -665.185| Welch Two Sample t-test | two.sided   |

*Table 4. The result of t-test.*

The t-statistic and the degree of freedom are -45.67 and 238457 respectively. We use them to plot a t-distribution. Since the sample size is large, the t-distribution produces similar results to those from the normal distribution.

![](../imgs/tdist.png)

*Figure 5. The t-distribution with t-statistic.*

The t-statistic is far away from the central of the distribution. The p-value is approximately 0, which is less than the alpha of 0.05 and indicates strong evidence against the null hypothesis. Therefore, we reject the null hypothesis and we cannot say that the mean purchase amount made by male is not different than the mean purchase amount made by female.

5.0 Assumptions
===============

In this project, we base our statistical inference on asymptotic theory. It means we assume the sample used in this project meets the two important conditions of the CLT.

Firstly, the sample is independent. To meet the independence condition, we consider two things. 1. The sample is random. As mentioned above, the data points in the data set come from the Black Friday sales records in a store. We assume all the purchases happened on Black Friday at this store is not significantly different from the purcahses happened at any other stores on Black Fridays in any other years. 2. The sample size is less than 10% of the population size. Since the sample contains only the sales data from one store in the United States, it must be less than 10% of the Black Friday sales in the United States.

Secondly, the sample size is big enough. Since the sample contains more than 500,000 data points, we believe it is a big enough sample.

6.0 Limitations and Future Directions
=====================================

Due to time constraint, we choose to work on the data set that is readily downloadable from Kaggle.com. We also limit our analysis on the means of male and female purchases. If we have more time to work on this project in the future, we believe we could improve our analysis in several aspects.

Firstly, we should improve the randomness of the sample. Our current sample includes only sales records from one store. It is prone to be biased. One way to improve that is to randomly select purchase records from different stores at different regions.

Secondly, after answering the question on whether male and female spend the same amounts on Black Friday, we may further analyze what male and female really bought, so as to get deeper insight into the different purchase behaviors between male and female.

7.0 References
==============

1.  [Black Friday analysis, Kaggle.com](https://www.kaggle.com/mehdidag/black-friday)
2.  [R for Data Science, by Grolemund & Wickham](https://r4ds.had.co.nz/introduction.html)
3.  [Introduction to asymptotic theory](https://github.ubc.ca/MDS-2018-19/DSCI_552_stat-inf-1_students/blob/master/lectures/06_lecture-intro-to-asymptotic-theory.ipynb)
