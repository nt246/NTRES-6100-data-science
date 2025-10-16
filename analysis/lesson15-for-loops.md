---
title: "Lesson 15: Iteration with `for` loops and conditional execution with `if` statements"
output: 
  html_document:
    keep_md: yes 
    toc: true
---
  


<br>

## Readings

#### Required:

The short [Section 27.5 on for loops in R for Data Science (2e)](https://r4ds.hadley.nz/base-r#for-loops)

OPTIONAL (for a more detailed overview of other types of iteration than those we will cover in class): [Chapter 26 on iteration in R for Data Science (2e)](https://r4ds.hadley.nz/iteration)


<br>

#### Other resources:
We will be working through [this tutorial](http://ohi-science.org/data-science-training/programming.html) developed by the Ocean Health Index Data Science Team

<br>
<br>

## Announcements

* Remember that we'll meet in our new classroom Morrison 348 today and for the remaining lectures of the course

* Reminder that we will end-of-course short student presentations on Thursday Oct 30. See details [here](https://github.com/nt246/NTRES-6100-data-science/blob/main/misc/student_presentations.md) and please indicate in the google sheet shared in class and on Slack whether you'll be giving a presentation (required for students taking the course for credit, encouraged for auditors)

<br>
<br>


## Today's learning objectives

Today, we'll begin exploring the key programming concepts of iteration and conditional execution.

By the end of today and next class, you should be able to:

* Write a `for` loop to repeat operations on different input
* Implement `if` and `if else` statements for conditional execution of code

<br>

**Acknowledgements**: Today's tutorial is adapted (with permission) from the excellent [Ocean Health Index Data Science Training](http://ohi-science.org/data-science-training/programming.html).

<br>
<br>


## Clone repo to get today's exercise sheet
First, to refresh our memory on RStudio-GitHub integration, let's start by cloning a repo with today's exercise sheet. The repo is located here: https://github.com/nt246/for-loop-exercise

Clone it to your local machine. Try first to see if you remember how. If you need a reminder of how we do this, revisit [lesson 3](https://nt246.github.io/NTRES-6100-data-science/lesson3-version-control.html#Clone_your_repository_using_RStudio).

Once you have an RStudio project linked to the `for-loop-exercises` repo, find the file `for-loop-exercises-name.qmd`. Copy it to your your RStudio project for your own class repo, and change the file name by replacing `name` with your name.

Add a picture as instructed.

Push your changes to GitHub. If you need a reminder of how we do this, revisit [lesson 3](https://nt246.github.io/NTRES-6100-data-science/lesson3-version-control.html#Sync_from_RStudio_(local)_to_GitHub_(remote))

Check your class repo on GitHub (https://github.com/therkildsen-class/ntres-6100-assignments-USERNAME [replace USERNAME with your GitHub user name]) to make sure your file shows up.

<br>
<br>
<br>


## Introduction to `for loops`

> This section is modified from [the iteration chapter in R for Data Science](https://r4ds.had.co.nz/iteration.html)

Whenever possible, we want to avoid duplication in our code (e.g. by copying-and-pasting sections of our script that we want to repeat with different input). Reducing code duplication has three main benefits:

* It’s easier to see the intent of your code, because your eyes are drawn to what’s different, not what stays the same.

* It’s easier to respond to changes in requirements. As your needs change, you only need to make changes in one place, rather than remembering to change every place that you copied-and-pasted the code. You eliminate the chance of making incidental mistakes when you copy and paste (i.e. updating a variable name in one place, but not in another).

* You’re likely to have fewer bugs because each line of code is used in more places.

One tool for reducing duplication is functions, which reduce duplication by identifying repeated patterns of code and extract them out into independent pieces that can be easily reused and updated. We'll go through a brief introduction to how to write functions in R later in the course. 

Another tool for reducing duplication is iteration, which helps you when you need to do the same thing to multiple inputs, e.g. repeating the same operation on different columns, or on different datasets. There are several ways to iterate in R. Today we will only cover `for` loops, which are a great place to start because they make iteration very explicit, so it’s obvious what’s happening. However, `for` loops are quite verbose, and require quite a bit of bookkeeping code that is duplicated for every `for` loop. Once you master `for` loops, you can solve many common iteration problems with less code, more ease, and fewer errors using functional programming, which I encourage you to explore on your own, for example in the [R for Data Science (2e)](https://r4ds.hadley.nz/iteration) book.

Today, we will illustrate the use of `for` loops with an example. We will also use conditional execution of code with `if` statements.

<br>
<br>



## Load in the data

Today we'll return to the gapminder dataset that we have used previously. The data in the `gapminder` package is a subset of the [Gapminder dataset](https://www.gapminder.org/tools/?from=world#$chart-type=bubbles), which contains data on the health and wealth of nations over the past decades. It was pioneered by [Hans Rosling](https://www.ted.com/speakers/hans_rosling), who is famous for describing the prosperity of nations over time through famines, wars and other historic events with this beautiful data visualization in his [2006 TED Talk: The best stats you've ever seen](https://www.ted.com/talks/hans_rosling_shows_the_best_stats_you_ve_ever_seen):

[Gapminder Motion Chart](http://www.gapminder.org/world)\
[![Gapminder Motion Chart](https://github.com/remi-daigle/2016-04-15-UCSB/raw/gh-pages/viz/img/gapminder-world_motion-chart.png)](http://www.gapminder.org/world)

<br>

We will primarily use a subset of the gapminder data included in the R package `gapminder`. So first we need to install that package and load it, along with the tidyverse. Then have a look at the data in `gapminder`


``` r
library(tidyverse)
library(gapminder) #install.packages("gapminder")
library(knitr)

head(gapminder) |>
  kable()
```



|country     |continent | year| lifeExp|      pop| gdpPercap|
|:-----------|:---------|----:|-------:|--------:|---------:|
|Afghanistan |Asia      | 1952|  28.801|  8425333|  779.4453|
|Afghanistan |Asia      | 1957|  30.332|  9240934|  820.8530|
|Afghanistan |Asia      | 1962|  31.997| 10267083|  853.1007|
|Afghanistan |Asia      | 1967|  34.020| 11537966|  836.1971|
|Afghanistan |Asia      | 1972|  36.088| 13079460|  739.9811|
|Afghanistan |Asia      | 1977|  38.438| 14880372|  786.1134|

<br> <br>

We can see that this dataset used camelCase (first word lowercase and capitalize all following words) for its column names. I always use snake_case (replace spaces with underscores), and it's going to look messy to have this inconsistent way of writing variable names. So I'm going to go ahead and clean these names up before I start working with the data. I can do this manually with the `rename()` or `colnames()` functions, e.g.


``` r
gapminder <- gapminder |> 
  rename("life_exp" = lifeExp, "gdp_per_cap" = gdpPercap)


# Alternative
colnames(gapminder) <- c("country", "continent", "year", "life_exp", "pop", "gdp_per_cap")
```

<br>

Alternatively, I can use the `clean_names()` function from the `janitor` package


``` r
library(janitor)

clean_names(gapminder)
```

<br>
<br>

## Analysis plan

Here is the plan for our analysis: We want to plot how the gdp_per_cap for each country in the `gapminder` data frame has changed over time. So that's 142 separate plots! We will automate this, labeling each plot with its name and saving it in a folder called figures. We will learn a bunch of things as we go. 



## Automation with `for` loops

Our plan is to plot gdp_per_cap vs. year for each country. This means that we want to do the same operation (plotting gdp_per_cap) on a bunch of different things (countries). We've worked with dplyr's `group_by()` function, and this is super powerful to automate through groups. But there are things that you may not want to do with `group_by()`, like plotting. So here, we will use a `for` loop.

Let's start off with what this would look like for just one country. I'm going to demonstrate with Afghanistan:

<!---TODO
For the figures, we want it to label the currency, which we have in another data file (=join). And, we'll want to add Westeros to the dataframe (=rbind) and create that figure too. 
--->


``` r
## filter the country to plot
gap_to_plot <- gapminder |>
  filter(country == "Afghanistan")

## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_per_cap)) + 
  geom_point() +
  labs(title = "Afghanistan")
```

<br>

Let's actually give this a better title than just the country name. Let's use the function `str_c()` to paste two strings together so that the title is more descriptive. Use `?str_c` to see what the "sep" variable does. 

``` r
## filter the country to plot
gap_to_plot <- gapminder |>
  filter(country == "Afghanistan")

## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_per_cap)) + 
  geom_point() +
  ## add title and save
  labs(title = str_c("Afghanistan", "GDP per capita", sep = " "))
```

<br>

And as a last step, let's save this figure. 


``` r
## filter the country to plot
gap_to_plot <- gapminder |>
  filter(country == "Afghanistan")

## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_per_cap)) + 
  geom_point() +
  ## add title and save
  labs(title = str_c("Afghanistan", "GDP per capita", sep = " "))

ggsave(filename = "Afghanistan_gdp_per_cap.png", plot = my_plot)
```

<br>

OK. So we can check our repo in the file pane (bottom right of RStudio) and see the generated figure:

<img src="assets/Afghanistan_gdp_per_cap.png" width="50%" />

<br>
<br>

### Thinking ahead: cleaning up our code

Now, in our code above, we've had to write out "Afghanistan" several times. This makes it not only typo-prone as we type it each time, but if we wanted to plot another country, we'd have to write that in 3 places too. It is not setting us up for an easy time in our future, and thinking ahead in programming is something to keep in mind. 

Instead of having "Afghanistan" written 3 times, let's instead create an object that we will assign "Afghanistan" to. We won't name our object "country" because that's a column header with gapminder, and will just confuse us. Let's make it distinctive: let's write cntry (country without vowels):


``` r
## create country variable
cntry <- "Afghanistan"
```

<br>

Now, we can replace each `"Afghanistan"` with our variable `cntry`. We will have to introduce a `str_c()` statement in the `ggsave()` function too, and we want to separate by nothing (`""`) because we don't want spaces in our filenames. 


``` r
## create country variable
cntry <- "Afghanistan"

## filter the country to plot
gap_to_plot <- gapminder |>
  filter(country == cntry)

## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_per_cap)) + 
  geom_point() +
  ## add title and save
  labs(title = str_c(cntry, "GDP per capita", sep = " "))
## note: there are many ways to create filenames with str_c(), str_c() or file.path(); we are doing this way for a reason.

ggsave(filename = str_c(cntry, "_gdp_per_cap.png", sep = ""), plot = my_plot)
```

<br>

Let's run this. Great! it saved our figure (I can tell this because the timestamp in the Files pane has updated!)

<br>

### `for` loop basic structure

Now, how about if we want to plot not only Afghanistan, but other countries as well? There wasn't actually that much code needed to get us here, but we definitely do not want to copy this for every country. Even if we copy-pasted and switched out the country assigned to the `cntry` variable, it would be very typo-prone. Plus, what if you wanted to instead plot life_exp? You'd have to remember to change it each time... it quickly gets messy. 

Better with a `for` loop. This will let us cycle through and do what we want to each thing in turn. If you want to iterate over a set of values, and perform the same operation on each, a `for` loop will do the job.

**Sit back and watch me for a few minutes while we develop the `for` loop.** Then we'll give you time to do this on your computers as well. 

The basic structure of a `for` loop is:

``` r
for (each_item in set_of_items) {
  do a thing
}
```
Note the `( )` and the `{ }`. We talk about iterating through each item in the `for` loop, which makes each item an iterator.

So looking back at our Afghanistan code: all of this is pretty much the "do a thing" part. And we can see that there are only a few places that are specific to Afghanistan. If we could make those places not specific to Afghanistan, we would be set. 

![](assets/for_loop_logic.png)
<br>

Let's paste from what we had before, and modify it. I'm also going to use RStudio's indentation help to indent the lines within the `for` loop by highlighting the code in this chunk and going to Code > Reindent Lines (shortcut: command I)

``` r
## create country variable
cntry <- "Afghanistan"
for (each cntry in a list_of_countries) {
  
  ## filter the country to plot
  gap_to_plot <- gapminder |>
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_per_cap)) + 
    geom_point() +
    ## add title and save
    labs(title = str_c(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = str_c(cntry, "_gdp_per_cap.png", sep = ""), plot = my_plot)
  
}
```

<br>

### Executable `for` loop!

OK. So let's start with the beginning of the `for` loop. We want a list of countries that we will iterate through. We can do that by adding this code before the `for` loop.


``` r
## create a list of countries
country_list <- c("Albania", "Canada", "Spain")

for (cntry in country_list) {
  
  ## filter the country to plot
  gap_to_plot <- gapminder |>
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_per_cap)) + 
    geom_point() +
    ## add title and save
    labs(title = str_c(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = str_c(cntry, "_gdp_per_cap.png", sep = ""), plot = my_plot)
}
```

<br>

At this point, we do have a functioning `for` loop. For each item in the `country_list`, the `for` loop will iterate over the code within the `{ }`, changing `cntry` each time as it goes through the list. And we can see it works because we can see them appear in the files pane at the bottom right of RStudio!

Great! And it doesn't matter if we just use these three countries or all the countries - let's try it. 

But first let's create a figure directory and make sure it saves there since it's going to get out of hand quickly. We could do this from the Finder/Windows Explorer, or from the "Files" pane in RStudio by clicking "New Folder" (green plus button). But we are going to do it in R. A folder is called a directory:


``` r
dir.create("figures") 

## create a list of countries
country_list <- unique(gapminder$country) # ?unique() returns the unique values

for (cntry in country_list) {
  
  ## filter the country to plot
  gap_to_plot <- gapminder |>
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_per_cap)) + 
    geom_point() +
    ## add title and save
    labs(title = str_c(cntry, "GDP per capita", sep = " "))
  
  ## add the figures/ folder
  ggsave(filename = str_c("figures/", cntry, "_gdp_per_cap.png", sep = ""), plot = my_plot)
} 
```

So that took a little longer than just the 3, but still super fast. `for` loops are sometimes just the thing you need to iterate over many things in your analyses. 

<br>

### Clean up our repo

OK we now have 142 figures that we just created. They exist locally on our computer, and we have the code to recreate them anytime. But, we don't really need to push them to GitHub. Let's delete the figures/ folder and see it disappear from the Git tab. An alternative to deleting the figures would be to add them to our .gitignore file. Read more about that [here](https://carpentries-incubator.github.io/git-Rstudio-course/02-ignore/index.html) and play around with it.

<br>
<br>

### Your turn

Use the worksheet we copied from the cloned GitHub repo to

1. Modify our `for` loop so that it: 
    - loops through countries in Europe only
    - plots the product of gdp_per_cap and population size per year (should approximate the total GDP) instead of the gdp_per_cap
    - saves the plots to a new subfolder inside the (recreated) figures folder called "Europe".
1. Sync to GitHub

<br>
<br>

#### Answer

<details>
  <summary>click to see our approach</summary>
  

``` r
dir.create("figures") 
dir.create("figures/Europe") 

## create a list of countries. Calculations go here, not in the for loop
gap_europe <- gapminder |>
  filter(continent == "Europe") |>
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country) # ?unique() returns the unique values

for (cntry in country_list) { # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe |>
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(str_c("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_tot)) + 
    geom_point() +
    ## add title and save
    labs(title = str_c(cntry, "GDP", sep = " "))
  
  ggsave(filename = str_c("figures/Europe/", cntry, "_gdp_tot.png", sep = ""), plot = my_plot)
} 
```

Notice how we put the calculation of `gdp_per_cap` * `pop` outside the `for` loop. It could have gone inside, but it's an operation that could be done just one time before hand (outside the loop) rather than multiple times as you go (inside the `for` loop). 

</details>

<br>
<br>

## Conditional statements with `if` and `else` 

Often when we're coding we want to control the flow of our actions. This can be done
by setting actions to occur only if a condition or a set of conditions are met.

In R and other languages, these are called "if statements". 

<br>

### if statement basic structure


``` r
# if
if (condition is true) {
  do something
}

# if, else
if (condition is true) {
  do something
} else {  # that is, if the condition is false,
  do something different
}
```

<br>

Let's bring this concept into our `for` loop for Europe that we've just created. What if we want to add the label "Estimated" to countries for which the values were estimated rather than based on official reported statistics? Here's what we'd do.

First, import a csv file with information on whether data was estimated or reported, and join to gapminder dataset:


``` r
est <- read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')
gapminder_est <- left_join(gapminder, est)
```


``` r
dir.create("figures") 
dir.create("figures/Europe") 

## create a list of countries. Calculations go here, not in the for loop
gap_europe <- gapminder_est |>  # Here we use the gapminder_est that includes information on whether data were estimated
  filter(continent == "Europe") |>
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country) # ?unique() returns the unique values

for (cntry in country_list) { # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe |>
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(str_c("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_tot)) + 
    geom_point() +
    ## add title and save
    labs(title = str_c(cntry, "GDP", sep = " "))
  
  ## if estimated, add that as a subtitle. 
  if (gap_to_plot$estimated == "yes") {
    
    ## add a print statement just to check
    print(str_c(cntry, " data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
  }
  #   Warning message:
  # In if (gap_to_plot$estimated == "yes") { :
  #   the condition has length > 1 and only the first element will be used
  
  ggsave(filename = str_c("figures/Europe/", cntry, "_gdp_tot.png", sep = ""), 
         plot = my_plot)
  
} 
```

This worked, but we got a warning message with the `if` statement. This is because if we look at `gap_to_plot$estimated`, it is many "yes"s or "no"s, and the if statement works just on the first one. We know that if any are yes, all are yes, but you can imagine that this could lead to problems down the line if you *didn't* know that. So let's be explicit:

<br>

### Executable if statement


``` r
dir.create("figures") 
dir.create("figures/Europe") 

## create a list of countries. Calculations go here, not in the for loop
gap_europe <- gapminder_est |>  # Here we use the gapminder_est that includes information on whether data were estimated
  filter(continent == "Europe") |>
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country) # ?unique() returns the unique values

for (cntry in country_list) { # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe |>
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(str_c("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_tot)) + 
    geom_point() +
    ## add title and save
    labs(title = str_c(cntry, "GDP", sep = " "))
  
## if estimated, add that as a subtitle. 
if (any(gap_to_plot$estimated == "yes")) { # any() will return a single TRUE or FALSE
  
    ## add a print statement just to check
    print(str_c(cntry, " data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
  }
  
  ggsave(filename = str_c("figures/Europe/", cntry, "_gdp_tot.png", sep = ""), 
         plot = my_plot)
  
} 
```

OK so this is working as we expect! Note that we do not need an `else` statement above, because we only want to do something (add a subtitle) if one condition is met. But what if we want to add a different subtitle based on another condition, say where the data are reported, to be extra explicit about it?

<br>

### Executable if/else statement


``` r
dir.create("figures") 
dir.create("figures/Europe") 

## create a list of countries. Calculations go here, not in the for loop
gap_europe <- gapminder_est |>  # Here we use the gapminder_est that includes information on whether data were estimated
  filter(continent == "Europe") |>
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country) # ?unique() returns the unique values

for (cntry in country_list) { # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe |>
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(str_c("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_tot)) + 
    geom_point() +
    ## add title and save
    labs(title = str_c(cntry, "GDP", sep = " "))
  
## if estimated, add that as a subtitle. 
if (any(gap_to_plot$estimated == "yes")) { # any() will return a single TRUE or FALSE
  
    ## add a print statement just to check
    print(str_c(cntry, " data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
} else {
  
  print(str_c(cntry, " data are reported"))
  
  my_plot <- my_plot +
    labs(subtitle = "Reported data") }

  ggsave(filename = str_c("figures/Europe/", cntry, "_gdp_tot.png", sep = ""), 
         plot = my_plot)
  
} 
```

Note that this works because we know there are only two conditions, `Estimated == yes` and `Estimated == no`. In the first `if` statement we asked for estimated data, and the `else` condition gives us everything else (which we know is reported). We can be explicit about setting these conditions in the `else` clause by instead using an `else if` statement. Below is how you would construct this in your `for` loop, similar to above:


``` r
  if (any(gap_to_plot$estimated == "yes")) { # any() will return a single TRUE or FALSE
    
    print(str_c(cntry, "data are estimated"))
    
    my_plot <- my_plot +
      labs(subtitle = "Estimated data")
  } else if (any(gap_to_plot$estimated == "no")){
    
    print(str_c(cntry, "data are reported"))
    
    my_plot <- my_plot +
      labs(subtitle = "Reported data")
    
  }
```

This construction is necessary if you have more than two conditions to test for.


<br>
<br>

We can also add the conditional addition of the plot subtitle with R's `ifelse()` function. It works like this


``` r
ifelse(condition is true, perform action, perform alternative action)
```

where the first argument is the condition or set of conditions to be evaluated, the second argument is the action that is performed if the condition is true, and the third argument is the action to be performed if the condition is not true. We can add this directly within the initial `labs()` layer of our plot for a more concise expression that achieves the same goal: 


``` r
dir.create("figures") 
dir.create("figures/Europe") 

## create a list of countries. Calculations go here, not in the for loop
gap_europe <- gapminder_est |>  # Here we use the gapminder_est that includes information on whether data were estimated
  filter(continent == "Europe") |>
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country) # ?unique() returns the unique values

for (cntry in country_list) { # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe |>
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(str_c("Plotting ", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_tot)) + 
    geom_point() +
    ## add title and save
    labs(title = str_c(cntry, "GDP", sep = " "), subtitle = ifelse(any(gap_to_plot$estimated == "yes"), "Estimated data", "Reported data"))

  ggsave(filename = str_c("figures/Europe/", cntry, "_gdp_tot.png", sep = ""), 
         plot = my_plot)
  
} 
```

<br>
<br>

## Exercises (if time allows)

Exercises from [R for Data Science](https://r4ds.had.co.nz/iteration.html#exercises-58)

Work with the specified datasets that are built into R or in the listed packages. You can access them just by typing the name (for `flights` you will have to first load the `nycflights13` package).

Write `for` loops to:

* Compute the mean of every column in `mtcars`
* Determine the type of each column in `nycflights13::flights`
* Compute the number of unique values in each column of `iris`


<br>

## Concluding remarks

`for` loops are typically slow compared to vector based methods and frequently not the best available solution for implementing iterations. We therefore recommend that you learn about other approaches, especially the map functions and functional programming. However, `for` loops are easy to implement and easy to understand so in many cases they can be a good solution for simple iterations.

