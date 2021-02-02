Lesson 12: Iteration with `for` loops and conditional execution with
`if` statements
================

<br>

## Readings

#### Required:

[Chapter 21 in ‘R for Data
Science’](https://r4ds.had.co.nz/iteration.html) by Hadley Wickham &
Garrett Grolemund

<br>

#### Other resources:

We will be working through [this
tutorial](http://ohi-science.org/data-science-training/programming.html)
developed by the Ocean Health Index Data Science Team

<br>

## Announcements

The final homework assignment has been posted. It is due next Wednesday
May 6 at 10pm

Next class (Monday May 4) will be our last. There will be a recorded
lecture and a Zoom call from 5.10-5.40pm. We will cover the following
topics:

  - Review of good practices
  - Where and how to get help
  - Where to learn more

<br>

## Today’s learning objectives

By the end of today’s class, you should be able to:

  - Write a `for` loop to repeat operations on different input
  - Implement `if` and `if else` statements for conditional execution of
    code

<br>

**Acknowledgements**: Today’s tutorial is adapted (with permission) from
the excellent [Ocean Health Index Data Science
Training](http://ohi-science.org/data-science-training/programming.html).

<br>

## Introduction

> This section is modified from [the iteration chapter in R for Data
> Science](https://r4ds.had.co.nz/iteration.html)

Whenever possible, we want to avoid duplication in our code (e.g. by
copying-and-pasting sections of our script that we want to repeat with
different input). Reducing code duplication has three main benefits:

  - It’s easier to see the intent of your code, because your eyes are
    drawn to what’s different, not what stays the same.

  - It’s easier to respond to changes in requirements. As your needs
    change, you only need to make changes in one place, rather than
    remembering to change every place that you copied-and-pasted the
    code. You eliminate the chance of making incidental mistakes when
    you copy and paste (i.e. updating a variable name in one place, but
    not in another).

  - You’re likely to have fewer bugs because each line of code is used
    in more places.

One tool for reducing duplication is functions, which reduce duplication
by identifying repeated patterns of code and extract them out into
independent pieces that can be easily reused and updated. Unfortunately,
we don’t have time to cover functions in this course, but I would
strongly recommend that you work through the chapter on functions in the
[R for Data Science](https://r4ds.had.co.nz/functions.html) book if you
don’t know how to write functions in R.

Another tool for reducing duplication is iteration, which helps you when
you need to do the same thing to multiple inputs: repeating the same
operation on different columns, or on different datasets. There are
several ways to iterate in R. Today we will only cover `for` loops,
which are a great place to start because they make iteration very
explicit, so it’s obvious what’s happening. However, `for` loops are
quite verbose, and require quite a bit of bookkeeping code that is
duplicated for every `for` loop. Once you master `for` loops, you can
solve many common iteration problems with less code, more ease, and
fewer errors using functional programming, which I encourage you to
explore on your own, for example in the [R for Data
Science](https://r4ds.had.co.nz/iteration.html#for-loops-vs.functionals)
book.

Today, we will illustrate the use of `for` loops with an example. We
will also use cover conditional execution of code with `if` statements.

<br>

## Create an R script

Today we’re going to work in an R script. What is an R script? It’s a
text file with a .R extension. We’ve mostly been writing R code in R
Markdown files so far; R scripts are just R code without the Markdown
along with it.

Go to File \> New File \> R Script (or click the green plus in the top
left corner).

Remember, like in R Markdown, hitting return does not execute this
command. To execute it, we need to get what we typed in the script down
into the console. Here is how we can do that:

1.  copy-paste this line into the console.

2.  select the line (or simply put the cursor there), and click ‘Run’.
    This is available from
    
    1.  the bar above the script (green arrow)
    2.  the menu bar: Code \> Run Selected Line(s)
    3.  keyboard shortcut: command-return

3.  source the script, which means running the whole thing. This is also
    great for to see if there are any typos in your code that you’ve
    missed. You can do this by:
    
    1.  clicking Source (blue arrow in the bar above the script).
    2.  typing `source('gapminder-analysis.R')` in the console (or from
        another R file\!\!\!).

<br>

## Analysis plan

**Gapminder data**

Today, we’ll be using [Gapminder data](http://www.gapminder.org/world),
which represents the health and wealth of nations. It was pioneered by
[Hans Rosling](https://www.ted.com/speakers/hans_rosling), who is famous
for describing the prosperity of nations over time through famines, wars
and other historic events with this beautiful data visualization in his
[2006 TED Talk: The best stats you’ve ever
seen](https://www.ted.com/talks/hans_rosling_shows_the_best_stats_you_ve_ever_seen):

[Gapminder Motion
Chart\<br\>![](https://github.com/remi-daigle/2016-04-15-UCSB/raw/gh-pages/viz/img/gapminder-world_motion-chart.png)](http://www.gapminder.org/world)

<br>

Let’s start off with writing a few comments in our R-script so that we
know what it is for, and save it:

    ## gapminder-analysis.R
    ## analysis with gapminder data
    ## J Lowndes lowndes@nceas.ucsb.edu

We will use a subset of the gapminder data included in the R package
`gapminder`. So first we need to install that package and load it, along
with the tidyverse. Then have a look at the data in `gapminder`

``` r
library(tidyverse)
library(gapminder) #install.pagkages("gapminder")

gapminder
```

    ## # A tibble: 1,704 x 6
    ##    country     continent  year lifeExp      pop gdpPercap
    ##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
    ##  1 Afghanistan Asia       1952    28.8  8425333      779.
    ##  2 Afghanistan Asia       1957    30.3  9240934      821.
    ##  3 Afghanistan Asia       1962    32.0 10267083      853.
    ##  4 Afghanistan Asia       1967    34.0 11537966      836.
    ##  5 Afghanistan Asia       1972    36.1 13079460      740.
    ##  6 Afghanistan Asia       1977    38.4 14880372      786.
    ##  7 Afghanistan Asia       1982    39.9 12881816      978.
    ##  8 Afghanistan Asia       1987    40.8 13867957      852.
    ##  9 Afghanistan Asia       1992    41.7 16317921      649.
    ## 10 Afghanistan Asia       1997    41.8 22227415      635.
    ## # … with 1,694 more rows

Here is the plan for our analysis: We want to plot the gdpPercap for
each country in the gapminder data frame. So that’s 142 separate plots\!
We will automate this, labeling each one with its name and saving it in
a folder called figures. We will learn a bunch of things as we go.

<br>

## Automation with `for` loops

Our plan is to plot gdpPercap for each country. This means that we want
to do the same operation (plotting gdpPercap) on a bunch of different
things (countries). We’ve worked with dplyr’s `group_by()` function, and
this is super powerful to automate through groups. But there are things
that you may not want to do with `group_by()`, like plotting. So here,
we will use a `for` loop.

Let’s start off with what this would look like for just one country. I’m
going to demonstrate with Afghanistan:

<!---TODO
For the figures, we want it to label the currency, which we have in another data file (=join). And, we'll want to add Westeros to the dataframe (=rbind) and create that figure too. 
--->

``` r
## filter the country to plot
gap_to_plot <- gapminder %>%
  filter(country == "Afghanistan")
## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  labs(title = "Afghanistan")
```

Let’s actually give this a better title than just the country name.
Let’s use the `base::paste()` function from to paste two strings
together so that the title is more descriptive. Use `?paste` to see what
the “sep” variable does.

``` r
## filter the country to plot
gap_to_plot <- gapminder %>%
  filter(country == "Afghanistan")
## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  ## add title and save
  labs(title = paste("Afghanistan", "GDP per capita", sep = " "))
```

And as a last step, let’s save this figure.

``` r
## filter the country to plot
gap_to_plot <- gapminder %>%
  filter(country == "Afghanistan")
## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  ## add title and save
  labs(title = paste("Afghanistan", "GDP per capita", sep = " "))
ggsave(filename = "Afghanistan_gdpPercap.png", plot = my_plot)
```

OK. So we can check our repo in the file pane (bottom right of RStudio)
and see the generated figure:

![](../img/Afghanistan_gdpPercap.png)

### Thinking ahead: cleaning up our code

Now, in our code above, we’ve had to write out “Afghanistan” several
times. This makes it not only typo-prone as we type it each time, but if
we wanted to plot another country, we’d have to write that in 3 places
too. It is not setting us up for an easy time in our future, and
thinking ahead in programming is something to keep in mind.

Instead of having “Afghanistan” written 3 times, let’s instead create an
object that we will assign to “Afghanistan”. We won’t name our object
“country” because that’s a column header with gapminder, and will just
confuse us. Let’s make it distinctive: let’s write cntry (country
without vowels):

``` r
## create country variable
cntry <- "Afghanistan"
```

Now, we can replace each `"Afghanistan"` with our variable `cntry`. We
will have to introduce a `paste` statement here too, and we want to
separate by nothing (`""`).

``` r
## create country variable
cntry <- "Afghanistan"
## filter the country to plot
gap_to_plot <- gapminder %>%
  filter(country == cntry)
## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  ## add title and save
  labs(title = paste(cntry, "GDP per capita", sep = " "))
## note: there are many ways to create filenames with paste() or file.path(); we are doing this way for a reason.
ggsave(filename = paste(cntry, "_gdpPercap.png", sep = ""), plot = my_plot)
```

Let’s run this. Great\! it saved our figure (I can tell this because the
timestamp in the Files pane has updated\!)

### `for` loop basic structure

Now, how about if we want to plot not only Afghanistan, but other
countries as well? There wasn’t actually that much code needed to get us
here, but we definitely do not want to copy this for every country. Even
if we copy-pasted and switched out the country assigned to the `cntry`
variable, it would be very typo-prone. Plus, what if you wanted to
instead plot lifeExp? You’d have to remember to change it each time…it
gets messy quick.

Better with a `for` loop. This will let us cycle through and do what we
want to each thing in turn. If you want to iterate over a set of values,
and perform the same operation on each, a `for` loop will do the job.

**Sit back and watch me for a few minutes while we develop the `for`
loop.** Then we’ll give you time to do this on your computers as well.

The basic structure of a `for` loop is:

``` r
for (each item in set of items){
  do a thing
}
```

Note the `( )` and the `{ }`. We talk about iterating through each item
in the `for` loop, which makes each item an iterator.

So looking back at our Afghanistan code: all of this is pretty much the
“do a thing” part. And we can see that there are only a few places
that are specific to Afghanistan. If we could make those places not
specific to Afghanistan, we would be set.

![](../img/for_loop_logic.png)

Let’s paste from what we had before, and modify it. I’m also going to
use RStudio’s indentation help to indent the lines within the `for` loop
by highlighting the code in this chunk and going to Code \> Reindent
Lines (shortcut: command I)

``` r
## create country variable
cntry <- "Afghanistan"
for (each cntry in a list of countries ) {
  
  ## filter the country to plot
  gap_to_plot <- gapminder %>%
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste(cntry, "_gdpPercap.png", sep = ""), plot = my_plot)
  
}
```

### Executable `for` loop\!

OK. So let’s start with the beginning of the `for` loop. We want a list
of countries that we will iterate through. We can do that by adding this
code before the `for` loop.

``` r
## create a list of countries
country_list <- c("Albania", "Fiji", "Spain")
for ( cntry in country_list ) {
  
  ## filter the country to plot
  gap_to_plot <- gapminder %>%
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste(cntry, "_gdpPercap.png", sep = ""), plot = my_plot)
}
```

At this point, we do have a functioning `for` loop. For each item in the
`country_list`, the `for` loop will iterate over the code within the `{
}`, changing `cntry` each time as it goes through the list. And we can
see it works because we can see them appear in the files pane at the
bottom right of RStudio\!

Great\! And it doesn’t matter if we just use these three countries or
all the countries–let’s try it.

But first let’s create a figure directory and make sure it saves there
since it’s going to get out of hand quickly. We could do this from the
Finder/Windows Explorer, or from the “Files” pane in RStudio by clicking
“New Folder” (green plus button). But we are going to do it in R. A
folder is called a directory:

``` r
dir.create("figures") 
## create a list of countries
country_list <- unique(gapminder$country) # ?unique() returns the unique values
for( cntry in country_list ){
  
  ## filter the country to plot
  gap_to_plot <- gapminder %>%
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## add the figures/ folder
  ggsave(filename = paste("figures/", cntry, "_gdpPercap.png", sep = "")), plot = my_plot)
} 
```

So that took a little longer than just the 3, but still super fast.
`for` loops are sometimes just the thing you need to iterate over many
things in your analyses.

### Clean up our repo

OK we now have 142 figures that we just created. They exist locally on
our computer, and we have the code to recreate them anytime. But, we
don’t really need to push them to GitHub. Let’s delete the figures/
folder and see it disappear from the Git tab.

<br> <br>

### Your turn

1.  Modify our `for` loop so that it:
      - loops through countries in Europe only
      - plots the cumulative mean gdpPercap (Hint: Use the [Data
        Wrangling
        Cheatsheet](https://www.rstudio.com/resources/cheatsheets/)\!)
      - saves them to a new subfolder inside the (recreated) figures
        folder called “Europe”.
2.  Sync to GitHub

<br> <br>

#### Answer

No peeking\!

``` r
dir.create("figures") 
dir.create("figures/Europe") 
## create a list of countries. Calculations go here, not in the for loop
gap_europe <- gapminder %>%
  filter(continent == "Europe") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))
country_list <- unique(gap_europe$country) # ?unique() returns the unique values

for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpPercap_cummean.png", sep = "")), 
  plot = my_plot)
} 
```

Notice how we put the calculation for `cummean()` outside the `for`
loop. It could have gone inside, but it’s an operation that could be
done just one time before hand (outside the loop) rather than multiple
times as you go (inside the `for` loop).

<br>

## Conditional statements with `if` and `else`

Often when we’re coding we want to control the flow of our actions. This
can be done by setting actions to occur only if a condition or a set of
conditions are met.

In R and other languages, these are called “if statements”.

### if statement basic structure

``` r
# if
if (condition is true) {
  do something
}
# if ... else
if (condition is true) {
  do something
} else {  # that is, if the condition is false,
  do something different
}
```

Let’s bring this concept into our `for` loop for Europe that we’ve just
done. What if we want to add the label “Estimated” to countries that
were estimated? Here’s what we’d do.

First, import csv file with information on whether data was estimated or
reported, and join to gapminder
dataset:

``` r
est <- readr::read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   estimated = col_character()
    ## )

``` r
gapminder_est <- left_join(gapminder, est)
```

    ## Joining, by = "country"

    ## Warning: Column `country` joining factor and character vector, coercing into
    ## character vector

``` r
dir.create("figures") 
dir.create("figures/Europe") 
## create a list of countries
gap_europe <- gapminder_est %>% ## use instead of gapminder
  filter(continent == "Europe") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))
country_list <- unique(gap_europe$country) 
for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message 
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## if estimated, add that as a subtitle. 
  if (gap_to_plot$estimated == "yes") {
    
    ## add a print statement just to check
    print(paste(cntry, "data are estimated"))
    
    my_plot <- my_plot +
      labs(sutbtitle("Estimated data"))
  }
  #   Warning message:
  # In if (gap_to_plot$estimated == "yes") { :
  #   the condition has length > 1 and only the first element will be used
  
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpPercap_cummean.png", sep = ""), 
         plot = my_plot)
  
} 
```

This worked, but we got a warning message with the if statement. This is
because if we look at `gap_to_plot$estimated`, it is many “yes”s or
“no”s, and the if statement works just on the first one. We know
that if any are yes, all are yes, but you can imagine that this could
lead to problems down the line if you *didn’t* know that. So let’s be
explicit:

### Executable if statement

``` r
dir.create("figures") 
dir.create("figures/Europe") 
## create a list of countries
gap_europe <- gapminder_est %>% ## use instead of gapminder
  filter(continent == "Europe") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))
country_list <- unique(gap_europe$country) 
for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message 
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## if estimated, add that as a subtitle. 
  if (any(gap_to_plot$estimated == "yes")) { # any() will return a single TRUE or FALSE
    
    print(paste(cntry, "data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
  }
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpPercap_cummean.png", sep = ""), 
         plot = my_plot)
  
} 
```

OK so this is working as we expect\! Note that we do not need an `else`
statement above, because we only want to do something (add a subtitle)
if one condition is met. But what if we want to add a different subtitle
based on another condition, say where the data are reported, to be extra
explicit about it?

### Executable if/else statement

``` r
dir.create("figures") 
dir.create("figures/Europe") 
## create a list of countries
gap_europe <- gapminder_est %>% ## use instead of gapminder
  filter(continent == "Europe") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))
country_list <- unique(gap_europe$country) 
for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message 
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ## if estimated, add that as a subtitle. 
  if (any(gap_to_plot$estimated == "yes")) { # any() will return a single TRUE or FALSE
    
    print(paste(cntry, "data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
  } else {
    
    my_plot <- my_plot +
      labs(subtitle = "Reported data")
    
    print(paste(cntry, "data are reported"))
    
  }
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpPercap_cummean.png", sep = ""), 
         plot = my_plot)
  
} 
```

Note that this works because we know there are only two conditions,
`Estimated == yes` and `Estimated == no`. In the first `if` statement we
asked for estimated data, and the `else` condition gives us everything
else (which we know is reported). We can be explicit about setting these
conditions in the `else` clause by instead using an `else if` statement.
Below is how you would construct this in your `for` loop, similar to
above:

``` r
  if (any(gap_to_plot$estimated == "yes")) { # any() will return a single TRUE or FALSE
    
    print(paste(cntry, "data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
  } else if (any(gap_to_plot$estimated == "no")){
    
    my_plot <- my_plot +
      labs(subtitle = "Reported data")
    
    print(paste(cntry, "data are reported"))
    
  }
```

    ## Warning: Unknown or uninitialised column: `estimated`.
    
    ## Warning: Unknown or uninitialised column: `estimated`.

This construction is necessary if you have more than two conditions to
test for.

<br>

We can also add the conditional addition of the plot subtitle with R’s
`ifelse()` function. It works like this

``` r
ifelse(condition is true, perform action, perform alternative action)
```

where the first argument is the condition or set of conditions to be
evaluated, the second argument is the action that is performed if the
condition is true, and the third argument is the action to be performed
if the condition is not true. We can add this directly within the
initial `labs()` layer of our plot for a more concise expression that
achives the same goal:

``` r
dir.create("figures") 
dir.create("figures/Europe") 
## create a list of countries
gap_europe <- gapminder_est %>% ## use instead of gapminder
  filter(continent == "Europe") %>%
  mutate(gdpPercap_cummean = dplyr::cummean(gdpPercap))
country_list <- unique(gap_europe$country) 
for( cntry in country_list ){ # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message 
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap_cummean)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "), subtitle = ifelse(any(gap_to_plot$estimated == "yes"), "Estimated data", "Reported data"))
  
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpPercap_cummean.png", sep = ""), 
         plot = my_plot)

} 
```

<br> \#\# Exercises (if time allows)

Exercises from [R for Data
Science](https://r4ds.had.co.nz/iteration.html#exercises-58)

Work with the specified datasets that are built into R or in the listed
packages. You can access them just by typing the name (for `flights` you
will have to first load the `nycflights13` package).

Write `for` loops to:

  - Compute the mean of every column in `mtcars`
  - Determine the type of each column in `nycflights13::flights`
  - Compute the number of unique values in each column of `iris`

<br>

## Concluding remarks

`for` loops are typically slow compared to vector based methods and
frequently not the best available solution, however they are easy to
implement and easy to understand so in many cases they can be a good
solution for simple iterations.
