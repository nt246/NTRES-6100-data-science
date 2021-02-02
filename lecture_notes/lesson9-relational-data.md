Lesson 9: Relational data and factors
================

<br>

## Readings

#### Required:

[Chapter 13 in ‘R for Data
Science’](https://r4ds.had.co.nz/relational-data.html) by Hadley
Wickham & Garrett Grolemund

Jenny Bryan’s [STAT545 Chapter 10: Be the boss of your
factors](https://stat545.com/multiple-tibbles.html)

<br>

#### Other resources:

Jenny Bryan’s [STAT545 Chapter 14 When one tibble is not
enough](https://stat545.com/multiple-tibbles.html)

[Chapter 15 in ‘R for Data
Science’](https://r4ds.had.co.nz/factors.html) by Hadley Wickham &
Garrett Grolemund

<br>

## Learning objectives

Today, we’ll cover two different (somewhat unrelated) topics. By the end
of today’s class, you should be able to:

For relational data:

  - Combine information from multiple tables into one
  - Describe the difference between the four `join` and two `filter`
    functions in `dplyr`
  - Select and apply the appropriate join function in common use
    scenarios

For factors:

  - Re-order the levels of a factor
  - Re-name and combine the levels of a factor

<br>

## Setup

Load the tidyverse

``` r
library(tidyverse)
```

We will also be practicing joins on data on flights departing NYC in
2013. These are compiled in a package that we will install and load

``` r
library(nycflights13)  # install.packages("nycflights13")
```

<br>

## Part 1: Relational data

From [R for Data
Science](https://r4ds.had.co.nz/relational-data.html#nycflights13-relational):

It’s rare that a data analysis involves only a single table of data.
Typically you have many tables of data, and you must combine them to
answer the questions that you’re interested in. Collectively, multiple
tables of data are called relational data because it is the relations,
not just the individual datasets, that are important.

There are four main types of operations that can be done with two
tables:

  - [**Binding**](https://stat545.com/multiple-tibbles.html#typology-of-data-combination-tasks),
    which simply stacks tables on top of or beside each other

  - [**Mutating
    joins**](https://r4ds.had.co.nz/relational-data.html#mutating-joins),
    which add new variables to one data frame from matching observations
    in another

  - [**Filtering
    joins**](https://r4ds.had.co.nz/relational-data.html#filtering-joins),
    which filter observations from one data frame based on whether or
    not they match an observation in the other table

  - **Set operations**, which treat observations as if they were set
    elements.

We will only cover the first three today. Let’s click on the links to
work through the corresponding section in Jenny Bryan’s STAT 545 notes
or Grolemund and Wickham’s R for Data Science.

### Key point

The most commonly used join is the left join: you use this whenever you
look up additional data from another table, because it preserves the
original observations even when there isn’t a match. The left join
should be your default join: use it unless you have a strong reason to
prefer one of the others.

<br>

### Optional exercises (from the R for Data Science chapter)

1.  Compute the average delay by destination, then join on the
    `airports` data frame so you can show the spatial distribution of
    delays. Here’s an easy way to draw a map of the United States:
    
    ``` r
    library(maps) #install.packages("maps")
    
    airports %>%
      semi_join(flights, c("faa" = "dest")) %>%
      ggplot(aes(lon, lat)) +
        borders("state") +
        geom_point() +
        coord_quickmap()
    ```
    
    (Don’t worry if you don’t understand what `semi_join()` does —
    you’ll learn about it next.)
    
    You might want to use the `size` or `colour` of the points to
    display the average delay for each airport.

2.  Add the location of the origin *and* destination (i.e. the `lat` and
    `lon`) to `flights`.

3.  Is there a relationship between the age of a plane and its delays?

<br> <br>

## Part 2: Factors in R

In R, factors are used to work with categorical variables, variables
that have a fixed and known set of possible values. They are also useful
when you want to display character vectors in a non-alphabetical order.
The values a factor can take on are called the levels. When working with
factors, the two most common operations are changing the order of the
levels, and changing the values (names) of the levels.

To work with factors, we’ll use the `forcats` package, which is part of
the core `tidyverse`. It provides tools for dealing with **cat**egorical
variables (and it’s an anagram of factors\!) using a wide range of
helpers for working with factors.

We’ll work through [Chapters 15.3-15.6 of R for Data
Science](https://r4ds.had.co.nz/factors.html#general-social-survey) to
explore some of the functionality.

<br>

### Optional exercises (from R for Data Science)

1.  How have the proportions of people identifying as Democrat,
    Republican, and Independent changed over time?
2.  How could you collapse `rincome` into a small set of categories?
