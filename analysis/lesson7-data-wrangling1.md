---
title: "Lesson 7: Data Wrangling Part 1"
output: 
  html_document:
    keep_md: yes 
    toc: true
---



<br>

## Readings

#### Required: 

Chapter 5.1-5.5 in [R for Data Science](https://r4ds.had.co.nz/transform.html) by Hadley Wickham & Garrett Grolemund

<br>

#### Other resources:

* The [Introduction to `dplyr` vignette](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)

* Jenny Bryan's lectures from STAT545 at UBC: [Introduction to dplyr](http://stat545.com/block009_dplyr-intro.html)

* Software Carpentry's R for reproducible scientific analysis materials: [Dataframe manipulation with dplyr](https://swcarpentry.github.io/r-novice-gapminder/13-dplyr/)

<br>

## Class announcements  

* Assignment 1 has been graded - everyone received credit, good work! A few things to note:
  + Select **github_document** as your output format for assignments submitted through your class repo  
  + Getting used to formatting - remember to refer to the awesome [Rmarkdown cheatsheet](https://rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)  
  + Assignments (except #2) should be kept in the `problem_sets` directory of your class repo, please do not delete these files to allow us time to review them  
  + One student deleted Assn.1 from their repo before we could grade it, but version control saved the day! Delete with caution, but no need to fret if you need to recover deleted files  
* Assignment 2 (your collaborative website) is **due today by 10pm**  
* [Assignment 3](https://github.com/nt246/NTRES6940-data-science/blob/master/assignments/assignment_3.md) is now available and will be due by next Monday
* Cleaning up your accounts, proceed with caution  
  + Feel free to delete any test files or repos you made over the last few weeks
  + **DO NOT** delete your assignments, your class repo or your website repo
  + If you cloned your repo to your computer, you will have to delete your local copy in addition to deleting the repo on Github  
  
<br>

## Learning objectives for today's class

Now that we have explored some of the powerful ways `ggplot` lets us visualize data, let's take a step back and discuss tools to get data into the right format we need for downstream analysis. Often you’ll need to create some new variables or summaries, or maybe you just want to rename the variables or reorder the observations in order to make the data a little easier to work with.

<br>

> Data scientists, according to interviews and expert estimates, spend from 50 percent to 80 percent of their time mired in the mundane labor of collecting and preparing data, before it can be explored for useful information. - [NYTimes (2014)](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html)

<br>

By the end of today's class, you should be able to:

* Subset and rearrange data with key `dplyr` functions
  + Pick observations by their values `filter()`
  + Pick variables by their names `select()`
* Use piping (`%>%`) to implement function chains
* Make sure your RStudio working files are sync'ed to GitHub

<br>

**Acknowledgements**: Today's lecture is adapted (with permission) from the excellent [Ocean Health Index Data Science Training](http://ohi-science.org/data-science-training/dplyr.html) and Jenny Bryan's lectures from STAT545 at UBC: [Introduction to dplyr](http://stat545.com/block009_dplyr-intro.html).

<br>

## What is data wrangling?

What are some common things you like to do with your data? Maybe remove rows or columns, do calculations and maybe add new columns? This is called **data wrangling** ("the process of cleaning, structuring and enriching raw data into a desired format for better analysis in less time" by [one definition](https://www.trifacta.com/data-wrangling/). It's not data management or data manipulation: you **keep the raw data raw** and do these things programatically in R with the tidyverse.

We are going to introduce you to data wrangling in R first with the tidyverse. The tidyverse is a suite of packages that match a philosophy of data science developed by Hadley Wickham and the RStudio team. I find it to be a more straight-forward way to learn R. We will also show you by comparison what code will look like in "Base R", which means, in R without any additional packages (like the "tidyverse" package)  installed. I like David Robinson's blog post on the topic of [teaching the tidyverse first](http://varianceexplained.org/r/teach-hard-way).

For some things, base-R is more straightforward, and we'll show you that too.

<br>

### Taking notes

Just like last class, we'll keep practicing our GitHub/version control integration by pushing our notes onto our course repo. Please open the R Project that is associated with your class repository (the name should be `ntres-6940-YOUR_USERNAME` (replace YOUR_USERNAME with your GitHub user ID). Open an R-script or an RMarkdown file and save it within your `course-notes` subdirectory as `data_wrangling.R` [or whatever you want to call it]. Use this R-script type along in the examples we'll go through together today (if that works for you), and for your exercises. 

<br>

### Load `tidyverse` (which has `dplyr` inside)

In your R Markdown file, let's make sure we've got our libraries loaded. Write the following: 


```r
library(tidyverse)     ## install.packages("tidyverse")
```

This is becoming standard practice for how to load a library in a file, and if you get an error that the library doesn't exist, you can install the package easily by running the code within the comment (highlight `install.packages("tidyverse")` and run it).

<br>

## Coronavirus data set
As the COVID-19 crisis is at the forefront of everyone's minds at the moment, lets use a dataset tallying daily developments in recorded Coronavirus cases across the world, so that we can develop our data wrangling skills by exploring global patterns in the pandemic.

<br>

![](https://github.com/RamiKrispin/coronavirus/raw/master/man/figures/2019-nCoV-CDC-23312_without_background.png)

<br>

We will use a dataset compiled in the [`coronavirus` R package](https://github.com/RamiKrispin/coronavirus) developed by Rami Krispin. This package (hosted on GitHub) pulls raw data from the Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) Coronavirus repository and is frequently updated.

The compiled package is available to install like any other package from CRAN with `install.packages`. However, it keeps getting updated, so to make sure that we're always working with the most current version, we will import the dataset directly from GitHub. 

Let's first check when the `coronavirus.csv` file on the [coronavirus package GitHub page](https://github.com/RamiKrispin/coronavirus/tree/master/csv) was last updated.

If we click on the `coronavirus.csv` file, we'll see that it's too large to display on GitHub in data-view mode. We can read this data into R directly from GitHub, without downloading it. But we can't read this data in view-mode. We have to click on the **View raw** link in the view window. This displays it as the raw csv file, without formatting. 

Copy the url for raw data: 
https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv

Now, let's go back to RStudio. In our R Markdown, let's read this csv file and name the variable "coronavirus". We will use the `read_csv()` function from the `readr` package (part of the tidyverse, so it's already installed!). 


```r
# read in corona .csv
coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv', col_types = cols(province = col_character()))
```

For today, don't worry about why we need to specify the `col_types` argument - we will cover the details of data import functions in a few weeks.

Once we have the data loaded, let's start getting familiar with its content and format.

Let's inspect: 

```r
## explore the coronavirus dataset
coronavirus # this is super long! Let's inspect in different ways
```
<br>
 
Let's use `head` and `tail`: 

```r
head(coronavirus) # shows first 6
tail(coronavirus) # shows last 6
head(coronavirus, 10) # shows first X that you indicate
tail(coronavirus, 12) # guess what this does!
```

<br>

We can also see the `coronavirus` variable in RStudio's Environment pane (top right)

More ways to learn basic info on a data.frame. 

```r
names(coronavirus)
dim(coronavirus)    # ?dim dimension
ncol(coronavirus)   # ?ncol number of columns
nrow(coronavirus)   # ?nrow number of rows
```

<br>

A statistical overview can be obtained with `summary()`, or with `skimr::skim()`

```r
summary(coronavirus)

# If we don't already have skimr installed, we will need to install it
# install.packages('skimr')
library(skimr)  # install.packages("skimr")
skim(coronavirus)
```

<br>

### Look at the variables inside a data.frame

To specify a single variable from a data.frame, use the dollar sign `$`. The `$` operator is a way to extract of replace parts of an object — check out the help menu for `$`. It's a common operator you'll see in R. 


```r
coronavirus$cases # very long! hard to make sense of...
head(coronavirus$cases) # can do the same tests we tried before
str(coronavirus$cases) # it is a single numeric vector
summary(coronavirus$cases) # same information, formatted slightly differently
```

<br>

## `dplyr` basics

OK, so let's start wrangling with dplyr.

There are five `dplyr` functions that you will use to do the vast majority of data manipulations:

- **`filter()`**: pick observations by their values

  <!--html_preserve--><img src="assets/rstudio-cheatsheet-filter.png" width="300"/><!--/html_preserve--> 
    
- **`select()`**: pick variables by their names

  <!--html_preserve--><img src="assets/rstudio-cheatsheet-select.png" width="300"/><!--/html_preserve-->
    
- **`mutate()`**: create new variables with functions of existing variables 

  <!--html_preserve--><img src="assets/rstudio-cheatsheet-mutate.png" width="300"/><!--/html_preserve-->
  
- **`arrange()`**: reorder the rows

- **`summarise()`**: collapse many values down to a single summary 

  <!--html_preserve--><img src="assets/rstudio-cheatsheet-summarise.png" width="300"/><!--/html_preserve-->
  
  
These can all be used in conjunction with `group_by()` which changes the scope of each function from operating on the entire dataset to operating on it group-by-group. These six functions provide the verbs for a language of data manipulation. **We will cover at least the first two today and continue with the rest on Wednesday.**

<br>

All verbs work similarly:

1. The first argument is a data frame.
2. The subsequent arguments describe what to do with the data frame. You can refer to columns in the data frame directly without using `$`.
3. The result is a new data frame.

Together these properties make it easy to chain together multiple simple steps to achieve a complex result.

<br>
<br>

## `filter()` subsets data row-wise (observations).

You will want to isolate bits of your data; maybe you want to only look at a single country or a few years. R calls this subsetting. 

`filter()` is a function in `dplyr` that takes logical expressions and returns the rows for which all are `TRUE`. 

Visually, we are doing this (thanks RStudio for your [cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)): 

![](assets/rstudio-cheatsheet-filter.png)
Remember your logical expressions? If not, here is a reminder [here](https://www.statmethods.net/management/operators.html#Logical). We’ll use `>` and `==` here. 


```r
filter(coronavirus, cases > 0)
```

You can say this out loud: "Filter the coronavirus data for cases greater than 0". Notice that when we do this, all the columns are returned, but only the rows that have the a non-zero case count. We've subsetted by row.

Let's try another: "Filter the coronavirus data for the country US".


```r
filter(coronavirus, country == "US")
```

Note that when you run that line of code, `dplyr` executes the filtering operation and returns a new data frame. `dplyr` functions never modify their inputs, so if you want to save the result, you’ll need to use the assignment operator, `<-`:


```r
coronavirus_us <- filter(coronavirus, country == "US")
```

<br>

How about if we want two country names? We can't use a single instance of the `==` operator here, because it can only operate on one thing at a time. We can use [Boolean operators](https://r4ds.had.co.nz/transform.html#logical-operators) for this: `&` is “and”, `|` is “or”, and `!` is “not”. So if we want records from both the US and Canada, we can type


```r
filter(coronavirus, country == "US" | country == "Canada")
```

A useful short-hand for this problem is `x %in% y`. This will select every row where `x` is one of the values in `y`. We could use it to rewrite the code above:


```r
filter(coronavirus, country %in% c("US", "Canada"))
```

How about if we want only the death counts in the US? You can pass filter different criteria:


```r
# We can use either of these notations:
filter(coronavirus, country == "US", type == "death")
filter(coronavirus, country == "US" & type == "death")
```

<br>
<br>

## Your turn - Exercise 1

> **1a:** What is the total number of deaths in the US reported in this dataset up to now?   
> Hint: You can do this in 2 steps by assigning a variable and then using the `sum()` function.
>
>
> **1b:** Subset the data to only show the death counts in three European countries yesterday.

> Then, sync to Github.com (pull, stage, commit, push).

<br>

#### Answer (no peeking!)

This is one way to do it based on what we have learned so far:

**Question 1a:**

```r
x <- filter(coronavirus, country == "US", type == "death")  
sum(x$cases)

# Also, remember that the output from filter() is a dataframe, so you can use the $ operator on the called function directly:

sum(filter(coronavirus, country == "US", type == "death")$cases)
```
<br>
**Question 1b:**

```r
#Example:

filter(coronavirus, country %in% c("Denmark", "Italy", "Spain"), type == "death", date == "2020-10-04")
```


<br>
<br>

## `select()` subsets data column-wise (variables)

We use `select()` to subset the data on variables or columns. 

Visually, we are doing this (thanks RStudio for your [cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)): 

![](assets/rstudio-cheatsheet-select.png)

<br>

We can select multiple columns with a comma, after we specify the data frame (coronavirus). 


```r
select(coronavirus, date, country, type, cases) 
```

Note how the order of the columns also have been rearranged to match the order they are listed in the `select()` function.

We can also use `-` to deselect columns


```r
select(coronavirus, -lat, -long) # you can use - to deselect columns
```

<br>
<br>

### Your turn - Exercise 2

Create a new dataframe including only the country, lat, and long variables, listed in this order. Now make one listed in order lat, long, country.

<br>

In this case, we have very few variables that we can easily select one by one, but for datasets with lots of variables with standardized names, some of the built-in helper functions may be helpful, e.g.:


```r
select(coronavirus, country:long)
select(coronavirus, contains('o'))
select(coronavirus, ends_with('e'))


# Also, compare the output of these:
select(coronavirus, casetype = type)
select(coronavirus, casetype = type, everything())
rename(coronavirus, casetype = type)
```

<br>
<br>

## Use `select()` and `filter()` together

We've explored the functions `select()` and `filter()` separately. Now let's combine them and filter to retain only records for the US and remove the lat, long and province columns (because this dataset doesn't currently have data broken down by US state). We'll save this subsetted data as a variable. Actually, as two temporary variables, which means that for the second one we need to operate on `coronavirus_us`, not `coronavirus`. 


```r
coronavirus_us  <- filter(coronavirus, country == "US")
coronavirus_us2 <- select(coronavirus_us, -lat, -long, -province) 
```

We also could have called them both `coronavirus_us` and overwritten the first assignment. Either way, naming them and keeping track of them gets super cumbersome, which means more time to understand what's going on and opportunities for confusion or error.

Good thing there is an awesome alternative.

<br>

## Meet the new pipe `%>%` operator

Before we go any further, we should explore the new pipe operator that `dplyr` imports from the [`magrittr`](https://github.com/smbache/magrittr) package by Stefan Bache. If you have have not used this before, **this is going to change your life** (at least your coding life...). You no longer need to enact multi-operation commands by nesting them inside each other. And we won't need to make temporary variables like we did in the US example above. This new syntax leads to code that is much easier to write and to read: it actually tells the story of your analysis.

Here's what it looks like: `%>%`. The RStudio keyboard shortcut: Ctrl + Shift + M (Windows), Cmd + Shift + M (Mac).

Let's demo then I'll explain:

```r
coronavirus %>% head()
```

This is equivalent to `head(coronavirus)`. This pipe operator takes the thing on the left-hand-side and __pipes__ it into the function call on the right-hand-side. It literally drops it in as the first argument.

Never fear, you can still specify other arguments to this function! To see the first 3 rows of coronavirus, we could say `head(coronavirus, 3)` or this:

```r
coronavirus %>% head(3)
```

**I've advised you to think "gets" whenever you see the assignment operator, `<-`. Similarly, you should think "and then" whenever you see the pipe operator, `%>%`.**

One of the most awesome things about this is that you START with the data before you say what you're doing to DO to it. So above: "take the coronavirus data, and then give me the first three entries".

This means that instead of this:


```r
## instead of this...
coronavirus_us  <- filter(coronavirus, country == "US")
coronavirus_us2 <- select(coronavirus_us, -lat, -long, -province) 
## ...we can do this
coronavirus_us  <- coronavirus %>% filter(country == "US")
coronavirus_us2 <- coronavirus_us %>% select(-lat, -long, -province) 
```

So you can see that we'll start with coronavirus in the first example line, and then coronavirus_us in the second. This makes it a bit easier to see what data we are starting with and what we are doing to it.

...But, we still have those temporary variables so we're not truly that better off. But get ready to be majorly impressed:  

<br>

### Revel in the convenience

We can use the pipe to chain those two operations together:


```r
coronavirus_us  <- coronavirus %>% 
  filter(country == "US") %>%
  select(-lat, -long, -province) 
```

What's happening here? In the second line, we were able to delete `coronavirus_us2 <- coronavirus_us`, and put the pipe operator above. This is possible since we wanted to operate on the `coronavirus_us` data. And we weren't truly excited about having a second variable named `coronavirus_us2` anyway, so we can get rid of it. This is huge, because most of your data wrangling will have many more than 2 steps, and we don't want a `coronavirus_us17`!

By using multiple lines I can actually read this like a story and there aren't temporary variables that get super confusing. In my head: 

>"start with the `coronavirus` data, and then  
filter for the US, and then  
drop the variables lat, long, and province."
Being able to read a story out of code like this is really game-changing. We'll continue using this syntax as we learn the other `dplyr` verbs. 

Compare with some base R code to accomplish the same things. Base R requires subsetting with the [rows, columns] notation. This notation is something you’ll see a lot in base R. The brackets [ ] allow you to extract parts of an object. Within the brackets, the comma separates rows from columns.

If we don’t write anything after the comma, that means “all columns”. And if we don’t write anything before the comma, that means “all rows”.

Also, the $ operator is how you access specific columns of your dataframe.


```r
#There are many ways we could subset columns, here's one way:
coronavirus[coronavirus$country == "US", colnames(coronavirus) %in% c("lat", "long", "province")==FALSE] ## repeat `coronavirus`, [i, j] indexing is distracting.
```

<br>

##### Never index by blind numbers!

```r
#There are many ways we could subset columns, here's another (bad choice)
head(coronavirus)
coronavirus[coronavirus$country == "US", c(2, 5:7)] 
```

<br>

Why is this a terrible idea?

* It is not self-documenting. What are the columns were retaining here?
* It is fragile. This line of code will produce different results if someone changes the organization of the dataset, e.g. adds new variables. This is especially risky if we index rows by numbers as a sorting action earlier in the script would then give unexpected results. 


This call explains itself and is fairly robust.

```r
coronavirus_us  <- coronavirus %>% 
  filter(country == "US") %>%
  select(-lat, -long, -province) 
```

<br>
<br>

## Your turn - Exercise 3

Use the `%>%` piping function to subset the coronavirus dataset to only include the daily death counts in the US, Canada, and Mexico and including only the following variables in this order: `country`, `date`, `cases`.

Then combine your new data wrangling skills with the ggplot skills to covered last week visualize the how the daily death counts have changed over time in those three countries. Yes! You can pipe data into ggplot - try it!

If you have more time, try exploring other patterns in the data. Pick a different set of countries to display or show how the daily counts of confirmed cases, deaths and recoveries compare. 

<br>

**Knit your RMarkdown file, and sync it to GitHub (pull, stage, commit, push)**

<br>
<br>

## More ways to select columns

If we have time, we'll explore some [additional options for `select()`](https://r4ds.had.co.nz/transform.html#select)

<br>
<br>

**We will continue in the next class with learning more useful `dplyr` functions.**



