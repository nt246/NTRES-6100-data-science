Assignment 1: R markdown template
================

## Instructions: Please read through this before you begin

- This assignment is due by **10pm on Thursday 02/02/22**.

- For this assignment, please **reproduce this markdown file exactly as
  shown** using R markdown (including this list of instructions). You do
  **NOT** need to fill out the code chunks (i.e. answer the questions)
  for this assignment. We are just practicing markdown formatting right
  now.

- Please name your R markdown file `assignment_1.Rmd` and the knitted
  markdown file `assignment_1.md`.

- Pay attention to all the formatting in this file, including bullet
  points, bold characters, inserted code chunks, headings, text colors,
  blank lines, and etc. You will need to reproduce all of these.

- You will use the product of this assignment as a template for your
  fourth assignment, where you will actually fill out the code chunks.

- You will have to submit your assignment through GitHub. You can
  complete your template after Thursday’s class (1/26/2023), but don’t
  worry about submitting it until after we have gone over how to submit
  it through GitHub in next Tuesday’s class (1/31/2023). To do so, you
  will first move `assignment_1.Rmd` and `assignment_1.md` to the
  `problem_sets` folder in your own GitHub repository that you have
  created in class through GitHub Classroom. (If you haven’t created
  this repo yet, please use the following url:
  <https://classroom.github.com/a/cKaU744y>). Then, you can stage these
  files, make a commit, and push the commit.

## Load packages

To start, load all the required packages with the following code.
Install them if they are not installed yet.

``` r
library(tidyverse)
library(knitr)
```

<br>

## Exercise 1. Corruption and human development

This exercise explores a dataset containing the human development index
(`HDI`) and corruption perception index (`CPI`) of 173 countries across
6 different regions around the world: Americas, Asia Pacific, Eastern
Europe and Central Asia (`East EU Cemt`), Western Europe
(`EU W. Europe`), Middle East and North Africa and Noth Africa (`MENA`),
and Sub-Saharan Africa (`SSA`). (Note: the larger `CPI` is, the less
corrupted the country is perceived to be.)

<br>

First, we load the data using the following code.

``` r
economist_data <- read_csv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/EconomistData.csv")
```

<br>

#### 1.1 Show the first few rows of `economist_data`.

``` r
## Write your code here
```

<br>

#### 1.2 Expore the relationship between human development index (`HDI`) and corruption perception index (`CPI`) with a scatter plot as the following.

``` r
## Write your code here
```

<br>

#### 1.3 Make the color of all points in the previous plot red.

``` r
## Write your code here
```

<br>

#### 1.4 Color the points in the previous plot according to the `Region` variable, and set the size of points to 2.

``` r
## Write your code here
```

<br>

#### 1.5 Set the size of the points proportional to `HDI.Rank`

``` r
## Write your code here
```

<br>

#### 1.6 Fit a **smoothing line** to **all** the data points in the scatter plot from Excercise 1.4

``` r
## Write your code here
```

<br>

#### 1.7 Fit a separate **straight line** for **each region** instead, and turn off the confidence interval.

``` r
## Write your code here
```

<br>

#### 1.8 Building on top of the previous plot, show each `Region` in a different facet.

``` r
## Write your code here
```

<br>

#### 1.9 Show the distribution of `HDI` in each region using density plot. Set the transparency to 0.5

``` r
## Write your code here
```

<br>

#### 1.10 Show the distribution of `HDI` in each region using histogram and facetting.

``` r
## Write your code here
```

<br>

#### 1.11 Show the distribution of `HDI` in each region using a box plot. Set the transparency of these boxes to 0.5 and do not show outlier points with the box plot. Instead, show all data points for each country in the same plot. (Hint: `geom_jitter()` or `position_jitter()` might be useful.)

``` r
## Write your code here
```

<br>

#### 1.12 Show the count of countries in each region using a bar plot.

``` r
## Write your code here
```

<br>

#### 1.13 You have now created a variety of different plots of the same dataset. Which of your plots do you think are the most informative? Describe briefly the major trends that you see in the data.

Answer: *Write your response here*.

<br> <br>

## Exercise 2. Theophylline experiment

This exercise uses the `Theoph` data frame (comes with your R
installation), which has 132 rows and 5 columns of data from an
experiment on the pharmacokinetics of the anti-asthmatic drug
theophylline. Twelve subjects were given oral doses of theophylline then
serum concentrations were measured at 11 time points over the next 25
hours. You can learn more about this dataset by running `?Theoph`

Have a look at the data structure

``` r
## Write your code here
```

<br>

For the following exercise, **transform the data as instructed**. Try to
use `tidyverse` functions even if you are more comfortable with base-R
solutions. Show the **first 6 lines** of the transformed data in a table
through RMarkdown **using the kable() function**, as shown above.

#### 2.1 Select columns that contain a lower case “t” in the `Theoph` dataset. Do not manually list all the columns to include.

``` r
## Write your code here
```

<br>

#### 2.2 Rename the `Wt` column to `Weight` and `conc` column to `Concentration` in the `Theoph` dataset.

``` r
## Write your code here
```

<br>

#### 2.3 Extract the `Dose` greater than 4.5 and `Time` greater than the mean `Time`.

``` r
## Write your code here
```

<br>

#### 2.4 Sort the `Theoph` dataset by `Wt` from smallest to largest and secondarily by Time from largest to smallest.

``` r
## Write your code here
```

<br>

#### 2.5 Create a new column called `Quantity` that equals to `Wt` x `Dose` in the `Theoph` dataset. This will tell you the absolute quantity of drug administered to the subject (in mg). Replace the `Dose` variable with `Quantity`.

``` r
## Write your code here
```

<br>

#### 2.6 Find the mean `conc` and sum of the `Dose` received by each test subject.

Show data for the 6 subjects with the smallest sum of `Dose` as below.
**Do not define new intermediate objects for this exercise; use pipes to
chain together functions.**

``` r
## Write your code here
```

<br>

## Exercise 3. Unemployment in the US 1967-2015 (**OPTIONAL**)

This excercise uses the dataset `economics` from the ggplot2 package. It
was produced from US economic time series data available from
<http://research.stlouisfed.org/fred2>. It descibes the number of
unemployed persons (`unemploy`), among other variables, in the US from
1967 to 2015.

``` r
head(economics) %>% kable()
```

| date       |   pce |    pop | psavert | uempmed | unemploy |
|:-----------|------:|-------:|--------:|--------:|---------:|
| 1967-07-01 | 506.7 | 198712 |    12.6 |     4.5 |     2944 |
| 1967-08-01 | 509.8 | 198911 |    12.6 |     4.7 |     2945 |
| 1967-09-01 | 515.6 | 199113 |    11.9 |     4.6 |     2958 |
| 1967-10-01 | 512.2 | 199311 |    12.9 |     4.9 |     3143 |
| 1967-11-01 | 517.4 | 199498 |    12.8 |     4.7 |     3066 |
| 1967-12-01 | 525.1 | 199657 |    11.8 |     4.8 |     3018 |

<br>

#### 3.1 Plot the trend in number of unemployed persons (`unemploy`) though time using the economics dataset shown above. And for this question only, **hide your code and only show the plot**.

``` r
## Write your code here
```

<br>

#### 3.2 Edit the plot title and axis labels of the previous plot appropriately. Make y axis start from 0. Change the background theme to what is shown below. (Hint: search for help online if needed)

``` r
## Write your code here
```

<br>
