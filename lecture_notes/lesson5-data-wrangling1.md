Lesson 5: Data Wrangling Part 1
================

<br>

## Readings

Chapter 5.1-5.5 in [R for Data
Science](https://r4ds.had.co.nz/transform.html) by Hadley Wickham &
Garrett Grolemund

<br>

## Class announcements

  - **Welcome to the online format\!**  
    Updated syllabus
    [here](https://github.com/nt246/NTRES6940-data-science)  
    Each class will be broken into two parts:
    
      - **Part A:** Pre-recorded lecture with exercises (~50 minutes,
        suggested time: Mondays and Wednesdays 4.20 - 5.10pm)
      - **Part B:** Live Zoom session for Q\&A and collaborative
        exercises (Mondays and Wednesdays 5.10 - 5.40pm) <br>  

  - Videos will be available through the [course Canvas
    site](https://canvas.cornell.edu/courses/14389). If you don’t have
    access let me know ASAP. <br>

  - Nicolas and Nina will be on Slack (`lecture-chat` channel or direct
    message) and on Zoom with a waiting room to address questions and
    help troubleshoot technical issues during the lecture period
    4.20-5.10pm Mondays and Wednesdays. You will need to be signed into
    Canvas to access the Zoom call <br>  

  - Feedback on the online format welcome\! Teaching online is
    completely new for us and we are very receptive to ideas for
    improvement
    
      - New `feedback-online-format` channel in Slack workspace

  - **Problem set 2 due at 10pm this Wednesday (04/08/20)**

<br>

## Learning objectives for today’s class

Now that we have explored some of the powerful ways `ggplot` lets us
visualize data, let’s take a step back and discuss tools to get data
into the right format we need for downstream analysis. Often you’ll need
to create some new variables or summaries, or maybe you just want to
rename the variables or reorder the observations in order to make the
data a little easier to work with.

<br>

> Data scientists, according to interviews and expert estimates, spend
> from 50 percent to 80 percent of their time mired in the mundane labor
> of collecting and preparing data, before it can be explored for useful
> information. - [NYTimes
> (2014)](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html)

<br>

By the end of today’s class, you should be able to:

  - Subset and rearrange data with key `dplyr` functions
      - Pick observations by their values `filter()`
      - Pick variables by their names `select()`
  - Make sure your RStudio working files are sync’ed to GitHub

<br>

**Acknowledgements**: Today’s lecture is adapted (with permission) from
the excellent [Ocean Health Index Data Science
Training](http://ohi-science.org/data-science-training/dplyr.html) and
Jenny Bryan’s lectures from STAT545 at UBC: [Introduction to
dplyr](http://stat545.com/block009_dplyr-intro.html). .

<br>

## What is data wrangling?

What are some common things you like to do with your data? Maybe remove
rows or columns, do calculations and maybe add new columns? This is
called **data wrangling** (“the process of cleaning, structuring and
enriching raw data into a desired format for better analysis in less
time” by [one definition](https://www.trifacta.com/data-wrangling/).
It’s not data management or data manipulation: you **keep the raw data
raw** and do these things programatically in R with the tidyverse.

We are going to introduce you to data wrangling in R first with the
tidyverse. The tidyverse is a suite of packages that match a philosophy
of data science developed by Hadley Wickham and the RStudio team. I find
it to be a more straight-forward way to learn R. We will also show you
by comparison what code will look like in “Base R”, which means, in R
without any additional packages (like the “tidyverse” package)
installed. I like David Robinson’s blog post on the topic of [teaching
the tidyverse first](http://varianceexplained.org/r/teach-hard-way).

For some things, base-R is more straight forward, and we’ll show you
that too. Whenever we use a function that is from the tidyverse, we will
prefix it so you’ll know for sure. <br>

### Setup

Throughout today’s class, we’ll explore functions, take notes, and do
our exercises in a new RMarkdown file, and to practice our GitHub
integration and version control, we will make sure our new R Markdown
working document gets sync’ed to our GitHub account.

**Here’s what to do:**

Before we start, open the R Project that you created earlier in the
course that is associated with your personal GitHub repository hosted
under the class organization (you can find the link to it
[here](https://classroom.github.com/a/SA7QIA7g). Your repo name should
be `therkildsen-class/ntres-6940-YOUR_USER_NAME`. If you followed the
instructions, your R Project linked to this account should be named
`ntres-6940-YOUR_USER_NAME`. If you can’t remember where you saved it on
your local computer, you can search for this (replace YOUR\_USER\_NAME
with your GitHub account name) on your computer. Click on the
`ntres-6940-YOUR_USER_NAME.Rproj` file.

Then

1.  If RStudio was already open, clear your workspace (Session \>
    Restart R)
2.  New File \> R Markdown…
3.  Save as `coronavirus-wrangle.Rmd` save it to your course notes
    folder within your GitHub-linked folder.
4.  Delete the irrelevant text and write a little note to yourself about
    how we’ll be wrangling coronavirus data using dplyr. Edit the title
    and change the output format to ‘github\_document’.

<br>

## Sync to GitHub

If you forgot the workflow, review
[lesson 3](https://github.com/nt246/NTRES6940-data-science/blob/master/lecture_notes/lesson3-version-control.md#sync-from-rstudio-local-to-github-remote).

<img src="../img/commit_steps.png" width="100%" />

<br>

### Load `tidyverse` (which has `dplyr` inside)

In your R Markdown file, let’s make sure we’ve got our libraries loaded.
Write the following:

``` r
library(tidyverse)     ## install.packages("tidyverse")
```

This is becoming standard practice for how to load a library in a file,
and if you get an error that the library doesn’t exist, you can install
the package easily by running the code within the comment (highlight
`install.packages("tidyverse")` and run it).

<br>

## Coronavirus data set

As the COVID-19 crisis is at the forefront of everyone’s minds at the
moment, lets use a dataset tallying daily developments in recorded
Coronavirus cases across the world, so that we can develop our data
wrangling skills by exploring global patterns in the pandemic.

We will use a dataset compiled in the [`coronavirus` R
package](https://github.com/RamiKrispin/coronavirus) developed by Rami
Krispin. This package (hosted on GitHub) pulls raw data from the Johns
Hopkins University Center for Systems Science and Engineering (JHU CCSE)
Coronavirus repository and is frequently updated.

The compiled package is available to install like any other package from
CRAN with `install.packages`. However, it keeps getting updated, so to
make sure that we’re always working with the most current version, we
will import the dataset directly from GitHub.

Let’s first check when the `coronavirus_dataset.csv` file on the
[coronavirus package GitHub
page](https://github.com/RamiKrispin/coronavirus-csv) was last updated.

If we click on the `coronavirus_dataset.csv` file, we’ll see that it’s
too large to display on GitHub in data-view mode. We can read this data
into R directly from GitHub, without downloading it. But we can’t read
this data in view-mode. We have to click on the **View raw** link in the
view window. This displays it as the raw csv file, without formatting.

Copy the url for raw data:
<https://raw.githubusercontent.com/RamiKrispin/coronavirus-csv/master/coronavirus_dataset.csv>

Now, let’s go back to RStudio. In our R Markdown, let’s read this csv
file and name the variable “coronavirus”. We will use the `read_csv()`
function from the `readr` package (part of the tidyverse, so it’s
already installed\!).

``` r
# read in corona .csv
coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus-csv/master/coronavirus_dataset.csv', col_types = cols(Province.State = col_character()))
```

For today, don’t worry about why we need to specify the `col_types`
argument - we will cover the details of data import functions in a few
weeks.

Once we have the data loaded, let’s start getting familiar with its
content and format.

Let’s inspect:

``` r
## explore the coronavirus dataset
coronavirus # this is super long! Let's inspect in different ways
```

Let’s use `head` and `tail`:

``` r
head(coronavirus) # shows first 6
tail(coronavirus) # shows last 6
head(coronavirus, 10) # shows first X that you indicate
tail(coronavirus, 12) # guess what this does!
```

We can also see the `coronavirus` variable in RStudio’s Environment pane
(top right)

More ways to learn basic info on a data.frame.

``` r
names(coronavirus)
dim(coronavirus)    # ?dim dimension
ncol(coronavirus)   # ?ncol number of columns
nrow(coronavirus)   # ?nrow number of rows
```

A statistical overview can be obtained with `summary()`, or with
`skimr::skim()`

``` r
summary(coronavirus)

# If we don't already have skimr installed, we will need to install it
# install.packages('skimr')
library(skimr) 
skim(coronavirus)
```

<br>

### Look at the variables inside a data.frame

To specify a single variable from a data.frame, use the dollar sign `$`.
The `$` operator is a way to extract of replace parts of an object —
check out the help menu for `$`. It’s a common operator you’ll see in R.

``` r
coronavirus$cases # very long! hard to make sense of...
head(coronavirus$cases) # can do the same tests we tried before
str(coronavirus$cases) # it is a single numeric vector
summary(coronavirus$cases) # same information, formatted slightly differently
```

<br>

## `dplyr` basics

OK, so let’s start wrangling with dplyr.

There are five `dplyr` functions that you will use to do the vast
majority of data manipulations:

  - **`filter()`**: pick observations by their
    values
    
    <!--html_preserve-->
    
    <img src="../img/rstudio-cheatsheet-filter.png" width="300"/><!--/html_preserve-->

  - **`select()`**: pick variables by their
    names
    
    <!--html_preserve-->
    
    <img src="../img/rstudio-cheatsheet-select.png" width="300"/><!--/html_preserve-->

  - **`mutate()`**: create new variables with functions of existing
    variables
    
    <!--html_preserve-->
    
    <img src="../img/rstudio-cheatsheet-mutate.png" width="300"/><!--/html_preserve-->

  - **`arrange()`**: reorder the rows

  - **`summarise()`**: collapse many values down to a single
    summary
    
    <!--html_preserve-->
    
    <img src="../img/rstudio-cheatsheet-summarise.png" width="300"/><!--/html_preserve-->

These can all be used in conjunction with `group_by()` which changes the
scope of each function from operating on the entire dataset to operating
on it group-by-group. These six functions provide the verbs for a
language of data manipulation. **We will cover the first four today and
`summarise()` and `group_by()` on Wednesday.**

All verbs work similarly:

1.  The first argument is a data frame.
2.  The subsequent arguments describe what to do with the data frame.
    You can refer to columns in the data frame directly without using
    `$`.
3.  The result is a new data frame.

Together these properties make it easy to chain together multiple simple
steps to achieve a complex result.

<br>

## `filter()` subsets data row-wise (observations).

You will want to isolate bits of your data; maybe you want to only look
at a single country or a few years. R calls this subsetting.

`filter()` is a function in `dplyr` that takes logical expressions and
returns the rows for which all are `TRUE`.

Visually, we are doing this (thanks RStudio for your
[cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)):

![](../img/rstudio-cheatsheet-filter.png) Remember your logical
expressions? If not, here is a reminder
[here](https://www.statmethods.net/management/operators.html#Logical).
We’ll use `>` and `==` here.

``` r
filter(coronavirus, cases > 0)
```

You can say this out loud: “Filter the coronavirus data for cases
greater than 0”. Notice that when we do this, all the columns are
returned, but only the rows that have the a non-zero case count. We’ve
subsetted by row.

Let’s try another: “Filter the coronavirus data for the country US”.

``` r
filter(coronavirus, Country.Region == "US")
```

Note that when you run that line of code, `dplyr` executes the filtering
operation and returns a new data frame. `dplyr` functions never modify
their inputs, so if you want to save the result, you’ll need to use the
assignment operator, `<-`:

``` r
coronavirus_us <- filter(coronavirus, Country.Region == "US")
```

How about if we want two country names? We can’t use a single instance
of the `==` operator here, because it can only operate on one thing at a
time. We can use [Boolean
operators](https://r4ds.had.co.nz/transform.html#logical-operators) for
this: `&` is “and”, `|` is “or”, and `!` is “not”. So if we want records
from both the US and Canada, we can type

``` r
filter(coronavirus, Country.Region == "US" | Country.Region == "Canada")
```

A useful short-hand for this problem is `x %in% y`. This will select
every row where `x` is one of the values in `y`. We could use it to
rewrite the code above:

``` r
filter(coronavirus, Country.Region %in% c("US", "Canada"))
```

How about if we want only the death counts in the US? You can pass
filter different criteria:

``` r
# We can use either of these notations:
filter(coronavirus, Country.Region == "US", type == "death")
filter(coronavirus, Country.Region == "US" & type == "death")
```

## Your turn

> What was the total number of deaths in the US in the time period
> covered in the dataset?  
> Hint: do this in 2 steps by assigning a variable and then using the
> `sum()` function.
> 
> Then, sync to Github.com (pull, stage, commit, push).

<br>

### Answer

This is one way to do it based on what we have learned so far:

``` r
x <- filter(coronavirus, Country.Region == "US", type == "death")  
sum(x$cases)  
```

<br> <br>

## `select()` subsets data column-wise (variables)

We use `select()` to subset the data on variables or columns.

Visually, we are doing this (thanks RStudio for your
[cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)):

![](../img/rstudio-cheatsheet-select.png)

We can select multiple columns with a comma, after we specify the data
frame (coronavirus).

``` r
select(coronavirus, date, Country.Region, type, cases) 
```

Note how the order of the columns also have been rearranged to match the
order they are listed in the `select()` function.

We can also use `-` to deselect columns

``` r
select(coronavirus, -Lat, -Long) # you can use - to deselect columns
```

<br>

## That is a far as we got today.

**Knit your RMarkdown file, and sync it to GitHub (pull, stage, commit,
push)**

<br>

We will continue in the next class with learning more useful `dplyr`
functions.

<br>

## Extra exercises to do if you have time

Combine your new data wrangling skills with the ggplot skills to covered
last week to explore patterns in the coronavirus dataset. How have the
number of cases developed over time in different countries?
