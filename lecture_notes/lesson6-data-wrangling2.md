Lesson 6: Data Wrangling Part 2
================

<br>

## Readings

#### Required:

  - Chapter 5.6-5.7 in [R for Data
    Science](https://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise)
    by Hadley Wickham & Garrett Grolemund

#### Other resources:

  - The [Introduction to `dplyr`
    vignette](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)

  - Jenny Bryan’s lectures from STAT545 at UBC: [Introduction to
    dplyr](http://stat545.com/block009_dplyr-intro.html)

  - Software Carpentry’s R for reproducible scientific analysis
    materials: [Dataframe manipulation with
    dplyr](https://swcarpentry.github.io/r-novice-gapminder/13-dplyr/)

<br>

## Class announcements

  - Problem Set 2 is due at 10pm tonight. Problem set 3 due next
    Wednesday
  - We will probably have a longer Zoom session next week, starting at
    4.50 or 5pm - check for updates on Slack

<br>

## Learning objectives

Last class, we learned how to use `dplyr` functions

  - `filter()` for subsetting data with row logic
  - `select()` for subsetting data variable- or column-wise

We also reinforced our practice with sync’ing our files from RStudio to
GitHub

Today, we’ll expand our data wrangling toolbox. By the end of today’s
class, you should be able to:

  - Use piping (`%>%`) to implement function chains
  - Subset, rearrange, and summarize data with key `dplyr` functions:
      - Create new variables with functions of existing variables with
        `mutate()`
      - Reorder the rows with `arrange()`
      - Collapse many values down to a single summary with `summarize()`
        and `group_by()`
  - Understand the basic differences between tidyverse and base R syntax

**Acknowledgements**: Today’s lecture is adapted (with permission) from
the excellent [Ocean Health Index Data Science
Training](http://ohi-science.org/data-science-training/dplyr.html) with
additional input from Jenny Bryan’s lectures from STAT545 at UBC:
[Introduction to dplyr](http://stat545.com/block009_dplyr-intro.html)
and Grolemund and Wickham’s [R for Data
Science](https://r4ds.had.co.nz/transform.html).

<br>

### Let’s first clean up our RMarkdown file from last class and add some styling

  - Separate into separate code chunks and add a little commentary above
    each. You can also name your code chunks, if you’d like.
  - Add a few headers.
  - How about a picture?

If you forgot how, take a peek at the [RMarkdown
Cheatsheet](https://github.com/rstudio/cheatsheets/blob/master/rmarkdown-2.0.pdf)

<br>

### Running RMarkdown code chunks

So far we have written code in our RMarkdown file that is executed when
we knit the file. We have also written code directly in the Console that
is executed when we press enter/return. Additionally, we can write code
in an RMarkdown code chunk and execute it by sending it into the Console
(i.e. we can execute code without knitting the document).

How do we do it? There are several ways.

**First approach: send R code to the Console.** This approach involves
selecting (highlighting) the R code only, not any of the
backticks/fences from the code chunk. (If you see `Error: attempt to use
zero-length variable name` it is because you have accidentally
highlighted the backticks along with the R code. Try again (and don’t
forget that you can add spaces within the code chunk or make your
RStudio session bigger (View \> Zoom In)).

Do this by selecting code and then:

1.  copy-pasting into the Console and press enter/return.
2.  clicking ‘Run’ from RStudio IDE. This is available from:
    1.  the bar above the file (green arrow)
    2.  the menu bar: Code \> Run Selected Line(s)
    3.  keyboard shortcut: command-return

**Second approach: run full code chunk.** Since we are already grouping
relevant code together in chunks, it’s reasonable that we might want to
run it all together at once.

Do this by placing your curser within a code chunk and then:

1.  clicking the little black down arrow next to the Run green arrow and
    selecting Run Current Chunk. Notice there are also options to run
    all chunks, run all chunks above or below…

<br>

## Reloading the Coronavirus dataset

Let’s jump back in where we left on Monday. Let’s first clear out our
workspace so we start with a fresh session by clicking “Session” -\>
“Restart R”. Then let’s load the Coronavirus dataset back in directly
from the GitHub URL and see whether it has been updated - what is the
latest date
included?

``` r
# read in corona .csv (don't worry for now about what the col_types parameter means, we'll discuss that next week)
coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus-csv/master/coronavirus_dataset.csv', col_types = cols(Province.State = col_character()))
```

Let’s remind ourselves of the data structure and content

``` r
skim(coronavirus)
```

<br>

## Use `select()` and `filter()` together

On Monday, we explored the functions `select()` and `filter()`
separately. Now let’s combine them and filter to retain only records for
the US and remove the Lat, Long and Province.State columns (because this
dataset doesn’t currently have data broken down by US state). We’ll save
this subsetted data as a variable. Actually, as two temporary variables,
which means that for the second one we need to operate on
`coronavirus_us`, not `coronavirus`.

``` r
coronavirus_us  <- filter(coronavirus, Country.Region == "US")
coronavirus_us2 <- select(coronavirus_us, -Lat, -Long, -Province.State) 
```

We also could have called them both `coronavirus_us` and overwritten the
first assignment. Either way, naming them and keeping track of them gets
super cumbersome, which means more time to understand what’s going on
and opportunities for confusion or error.

Good thing there is an awesome alternative.

<br>

## Meet the new pipe `%>%` operator

Before we go any further, we should explore the new pipe operator that
`dplyr` imports from the
[`magrittr`](https://github.com/smbache/magrittr) package by Stefan
Bache. If you have have not used this before, **this is going to change
your life** (at least your coding life…). You no longer need to enact
multi-operation commands by nesting them inside each other. And we won’t
need to make temporary variables like we did in the US example above.
This new syntax leads to code that is much easier to write and to read:
it actually tells the story of your analysis.

Here’s what it looks like: `%>%`. The RStudio keyboard shortcut: Ctrl +
Shift + M (Windows), Cmd + Shift + M (Mac).

Let’s demo then I’ll explain:

``` r
coronavirus %>% head()
```

This is equivalent to `head(coronavirus)`. This pipe operator takes the
thing on the left-hand-side and **pipes** it into the function call on
the right-hand-side. It literally drops it in as the first argument.

Never fear, you can still specify other arguments to this function\! To
see the first 3 rows of coronavirus, we could say `head(coronavirus, 3)`
or this:

``` r
coronavirus %>% head(3)
```

**I’ve advised you to think “gets” whenever you see the assignment
operator, `<-`. Similarly, you should think “and then” whenever you see
the pipe operator, `%>%`.**

One of the most awesome things about this is that you START with the
data before you say what you’re doing to DO to it. So above: “take the
coronavirus data, and then give me the first three entries”.

This means that instead of this:

``` r
## instead of this...
coronavirus_us  <- filter(coronavirus, Country.Region == "US")
coronavirus_us2 <- select(coronavirus_us, -Lat, -Long, -Province.State) 
## ...we can do this
coronavirus_us  <- coronavirus %>% filter(Country.Region == "US")
coronavirus_us2 <- coronavirus_us %>% select(-Lat, -Long, -Province.State) 
```

So you can see that we’ll start with coronavirus in the first example
line, and then coronavirus\_us in the second. This makes it a bit easier
to see what data we are starting with and what we are doing to it.

…But, we still have those temporary variables so we’re not truly that
better off. But get ready to be majorly impressed:

<br>

### Revel in the convenience

We can use the pipe to chain those two operations together:

``` r
coronavirus_us  <- coronavirus %>% 
  filter(Country.Region == "US") %>%
  select(-Lat, -Long, -Province.State) 
```

What’s happening here? In the second line, we were able to delete
`coronavirus_us2 <- coronavirus_us`, and put the pipe operator above.
This is possible since we wanted to operate on the `coronavirus_us`
data. And we weren’t truly excited about having a second variable named
`coronavirus_us2` anyway, so we can get rid of it. This is huge, because
most of your data wrangling will have many more than 2 steps, and we
don’t want a `coronavirus_us17`\!

By using multiple lines I can actually read this like a story and there
aren’t temporary variables that get super confusing. In my head:

> “start with the `coronavirus` data, and then  
> filter for the US, and then  
> drop the variables Lat, Long, and Province.State.” Being able to read
> a story out of code like this is really game-changing. We’ll continue
> using this syntax as we learn the other dplyr verbs.

Compare with some base R code to accomplish the same things. Base R
requires subsetting with the \[rows, columns\] notation. This notation
is something you’ll see a lot in base R. The brackets \[ \] allow you to
extract parts of an object. Within the brackets, the comma separates
rows from columns.

If we don’t write anything after the comma, that means “all columns”.
And if we don’t write anything before the comma, that means “all rows”.

Also, the $ operator is how you access specific columns of your
dataframe.

``` r
#There are many ways we could subset columns, here's one way:
coronavirus[coronavirus$Country.Region == "US", colnames(coronavirus) %in% c("Lat", "Long", "Province.State")==FALSE] ## repeat `coronavirus`, [i, j] indexing is distracting.
```

##### Never index by blind numbers\!

``` r
#There are many ways we could subset columns, here's another (bad choice)
head(coronavirus)
coronavirus[coronavirus$Country.Region == "US", c(2, 5:7)] 
```

Why is this a terrible idea?

  - It is not self-documenting. What are the columns were retaining
    here?
  - It is fragile. This line of code will produce different results if
    someone changes the organization of the dataset, e.g. adds new
    variables. This is especially risky if we index rows by numbers as a
    sorting action earlier in the script would then give unexpected
    results.

This call explains itself and is fairly robust.

``` r
coronavirus_us  <- coronavirus %>% 
  filter(Country.Region == "US") %>%
  select(-Lat, -Long, -Province.State) 
```

<br>

## `mutate()` adds new variables

Alright, let’s keep going.

Besides selecting sets of existing columns, it’s often useful to add new
columns that are functions of existing columns. That’s the job of
`mutate()`.

Visually, we are doing this (thanks RStudio for your
[cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)):

![](../img/rstudio-cheatsheet-mutate.png)

The current variables in the coronavirus dataset don’t lend themselves
well to cross-computation, so to illustrate the power of the `mutate()`
function, let’s reformat the dataset so that we get the counts of
confirmed cases, deaths and recovered for each date and country in
separate columns. The tidyverse has a very convenient function for
making that kind of transformation. Don’t worry about how it works right
now, we’ll get an opportunity to explore it next week.

For now, just copy the following code to summarize the total number of
cases recorded by country and type (in the time period covered by this
dataset: 2020-01-22 to `r max(coronavirus$date)`):

``` r
coronavirus_ttd <- coronavirus %>% 
  select(country = Country.Region, type, cases) %>%
  group_by(country, type) %>%
  summarise(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type,
              values_from = total_cases) %>%
  arrange(-confirmed)

# Let's have a look at the structure of that new rearranged dataset
coronavirus_ttd
```

Imagine we want to compare the total death count to total the number of
confirmed cases in each country. We can divide the case counts of
`death` by `confirmed` to create a new column named `deathrate`. We do
this with `mutate()` that is a function that defines and inserts new
variables into a tibble. You can refer to existing variables diretly by
name (i.e. without the `$` operator).

``` r
coronavirus_ttd %>%
  mutate(deathrate = death / confirmed) 

# We can modify the mutate equation in many ways. For example, if we want to adjust the number of significant digits printed, we can type
coronavirus_ttd %>%
  mutate(deathrate = round(death / confirmed, 2)) 
```

Note, however, that these estimated death rates may be misleading and
should be interpreted with due caution as testing strategies have varied
a lot between countries (e.g. do asymptomatic people get tested). Also:

  - There is no measurement between the time a case was confirmed and
    recovery or death. This is not an apple to apple comparison, as the
    outbreak did not start at the same time in all the affected
    countries.
  - As age plays a critical role in the probability of survival from the
    virus, we cannot make a comparison between different cases without
    having more demographic information.

### Your turn

> Add a new variable that shows the *proportion of confirmed cases* for
> which the outcome is still unknown (i.e. not counted as dead or
> recovered) for each country and show only countries with more than
> 20,000 confirmed cases. Which country has the lowest proportion of
> undetermined outcomes? Why?
> 
> When you’re done, sync your RMarkdown file to Github.com (pull, stage,
> commit, push).

#### Answer

``` r
coronavirus_ttd %>%
  mutate(undet = (confirmed - death - recovered) / confirmed) %>% 
  filter(confirmed > 20000)
```

<br>

## `arrange()` orders rows

For examining the output of our previous calculations, we may want to
re-arrange the countries in ascending order for the proportion of
confirmed cases for which the outcome remains unknown. The `dplyr`
function for sorting rows is `arrange()`.

``` r
coronavirus_ttd %>%
  mutate(undet = (confirmed - death - recovered)/confirmed) %>% 
  filter(confirmed > 20000) %>% 
  arrange(undet)
```

I advise that your analyses NEVER rely on rows or variables being in a
specific order. But it’s still true that human beings write the code and
the interactive development process can be much nicer if you reorder the
rows of your data as you go along. Also, once you are preparing tables
for human eyeballs, it is imperative that you step up and take control
of row order.

### Your turn

> How many countries have suffered more than 3,000 deaths so far and
> which three countries have recorded the highest death counts?

#### Answer

``` r
coronavirus_ttd %>%
  filter(death > 3000) %>% 
  arrange(-death)
```

### Your turn again

> 1.  Go back to our original dataset `coronavirus` and identify where
>     and when the highest death count in a single day was observed.
>     Hint: you can either use or `base::max` or `dplyr::arrange()`…
> 
> 2.  The first case was confirmed in the US on
>     [January 20 2020](https://www.nejm.org/doi/full/10.1056/NEJMoa2001191),
>     marking the earliest day included in this dataset. When was the
>     first confirmed case recorded in Denmark?
> 
> 3.  Knit your RMarkdown file, and sync it to GitHub (pull, stage,
>     commit, push)

#### Answer (no peeking\!)

``` r
# Identifying the record with the highest death count
coronavirus %>% 
  filter(type == "death") %>% 
  arrange(-cases)

# We can also just identify the top hit 
coronavirus %>% 
  filter(type == "death") %>% 
  filter(cases == max(cases))

# The first recorded case in Denmark
coronavirus %>% 
  filter(Country.Region == "Denmark", cases > 0) %>% 
  arrange(date)
```

**Knit your RMarkdown file, and sync it to GitHub (pull, stage, commit,
push)**

<br>

## Grouped summaries with `summarize()` and `group_by`

The last key `dplyr` verb is `summarize()`. It collapses a data frame to
a single row. Visually, we are doing this (thanks RStudio for your
[cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)):

![](../img/rstudio-cheatsheet-summarise.png)

We can use it to calculate the total number of confirmed cases detected
globally since 1-20-2020 (the beginning of this dataset)

``` r
coronavirus %>% 
  filter(type == "confirmed") %>% 
  summarize(sum = sum(cases))
```

This number could also easily have been computed with base-R functions.
In general, `summarize()` is not terribly useful unless we pair it with
`group_by()`. This changes the unit of analysis from the complete
dataset to individual groups. Then, when you use the `dplyr` verbs on a
grouped data frame they’ll be automatically applied “by group”. For
example, if we applied exactly the same code to a data frame grouped by
Country.Region, we get the total number of confirmed cases for each
country or region.

``` r
coronavirus %>% 
  filter(type == "confirmed") %>%
  group_by(Country.Region) %>% 
  summarize(total_cases = sum(cases))
```

We can also use `summarize()` to check how many observations (dates) we
have for each country

``` r
coronavirus %>% 
  filter(type == "confirmed") %>%
  group_by(Country.Region) %>% 
  summarize(n = n())
```

Why do some countries have much higher counts than others?

We can also do multi-level grouping. If we wanted to know how many of
each type of case there were globally on Monday we could chain these
functions together:

``` r
coronavirus %>% 
  group_by(date, type) %>% 
  summarize(total = sum(cases)) %>%  # sums the count across countries
  filter(date == "2020-04-06")
```

## Your turn

Which day has had the highest total death count globally so far?

## Answer

``` r
coronavirus %>% 
  filter(type == "death") %>% 
  group_by(date) %>% 
  summarize(total_cases = sum(cases)) %>% 
  arrange(-total_cases)

# Or

coronavirus %>% 
  filter(type == "death") %>% 
  group_by(date) %>% 
  summarize(total_cases = sum(cases)) %>% 
  filter(total_cases == max(total_cases))
```

<br>

## If you have more time, here is an optional question

The `month()` function from the package `lubridate` extracts the month
from a date. How many countries already have more than 1000 deaths in
April?

``` r
library(lubridate) #install.packages('lubridate')

coronavirus %>% 
  mutate(month = month(date)) %>% 
  filter(type == "death", month == 4) %>% 
  group_by(Country.Region) %>% 
  summarize(total_death = sum(cases)) %>% 
  filter(total_death > 1000)
```

<br>

## In-class questions

1.  Which country had the highest number of deaths on Monday (April 6
    20202)?

<!-- end list -->

``` r
coronavirus %>% 
  select(-Lat, -Long) %>% 
  filter(date == "2020-04-06", type == "death") %>% 
  arrange(-cases)
```

2.  Which country had the highest count of confirmed cases in January?
    \[Hint: to address this question the function month() from the
    package lubridate might be helpful\]. What about in March?

<!-- end list -->

``` r
library(lubridate) #install.packages('lubridate')

coronavirus %>% 
  mutate(month = month(date)) %>% 
  filter(type == "confirmed", month == 1) %>% 
  group_by(Country.Region) %>% 
  summarize(total_death = sum(cases)) %>% 
  arrange(-total_death)
```

3.  Which countries have data for multiple states or provinces?

<!-- end list -->

``` r
coronavirus %>% 
  group_by(Country.Region, date) %>% 
  summarize(n = n()) %>% 
  group_by(Country.Region) %>% 
  summarize(maxcount = max(n)) %>% 
  filter(maxcount > 3)
```

4.  Do all countries have reports of the number of confirmed cases for
    the same number of days?

<!-- end list -->

``` r
coronavirus %>% 
  filter(type == "recovered") %>% 
  group_by(Country.Region, Province.State) %>% 
  summarize(n = n()) %>% 
  arrange(n) %>% 
  head
```
