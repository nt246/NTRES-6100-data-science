---
title: "Lesson 16: Functions"
output: 
  html_document:
    keep_md: yes 
    toc: true
---
  


<br>

## Readings

<br>

#### Required: 

* [Chapter 19](https://r4ds.had.co.nz/functions.html) in R for Data Science by Hadley Wickham & Garrett Grolemund

<br>

#### Other resources:

* [Chapters 18-21](https://stat545.com/functions-part1.html) in Jenny Bryan's STAT545 notes

<br>

## Announcements
* Next week is our last week - only two more classes left
* You will be giving your 1.5 minute [end-of-class student presentations](https://github.com/nt246/NTRES-6100-data-science/blob/main/misc/student_presentations.md) next Wednesday (April 14). Please indicate [here](https://docs.google.com/spreadsheets/d/17RTFOwSfgNFCLpIBzgNJrYXP7nPkaTwxQGSUMfW1fh8/edit?usp=sharing) whether you will be giving your presentation during the live Zoom call (preferred) or submit a video. The presentations are part of the requirements to pass the course. Auditors are encouraged, but not required, to present.

<br>

## Today's learning objectives
Today, we will cover a brief introduction to how to write your own functions in R.

By the end of today's class, you should be able to:

* Write a simple function to automate a task
* Set default values for function arguments
* Explain why we should divide code into small, single-purpose functions

<br>
<br>

## Getting started with functions

As always, we'll need the tidyverse, so let's start by loading that in


```r
library(tidyverse)
```

<br>
<br>

We will first introduce functions with [these slides](https://github.com/nt246/NTRES-6100-data-science/blob/main/slides/slides_functions.pdf)

Then we'll illustrate how to write a basic function with the example described in [Data Carpentry's semester program lecture notes](https://datacarpentry.org/semester-biology/materials/functions-R/)

<br>
<br>


## An example application

Last week, we developed a `for loop` to create a plot for every country in a list of countries. We can re-write the plotting operation as a function that we can call for specific countries.

To try that, we'll first need to load the gapminder dataset back in:


```r
library(gapminder) #install.packages("gapminder")

gapminder
```

<br>

To simplify the code, let's go back to what our loop looked like before we added the conditional statements:


```r
dir.create("figures") 
dir.create("figures/Europe") 

## create a list of countries. Calculations go here, not in the for loop
gap_europe <- gapminder %>%
  filter(continent == "Europe") %>%
  mutate(gdpTot = gdpPercap * pop)

country_list <- unique(gap_europe$country) # ?unique() returns the unique values

for (cntry in country_list) { # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpTot)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpTot.png", sep = ""), plot = my_plot)
} 
```

<br>
<br>

Now, we can change this into a function in the following way:

![](assets/for_loop_to_function.png)

<br>

Here is our function:


```r
dir.create("figures") 
dir.create("figures/Europe") 

## We still keep our calculation outside the function because we can do this as a single step for all countries outside the function. But we could also build this step into our function if we prefer.
gap_europe <- gapminder %>%
  filter(continent == "Europe") %>%
  mutate(gdpTot = gdpPercap * pop)

#define our function
save_plot <- function(cntry) {
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpTot)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpTot.png", sep = ""), plot = my_plot)
} 
```

<br>

We can not run this function on specific countries


```r
save_plot("Germany")
save_plot("France")

# We can even write a for loop to run the function on each country in a list of countries (doing exactly the same as our for loop did before, but now we have pulled the code specifying the operation out of the for loop itself)

country_list <- unique(gap_europe$country) # ?unique() returns the unique values

for (cntry in country_list) {
  
  save_plot(cntry)
  
}
```

<br>

Now we can add some more flexibility to our function. Currently, it is written to always plot the total GDP vs. year for a country. We can change the function so that it can plot other variables on the y-axis, as specified with an additional argument we provide when we call (and define) the function.


```r
dir.create("figures") 
dir.create("figures/Europe") 

## We still keep our calculation outside the function because we can do this as a single step for all countries outside the function. But we could also build this step into our function if we prefer.
gap_europe <- gapminder %>%
  filter(continent == "Europe") %>%
  mutate(gdpTot = gdpPercap * pop)

#define our function
save_plot <- function(cntry, stat) {   # Here I'm adding an additional argument to the function, which we'll use to specify what statistic we want plotted
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = get(stat))) +    # We need to use get() here to access the value we store as stat when we call the function
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, stat, sep = " "), y = stat)
  
  ggsave(filename = paste("figures/Europe/", cntry, "_", stat, ".png", sep = ""), plot = my_plot)
} 


# Let's try calling the function with different statistics and check the outputs

save_plot("Germany", "gdpPercap")
save_plot("Germany", "pop")
save_plot("Germany", "lifeExp")
```

<br>

This seems to work well. But what happens if we forget to specify the statistic we want plotted?

```r
save_plot("Germany")
```

We get an error message saying "argument "stat" is missing, with no default". We can build in a default the following way:

```r
#define our function
save_plot <- function(cntry, stat = "gdpPercap") {  
```

<br>

Now, if we don't specify the statistic we want plotted, the function will execute with this specified default option. The default gets "overwritten" if we do specify a stat when we call the function.


```r
dir.create("figures") 
dir.create("figures/Europe") 

## We still keep our calculation outside the function because we can do this as a single step for all countries outside the function. But we could also build this step into our function if we prefer.
gap_europe <- gapminder %>%
  filter(continent == "Europe") %>%
  mutate(gdpTot = gdpPercap * pop)

#define our function
save_plot <- function(cntry, stat = "gdpPercap") {   # Here I'm adding an additional argument to the function, which we'll use to specify what statistic we want plotted
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = get(stat))) +    # We need to use get() here to access the value we store as stat when we call the function
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, stat, sep = " "), y = stat)
  
  ggsave(filename = paste("figures/Europe/", cntry, "_", stat, ".png", sep = ""), plot = my_plot)
} 


# Let's try calling the function with and without specifying a statistic to plot and check the outputs

save_plot("Germany")
save_plot("Germany", "lifeExp")
```

<br>
<br>

### Your turn

We've talked about how we can change the file type that `ggsave()` will output just by changing the extension of the specified name we want to give the file. It works like this:


```r
# To save a .png file
ggsave(filename = "figures/Europe/Germany_gdpPercap.png", plot = my_plot)

# To save a .jpg file
ggsave(filename = "figures/Europe/Germany_gdpPercap.jpg", plot = my_plot)

# To save a .pdf file
ggsave(filename = "figures/Europe/Germany_gdpPercap.pdf", plot = my_plot)
```

<br>

**Your task:** Add an argument to our function that specifies the file type you want for the plot and edit the function so that it will output the requested file type. You can also specify a default file type that the function will use if you don't specify a file type when you call it.

If you have more time, you can also add an additional argument that specifies the plot type (x-y scatter, line plot etc) and adjust the function to accommodate this.

<br>

#### Answer

<details>
  <summary>click to see our approach</summary>
  

```r
dir.create("figures") 
dir.create("figures/Europe") 

## We still keep our calculation outside the function because we can do this as a single step for all countries outside the function. But we could also build this step into our function if we prefer.
gap_europe <- gapminder %>%
  filter(continent == "Europe") %>%
  mutate(gdpTot = gdpPercap * pop)

#define our function
save_plot <- function(cntry, stat = "gdpPercap", filetype = "pdf") {   # Here I'm adding additional arguments to the function, which we'll use to specify what statistic we want plotted and what filetype we want
  
  ## filter the country to plot
  gap_to_plot <- gap_europe %>%
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = get(stat))) +    # We need to use get() here to access the value we store as stat when we call the function
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, stat, sep = " "), y = stat)
  
  ggsave(filename = paste("figures/Europe/", cntry, "_", stat, ".", filetype, sep = ""), plot = my_plot)
} 


# Testing our function
save_plot("Germany")
save_plot("Germany", "lifeExp", "jpg")
```

</details>

<br>
<br>

## Testing your functions

If there is time, we'll walk through part of the example in [Chapters 18-21](https://stat545.com/functions-part1.html) in Jenny Bryan's STAT545 notes
