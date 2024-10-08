---
title: "Lesson 13: Wrap-up of relational data, then on to iteration with `for` loops and conditional execution with `if` statements"
output: 
  html_document:
    keep_md: yes 
    toc: true
---
  


<br>

## Readings

#### Required:

**Relational data**: 

If you didn't get a chance to read it last week, have a look at [Chapter 19 in in R for Data Science (2e)](https://r4ds.hadley.nz/joins) by Hadley Wickham, Mine Çetinkaya-Rundel & Garrett Grolemund

<br>

**Iteration**: 

The short [Section 27.5 on for loops in R for Data Science (2e)](https://r4ds.hadley.nz/base-r#for-loops)

OPTIONAL (for a more detailed overview of other types of iteration than those we will cover in class): [Chapter 26 on iteration in R for Data Science (2e)](https://r4ds.hadley.nz/iteration)


<br>

#### Other resources:
We will be working through [this tutorial](http://ohi-science.org/data-science-training/programming.html) developed by the Ocean Health Index Data Science Team

<br>
<br>


## Today's learning objectives

We'll start by working through a few exercises on combining data from multiple tibbles (using `join()` functions) and recap on strategies for successfully integrating relational data. Then we'll shift gears to begin exploring the key programming concepts of iteration and conditional execution.

By the end of today and next class, you should be able to:

* Write a `for` loop to repeat operations on different input
* Implement `if` and `if else` statements for conditional execution of code

<br>

**Acknowledgements**: Today's tutorial is adapted (with permission) from the excellent [Ocean Health Index Data Science Training](http://ohi-science.org/data-science-training/programming.html).

<br>
<br>

## Recap on relational data

Let's load the `tidyverse` and `knitr`


``` r
library(tidyverse)
library(knitr)
```

<br>
<br>

#### The `gapminder` data

Last class, we used the `nycflights13` datasets to explore the mutating joins. Let's recap by applying these to a different dataset. Today we'll return to the `gapminder` dataset that many of you have started exploring in the lab session a few weeks ago. 

The data in the `gapminder` package is a subset of the [Gapminder dataset](https://www.gapminder.org/tools/?from=world#$chart-type=bubbles), which contains data on the health and wealth of nations over the past decades. It was pioneered by [Hans Rosling](https://www.ted.com/speakers/hans_rosling), who is famous for describing the prosperity of nations over time through famines, wars and other historic events with this beautiful data visualization in his [2006 TED Talk: The best stats you've ever seen](https://www.ted.com/talks/hans_rosling_shows_the_best_stats_you_ve_ever_seen): 
 

[Gapminder Motion Chart](http://www.gapminder.org/world)  
[![Gapminder Motion Chart](https://github.com/remi-daigle/2016-04-15-UCSB/raw/gh-pages/viz/img/gapminder-world_motion-chart.png)](http://www.gapminder.org/world)  


<br>

We will primarily use a subset of the gapminder data included in the R package `gapminder`. So first we need to install that package and load it, along with the tidyverse. Then have a look at the data in `gapminder`


``` r
library(gapminder) #install.packages("gapminder")

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

<br>
<br>


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

In the lab section, we have been working with a different subset of the gapminder dataset that comes with the `dslabs` package. Let's import a chunk of those data that we've saved in our class GitHub repo:




``` r
gap_dslabs <- read_csv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/main/datasets/gapminder_dslabs_subset_original_names.csv")
```
<br>

#### Exercise

**Add the infant mortality and fertility data to our original `gapminder` data. Do we have those statistics for all observations?**

In this case, we were lucky that the variables that we wanted to join the tables by had identical names in the two datasets. Now, let's imagine the variables in the `dslab` version had been named differently. Run this code to change the variable names:


``` r
gap_dslabs_caps <- gap_dslabs |> 
  rename("Country" = country, "Year" = year)
```

<br>

**Now add the infant mortality and fertility from the `gap_dslabs_caps` to our original `gapminder data.**

<br>
<br>

<details>
  <summary>Click here for a solution</summary>


``` r
## When variable names are identical

# Natural join
gapminder |> 
  left_join(gap_dslabs)
```

```
## Joining with `by = join_by(country, year)`
```

```
## # A tibble: 1,704 × 8
##    country     continent  year life_exp      pop gdp_per_cap infant_mortality
##    <chr>       <fct>     <dbl>    <dbl>    <int>       <dbl>            <dbl>
##  1 Afghanistan Asia       1952     28.8  8425333        779.               NA
##  2 Afghanistan Asia       1957     30.3  9240934        821.               NA
##  3 Afghanistan Asia       1962     32.0 10267083        853.               NA
##  4 Afghanistan Asia       1967     34.0 11537966        836.               NA
##  5 Afghanistan Asia       1972     36.1 13079460        740.               NA
##  6 Afghanistan Asia       1977     38.4 14880372        786.               NA
##  7 Afghanistan Asia       1982     39.9 12881816        978.               NA
##  8 Afghanistan Asia       1987     40.8 13867957        852.               NA
##  9 Afghanistan Asia       1992     41.7 16317921        649.               NA
## 10 Afghanistan Asia       1997     41.8 22227415        635.               NA
## # ℹ 1,694 more rows
## # ℹ 1 more variable: fertility <dbl>
```

``` r
# Specifying the variables to join by (useful if some variables mean different things in the two tables you're joining)
gapminder |> 
  left_join(gap_dslabs, join_by(country, year))
```

```
## # A tibble: 1,704 × 8
##    country     continent  year life_exp      pop gdp_per_cap infant_mortality
##    <chr>       <fct>     <dbl>    <dbl>    <int>       <dbl>            <dbl>
##  1 Afghanistan Asia       1952     28.8  8425333        779.               NA
##  2 Afghanistan Asia       1957     30.3  9240934        821.               NA
##  3 Afghanistan Asia       1962     32.0 10267083        853.               NA
##  4 Afghanistan Asia       1967     34.0 11537966        836.               NA
##  5 Afghanistan Asia       1972     36.1 13079460        740.               NA
##  6 Afghanistan Asia       1977     38.4 14880372        786.               NA
##  7 Afghanistan Asia       1982     39.9 12881816        978.               NA
##  8 Afghanistan Asia       1987     40.8 13867957        852.               NA
##  9 Afghanistan Asia       1992     41.7 16317921        649.               NA
## 10 Afghanistan Asia       1997     41.8 22227415        635.               NA
## # ℹ 1,694 more rows
## # ℹ 1 more variable: fertility <dbl>
```

``` r
# When variable names are not identical
gapminder |> 
  left_join(gap_dslabs_caps, join_by(country == Country, year == Year))
```

```
## # A tibble: 1,704 × 8
##    country     continent  year life_exp      pop gdp_per_cap infant_mortality
##    <chr>       <fct>     <dbl>    <dbl>    <int>       <dbl>            <dbl>
##  1 Afghanistan Asia       1952     28.8  8425333        779.               NA
##  2 Afghanistan Asia       1957     30.3  9240934        821.               NA
##  3 Afghanistan Asia       1962     32.0 10267083        853.               NA
##  4 Afghanistan Asia       1967     34.0 11537966        836.               NA
##  5 Afghanistan Asia       1972     36.1 13079460        740.               NA
##  6 Afghanistan Asia       1977     38.4 14880372        786.               NA
##  7 Afghanistan Asia       1982     39.9 12881816        978.               NA
##  8 Afghanistan Asia       1987     40.8 13867957        852.               NA
##  9 Afghanistan Asia       1992     41.7 16317921        649.               NA
## 10 Afghanistan Asia       1997     41.8 22227415        635.               NA
## # ℹ 1,694 more rows
## # ℹ 1 more variable: fertility <dbl>
```

``` r
## Note, gap_dslabs doesn't have data for Afghanistan, so the join may not look successful if you just examine the first few lines. Look further down in the tibble.
```

</details>

<br>
<br>



#### Filtering joins

We'll review filtering joins and general strategies for combining information from multiple tables. There are some good examples with the `flights` data in [R4DS](https://r4ds.hadley.nz/joins#filtering-joins). Here, we will illustrate with the `gapminder` data.

<br>

Filtering joins match observations in the same way as mutating joins, but affect the observations, not the variables. There are two types:

* `semi_join(x, y)` keeps all observations in x that have a match in y.
* `anti_join(x, y)` drops all observations in x that have a match in y.

Semi-joins are useful for matching filtered summary tables back to the original rows.

<br>

These functions can be useful when we want to filter based on more than one variable. If we wanted to grab all the records from Malawi, for example, we can use `filter()`


``` r
gapminder |> 
  filter(country == "Malawi")
```

```
## # A tibble: 12 × 6
##    country continent  year life_exp      pop gdp_per_cap
##    <fct>   <fct>     <int>    <dbl>    <int>       <dbl>
##  1 Malawi  Africa     1952     36.3  2917802        369.
##  2 Malawi  Africa     1957     37.2  3221238        416.
##  3 Malawi  Africa     1962     38.4  3628608        428.
##  4 Malawi  Africa     1967     39.5  4147252        496.
##  5 Malawi  Africa     1972     41.8  4730997        585.
##  6 Malawi  Africa     1977     43.8  5637246        663.
##  7 Malawi  Africa     1982     45.6  6502825        633.
##  8 Malawi  Africa     1987     47.5  7824747        636.
##  9 Malawi  Africa     1992     49.4 10014249        563.
## 10 Malawi  Africa     1997     47.5 10419991        692.
## 11 Malawi  Africa     2002     45.0 11824495        665.
## 12 Malawi  Africa     2007     48.3 13327079        759.
```

<br>

However, say we wanted to extract the records from the countries and years that had the highest fertility rates recorded. It would be harder to do this with the `filter()` function in a single step. This is a case where `semi_join()` can be useful.


``` r
top_fertility <- gap_dslabs |> 
  arrange(-fertility) |> 
  head(10)

gapminder |> 
  semi_join(top_fertility)
```

```
## Joining with `by = join_by(country, year)`
```

```
## # A tibble: 6 × 6
##   country continent  year life_exp     pop gdp_per_cap
##   <fct>   <fct>     <int>    <dbl>   <int>       <dbl>
## 1 Oman    Asia       1982     62.7 1301048      12955.
## 2 Rwanda  Africa     1962     43   3051242        597.
## 3 Rwanda  Africa     1967     44.1 3451079        511.
## 4 Rwanda  Africa     1972     44.6 3992121        591.
## 5 Rwanda  Africa     1977     45   4657072        670.
## 6 Rwanda  Africa     1982     46.2 5507565        882.
```
We notice here that our resulting tibble only include 6 rows, not the 10 we had expected. Upon inspection, we notice that the records from Yemen are missing. We can confirm that this is because the `gapminder` tibble doesn't include "Yemen" (written this way) as a country by examining the unique values included in the country variable.


``` r
gapminder |> 
  distinct(country) |> 
  print(n = Inf)
```

```
## # A tibble: 142 × 1
##     country                 
##     <fct>                   
##   1 Afghanistan             
##   2 Albania                 
##   3 Algeria                 
##   4 Angola                  
##   5 Argentina               
##   6 Australia               
##   7 Austria                 
##   8 Bahrain                 
##   9 Bangladesh              
##  10 Belgium                 
##  11 Benin                   
##  12 Bolivia                 
##  13 Bosnia and Herzegovina  
##  14 Botswana                
##  15 Brazil                  
##  16 Bulgaria                
##  17 Burkina Faso            
##  18 Burundi                 
##  19 Cambodia                
##  20 Cameroon                
##  21 Canada                  
##  22 Central African Republic
##  23 Chad                    
##  24 Chile                   
##  25 China                   
##  26 Colombia                
##  27 Comoros                 
##  28 Congo, Dem. Rep.        
##  29 Congo, Rep.             
##  30 Costa Rica              
##  31 Cote d'Ivoire           
##  32 Croatia                 
##  33 Cuba                    
##  34 Czech Republic          
##  35 Denmark                 
##  36 Djibouti                
##  37 Dominican Republic      
##  38 Ecuador                 
##  39 Egypt                   
##  40 El Salvador             
##  41 Equatorial Guinea       
##  42 Eritrea                 
##  43 Ethiopia                
##  44 Finland                 
##  45 France                  
##  46 Gabon                   
##  47 Gambia                  
##  48 Germany                 
##  49 Ghana                   
##  50 Greece                  
##  51 Guatemala               
##  52 Guinea                  
##  53 Guinea-Bissau           
##  54 Haiti                   
##  55 Honduras                
##  56 Hong Kong, China        
##  57 Hungary                 
##  58 Iceland                 
##  59 India                   
##  60 Indonesia               
##  61 Iran                    
##  62 Iraq                    
##  63 Ireland                 
##  64 Israel                  
##  65 Italy                   
##  66 Jamaica                 
##  67 Japan                   
##  68 Jordan                  
##  69 Kenya                   
##  70 Korea, Dem. Rep.        
##  71 Korea, Rep.             
##  72 Kuwait                  
##  73 Lebanon                 
##  74 Lesotho                 
##  75 Liberia                 
##  76 Libya                   
##  77 Madagascar              
##  78 Malawi                  
##  79 Malaysia                
##  80 Mali                    
##  81 Mauritania              
##  82 Mauritius               
##  83 Mexico                  
##  84 Mongolia                
##  85 Montenegro              
##  86 Morocco                 
##  87 Mozambique              
##  88 Myanmar                 
##  89 Namibia                 
##  90 Nepal                   
##  91 Netherlands             
##  92 New Zealand             
##  93 Nicaragua               
##  94 Niger                   
##  95 Nigeria                 
##  96 Norway                  
##  97 Oman                    
##  98 Pakistan                
##  99 Panama                  
## 100 Paraguay                
## 101 Peru                    
## 102 Philippines             
## 103 Poland                  
## 104 Portugal                
## 105 Puerto Rico             
## 106 Reunion                 
## 107 Romania                 
## 108 Rwanda                  
## 109 Sao Tome and Principe   
## 110 Saudi Arabia            
## 111 Senegal                 
## 112 Serbia                  
## 113 Sierra Leone            
## 114 Singapore               
## 115 Slovak Republic         
## 116 Slovenia                
## 117 Somalia                 
## 118 South Africa            
## 119 Spain                   
## 120 Sri Lanka               
## 121 Sudan                   
## 122 Swaziland               
## 123 Sweden                  
## 124 Switzerland             
## 125 Syria                   
## 126 Taiwan                  
## 127 Tanzania                
## 128 Thailand                
## 129 Togo                    
## 130 Trinidad and Tobago     
## 131 Tunisia                 
## 132 Turkey                  
## 133 Uganda                  
## 134 United Kingdom          
## 135 United States           
## 136 Uruguay                 
## 137 Venezuela               
## 138 Vietnam                 
## 139 West Bank and Gaza      
## 140 Yemen, Rep.             
## 141 Zambia                  
## 142 Zimbabwe
```

``` r
# Could also use `unique(gapminder$country)`
```

<br>

So we would need to make sure country names are consistent in our two dataframes before proceeding (`str_replace()` is a good function for that).

In general, the opposite of `semi_join()`, the `anti_join()` function is good for diagnosing mismatches.


``` r
# What records in gapminder are not matched in gap_dslabs
gapminder |> 
  anti_join(gap_dslabs, join_by(country))  |> 
  distinct(country)
```

```
## # A tibble: 9 × 1
##   country              
##   <fct>                
## 1 Afghanistan          
## 2 Korea, Dem. Rep.     
## 3 Korea, Rep.          
## 4 Myanmar              
## 5 Reunion              
## 6 Sao Tome and Principe
## 7 Somalia              
## 8 Taiwan               
## 9 Yemen, Rep.
```

``` r
# What records in gap_dslabs are not matched in gapminder
gap_dslabs |> 
  anti_join(gapminder,  join_by(country))  |> 
  distinct(country)
```

```
## # A tibble: 52 × 1
##    country            
##    <chr>              
##  1 Antigua and Barbuda
##  2 Armenia            
##  3 Aruba              
##  4 Azerbaijan         
##  5 Bahamas            
##  6 Barbados           
##  7 Belarus            
##  8 Belize             
##  9 Bhutan             
## 10 Brunei             
## # ℹ 42 more rows
```

<br>

### Join problems – how to troubleshoot

* Start by identifying the variables that form the primary key in each table based on your understanding of the data
* Check that none of the variables in the primary key are missing. If a value is missing then it can’t identify an observation!
* Check that your foreign keys match primary keys in another table. The best way to do this is with an anti_join()

<br>
<br>

Now let's shift gears...

## Clone repo to get today's exercise sheet
First, to refresh our memory on RStudio-GitHub integration, let's start by cloning a repo with today's exercise sheet. The repo is located here: https://github.com/nt246/for-loop-exercise

Clone it to your local machine. Try first to see if you remember how. If you need a reminder of how we do this, revisit [lesson 3](https://nt246.github.io/NTRES-6100-data-science/lesson3-version-control.html#Clone_your_repository_using_RStudio).

Once you have an RStudio project linked to the `for-loop-exercises` repo, find the file `for-loop-exercises-name.Rmd`. Copy it to your your RStudio project for your own class repo, and change the file name by replacing `name` with your name.

Add a picture as instructed.

Push your changes to GitHub. If you need a reminder of how we do this, revisit [lesson 3](https://nt246.github.io/NTRES-6100-data-science/lesson3-version-control.html#Sync_from_RStudio_(local)_to_GitHub_(remote))

Check your class repo on GitHub (https://github.com/therkildsen-class/ntres-6100-fa2024-USERNAME [replace USERNAME with your GitHub user name]) to make sure your file shows up.

<br>
<br>
<br>


## Introduction to `for loops`

> This section is modified from [the iteration chapter in R for Data Science](https://r4ds.had.co.nz/iteration.html)

Whenever possible, we want to avoid duplication in our code (e.g. by copying-and-pasting sections of our script that we want to repeat with different input). Reducing code duplication has three main benefits:

* It’s easier to see the intent of your code, because your eyes are drawn to what’s different, not what stays the same.

* It’s easier to respond to changes in requirements. As your needs change, you only need to make changes in one place, rather than remembering to change every place that you copied-and-pasted the code. You eliminate the chance of making incidental mistakes when you copy and paste (i.e. updating a variable name in one place, but not in another).

* You’re likely to have fewer bugs because each line of code is used in more places.

One tool for reducing duplication is functions, which reduce duplication by identifying repeated patterns of code and extract them out into independent pieces that can be easily reused and updated. We'll go through a brief introduction to how to write functions in R next week. 

Another tool for reducing duplication is iteration, which helps you when you need to do the same thing to multiple inputs, e.g. repeating the same operation on different columns, or on different datasets. There are several ways to iterate in R. Today we will only cover `for` loops, which are a great place to start because they make iteration very explicit, so it’s obvious what’s happening. However, `for` loops are quite verbose, and require quite a bit of bookkeeping code that is duplicated for every `for` loop. Once you master `for` loops, you can solve many common iteration problems with less code, more ease, and fewer errors using functional programming, which I encourage you to explore on your own, for example in the [R for Data Science (2e)](https://r4ds.hadley.nz/iteration) book.

Today, we will illustrate the use of `for` loops with an example. We will also use conditional execution of code with `if` statements.

<br>
<br>


## Analysis plan

Here is the plan for our analysis: We want to plot how the gdp_per_cap for each country in the `gapminder` data frame has changed over time. So that's 142 separate plots! We will automate this, labeling each plot with its name and saving it in a folder called figures. We will learn a bunch of things as we go. 

<br>


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

