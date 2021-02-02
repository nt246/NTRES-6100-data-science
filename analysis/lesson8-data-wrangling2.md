---
title: "Lesson 8: Data Wrangling Part 2"
output: 
  html_document:
    keep_md: yes 
    toc: true
---



<br>

## Readings

#### Required: 

* Chapter 5.5-5.7 in [R for Data Science](https://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise) by Hadley Wickham & Garrett Grolemund

<br>

#### Other resources:

* The [Introduction to `dplyr` vignette](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)

* Jenny Bryan's lectures from STAT545 at UBC: [Introduction to dplyr](http://stat545.com/block009_dplyr-intro.html)

* Software Carpentry's R for reproducible scientific analysis materials: [Dataframe manipulation with dplyr](https://swcarpentry.github.io/r-novice-gapminder/13-dplyr/)

<br>

## Class announcements

* Updated [schedule](https://nt246.github.io/NTRES6940-data-science/syllabus.html#tentative_schedule): No class next Wednesday Oct 14 (in accordance with Cornell's academic calendar). The order of the following sessions have been shifted slightly
* Homework 3 due on Monday

<br>

## Learning objectives

Last class, we learned how to use `dplyr` functions

* `filter()` for subsetting data with row logic
* `select()` for subsetting data variable- or column-wise
* Use piping (`%>%`) to implement function chains

Today, we'll expand our data wrangling toolbox. By the end of today's class, you should be able to:

* Subset, rearrange, and summarize data with key `dplyr` functions:
  + Create new variables with functions of existing variables with `mutate()`
  + Reorder the rows with `arrange()`
  + Collapse many values down to a single summary with `summarize()` and `group_by()`
* Understand the basic differences between tidyverse and base R syntax



**Acknowledgements**: Today's lecture is adapted (with permission) from the excellent [Ocean Health Index Data Science Training](http://ohi-science.org/data-science-training/dplyr.html) with additional input from Jenny Bryan's lectures from STAT545 at UBC: [Introduction to dplyr](http://stat545.com/block009_dplyr-intro.html) and Grolemund and Wickham's [R for Data Science](https://r4ds.had.co.nz/transform.html).

<br>


<br>

## Getting set up a reloading the Coronavirus dataset
Let's jump back in where we left on Monday. Let's first clear out our workspace so we start with a fresh session by clicking "Session" -> "Restart R". Then let's open the R-script we were using to take notes, pull from GitHub to make sure we have the most recent version. You can use this script to type along as we're working through demos today (if you want, it's also fine to just watch). 

Today we'll also practice combining text and code in R Markdown files, so we'll do our in-class exercises in an R Markdown file. Do you remember how to create a new RMarkdown file? Go File -> New File -> R Markdown. Then change the output to GitHub document either as you're setting up the file or by manually editing the YAML header to say `output: github_document`. Now, delete the boilerplate text after the first setup code chunk and copy today's exercise questions into your document from [here](https://github.com/nt246/NTRES6940-data-science/blob/master/in_class_exercises/Oct7_exercises_wrangle2.md). As we work through the exercises, you will want to add a code chunk under each question to complete your answer.

Finally, load the Coronavirus dataset back in directly from the GitHub URL and see whether it has been updated - what is the latest date included?


```r
library(tidyverse)     ## install.packages("tidyverse")
```

```
## ── Attaching packages ───────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.2.1     ✓ purrr   0.3.3
## ✓ tibble  2.1.3     ✓ dplyr   0.8.3
## ✓ tidyr   1.0.0     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.4.0
```

```
## ── Conflicts ──────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(skimr)        ## install.packages("skimr")
```

```
## Warning: package 'skimr' was built under R version 3.6.2
```


```r
# read in corona .csv (don't worry for now about what the col_types parameter means, we'll discuss that next week)
coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv', col_types = cols(province = col_character()))
```

Let's remind ourselves of the data structure and content

```r
skim(coronavirus)
```


<br>

## Warm up - Exercise 1: Piping together `select()` and `filter()` commands

Subset the coronavirus dataset to only include the daily counts of confirmed cases in countries located above 60 degree latitude. What are those countries?

If you have time, pipe it into ggplot() to visualize the trends over time in these countries.

<br>

#### Answer

<details>
  <summary>click to expand</summary>


```r
# One way to do this:

coronavirus %>% 
  filter(lat > 60, type == "confirmed") %>% 
  select(country) %>% 
  table()
```
</details>

<br>
<br>
<br>

## `mutate()` adds new variables

Alright, let's keep going. 

Besides selecting sets of existing columns, it’s often useful to add new columns that are functions of existing columns. That’s the job of `mutate()`.

Visually, we are doing this (thanks RStudio for your [cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)): 

![](assets/rstudio-cheatsheet-mutate.png)

The current variables in the coronavirus dataset don't lend themselves well to cross-computation, so to illustrate the power of the `mutate()` function, let's reformat the dataset so that we get the counts of confirmed cases, deaths and recovered for each date and country in separate columns. The tidyverse has a very convenient function for making that kind of transformation. Don't worry about how it works right now, we'll get an opportunity to explore it in a few weeks.

For now, just copy the following code to summarize the total number of cases recorded by country and type (in the time period covered by this dataset: 2020-01-22 to 2020-11-09):


```r
coronavirus_ttd <- coronavirus %>% 
  select(country, type, cases) %>%
  group_by(country, type) %>%
  summarize(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type,
              values_from = total_cases) %>%
  arrange(-confirmed)

# Let's have a look at the structure of that new rearranged dataset
coronavirus_ttd
```

<br>

Imagine we want to compare the total death count to total the number of confirmed cases in each country. We can divide the case counts of `death` by `confirmed` to create a new column named `deathrate`. We do this with `mutate()` that is a function that defines and inserts new variables into a tibble. You can refer to existing variables diretly by name (i.e. without the `$` operator).


```r
coronavirus_ttd %>%
  mutate(deathrate = death / confirmed) 

# We can modify the mutate equation in many ways. For example, if we want to adjust the number of significant digits printed, we can type
coronavirus_ttd %>%
  mutate(deathrate = round(death / confirmed, 2)) 
```

Note, however, that these estimated death rates may be misleading and should be interpreted with due caution as testing strategies have varied a lot between countries (e.g. do asymptomatic people get tested). Also:

* The comparison of total counts of confirmed cases and deaths in different countries is not an apple to apple comparison, as the outbreak did not start at the same time in all the affected countries.
* As age plays a critical role in the probability of survival from the virus, we cannot make a comparison between different cases without having more demographic information.

<br>

### Your turn - Exercise 2

> Add a new variable that shows the *proportion of confirmed cases* for which the outcome is still unknown (i.e. not counted as dead or recovered) for each country and show only countries with more than 1 million confirmed cases. Which country has the lowest proportion of undetermined outcomes? Why might that be?
>
> When you're done, sync your RMarkdown file to Github.com (pull, stage, commit, push).

<br>

#### Answer
<details>
  <summary>click to expand</summary>


```r
coronavirus_ttd %>%
  mutate(undet = (confirmed - death - recovered) / confirmed) %>% 
  filter(confirmed > 1000000)
```
</details>

<br> 
<br>  
  
## `arrange()` orders rows

For examining the output of our previous calculations, we may want to re-arrange the countries in ascending order for the proportion of confirmed cases for which the outcome remains unknown. The `dplyr` function for sorting rows is `arrange()`. 


```r
coronavirus_ttd %>%
  mutate(undet = (confirmed - death - recovered)/confirmed) %>% 
  filter(confirmed > 1000000) %>% 
  arrange(undet)
```

I advise that your analyses NEVER rely on rows or variables being in a specific order. But it’s still true that human beings write the code and the interactive development process can be much nicer if you reorder the rows of your data as you go along. Also, once you are preparing tables for human eyeballs, it is imperative that you step up and take control of row order.

<br>
<br>

### Your turn - Exercise 3

> How many countries have suffered more than 100,000 deaths so far and which five countries have recorded the highest death counts?

#### Answer
<details>
  <summary>click to expand</summary>


```r
coronavirus_ttd %>%
  filter(death > 100000) %>% 
  arrange(-death)
```
</details>

<br>
<br>

### Your turn again - Exercise 4

>
> 1. Go back to our original dataset `coronavirus` and identify where and when the highest death count in a single day was observed. Hint: you can either use or `base::max` or `dplyr::arrange()`.  
> 1. The first case was confirmed in the US on [January 20 2020](https://www.nejm.org/doi/full/10.1056/NEJMoa2001191), two days before the earliest day included in this dataset. When was the first confirmed case recorded in Canada?
> 

<br>
<br>

#### Answer
<details>
  <summary>click to expand</summary>


```r
# Identifying the record with the highest death count
coronavirus %>% 
  filter(type == "death") %>% 
  arrange(-cases)

# We can also just identify the top hit 
coronavirus %>% 
  filter(type == "death") %>% 
  filter(cases == max(cases))

# The first recorded case in Canada
coronavirus %>% 
  filter(country == "Canada", cases > 0) %>% 
  arrange(date)
```
</details>

<br>

**Knit your RMarkdown file, and sync it to GitHub (pull, stage, commit, push)**

<br>
<br>

## Grouped summaries with `summarize()` and `group_by`

The last key `dplyr` verb is `summarize()`. It collapses a data frame to a single row. Visually, we are doing this (thanks RStudio for your [cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)): 
 
![](assets/rstudio-cheatsheet-summarise.png)

We can use it to calculate the total number of confirmed cases detected globally since 1-22-2020 (the beginning of this dataset)

```r
coronavirus %>% 
  filter(type == "confirmed") %>% 
  summarize(sum = sum(cases))
```

<br>

This number could also easily have been computed with base-R functions. In general, `summarize()` is not terribly useful unless we pair it with `group_by()`. This changes the unit of analysis from the complete dataset to individual groups. Then, when you use the `dplyr` verbs on a grouped data frame they’ll be automatically applied “by group”. For example, if we applied exactly the same code to a data frame grouped by country, we get the total number of confirmed cases for each country or region.


```r
coronavirus %>% 
  filter(type == "confirmed") %>%
  group_by(country) %>% 
  summarize(total_cases = sum(cases))
```
Now that's a lot more useful!

<br>
<br>

We can also use `summarize()` to check how many observations (dates) we have for each country


```r
coronavirus %>% 
  filter(type == "confirmed") %>%
  group_by(country) %>% 
  summarize(n = n())
```

<br>

Why do some countries have much higher counts than others?

<br>

We can also do multi-level grouping. If we wanted to know how many of each type of case there were globally on Monday we could chain these functions together:

```r
coronavirus %>% 
  group_by(date, type) %>% 
  summarize(total = sum(cases)) %>%  # sums the count across countries
  filter(date == "2020-10-04")
```

<br>
<br>

## Your turn - Exercise 5
Which day has had the highest total death count globally so far?

<br>

Pipe your global daily death counts into ggplot to visualize the trend over time.

<br>
<br>

#### Answer
<details>
  <summary>click to expand</summary>


```r
coronavirus %>% 
  filter(type == "death") %>% 
  group_by(date) %>% 
  summarize(total_deaths = sum(cases)) %>% 
  arrange(-total_deaths)

# Or

coronavirus %>% 
  filter(type == "death") %>% 
  group_by(date) %>% 
  summarize(total_deaths = sum(cases)) %>% 
  filter(total_deaths == max(total_deaths))

# With plotting

coronavirus %>% 
  filter(type == "death") %>% 
  group_by(date) %>% 
  summarize(total_deaths = sum(cases)) %>% 
  arrange(-total_deaths) %>% 
  ggplot() +
    geom_line(aes(x = date, y = total_deaths))
```
</details>

<br>
<br>

## If you have more time, here is an optional question

The `month()` function from the package `lubridate` extracts the month from a date. How many countries already have more than 1000 deaths in October?

<br>
<br>

#### Answer
<details>
  <summary>click to expand</summary>


```r
library(lubridate) #install.packages('lubridate')

coronavirus %>% 
  mutate(month = month(date)) %>% 
  filter(type == "death", month == 10) %>% 
  group_by(country) %>% 
  summarize(total_death = sum(cases)) %>% 
  filter(total_death > 1000)
```
</details>

<br>
<br>

## Extra in-class questions

<br>

#### Which country had the highest number of deaths on Monday (October 4 2020)?
<br>

**Answer**
<details>
  <summary>click to expand</summary>


```r
coronavirus %>% 
  select(-lat, -long) %>% 
  filter(date == "2020-10-04", type == "death") %>% 
  arrange(-cases)
```
</details>
<br>
<br>

#### Which country had the highest count of confirmed cases in January? [Hint: to address this question the function month() from the package lubridate might be helpful]. What about in March?
<br>

**Answer**
<details>
  <summary>click to expand</summary>


```r
library(lubridate) #install.packages('lubridate')

coronavirus %>% 
  mutate(month = month(date)) %>% 
  filter(type == "confirmed", month == 1) %>% 
  group_by(country) %>% 
  summarize(total_death = sum(cases)) %>% 
  arrange(-total_death)
```
</details>
<br>
If you're used to working in base R, answer the same question with base R tools. Which coding approach do you like better or what are pros and cons of the two types of syntax? 

<br>
<br>

#### Which countries have data for multiple states or provinces?

<br>

**Answer**
<details>
  <summary>click to expand</summary>


```r
coronavirus %>% 
  group_by(country, date) %>% 
  summarize(n = n()) %>% 
  group_by(country) %>% 
  summarize(maxcount = max(n)) %>% 
  filter(maxcount > 3)
```
</details>
<br>
<br>

#### Do all countries have reports of the number of confirmed cases for the same number of days?

<br>

**Answer**
<details>
  <summary>click to expand</summary>


```r
coronavirus %>% 
  filter(type == "recovered") %>% 
  group_by(country, province) %>% 
  summarize(n = n()) %>% 
  arrange(n) %>% 
  ggplot() +
    geom_histogram(aes(n))
```
</details>




