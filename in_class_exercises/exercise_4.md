Exercise 4: Data visualization with ggplot
================

Please work through these exercises in an RMarkdown file in your personal GitHub repository. This way, you will have a chance to practice your RMarkdown and GitHub skills, and will be able to share your work easily with the class.

To start, first load all the required package with the following code. Install them if they are not installed yet.

``` r
library(tidyverse)
library(knitr)
```

Exercise 1. Trend in land value
-------------------------------

This excercise uses a dataset that describes the trend of land value (`Land.Value`), among other variables, in different states in the US 1975-2013. The states are grouped into four different regions, under the variable `region`.

<br>

#### 1.1 First, load data. Also, **hide the `head(economics)` output but keep the code**.

``` r
housing <- read_csv("https://raw.githubusercontent.com/nt246/NTRES6940-data-science/master/datasets/landdata_states.csv")
head(economics) ## Hide the output of this
```

<br>

#### 1.2 Plot the trend of land values in all states in the same plot and assign a different color to each state.

``` r
p5 <- ggplot(housing, aes(x = Date, y = Land.Value))
p5 + geom_line(aes(color = State))
```

![](exercise_4_files/figure-markdown_github/unnamed-chunk-3-1.png)

<br>

#### 1.3 Use facetting to plot each state in a different plot, as the following.

``` r
p5 <- ggplot(housing, aes(x = Date, y = Land.Value))
p5 + geom_line() + facet_wrap(~State, ncol = 10)
```

![](exercise_4_files/figure-markdown_github/unnamed-chunk-4-1.png)

<br>

#### 1.4 When should we use aesthetic mapping, and when should we use facetting?

<br>

Exercise 2. Fuel efficiency
---------------------------

Continue to explore the `mpg` dataset using data visualization with `ggplot2`. Many variables in this dataset, including `fl`, `manufacturer`, `drv`, `trans`, and `cty` have not been sufficiently examined in lecture, and may generate some interesting insight.
