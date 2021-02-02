# In-class exercises for Oct 7 2020

<br>

First load the libraries and data we will need
```{r, eval = TRUE, include = TRUE}
library(tidyverse)     ## install.packages("tidyverse")
library(skimr)        ## install.packages("skimr")

coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv', col_types = cols(province = col_character()))
```

<br>

### Exercise 1
Subset the coronavirus dataset to only include the daily counts of **confirmed** cases in countries located above 60 degree latitude. What are those countries?

If you have time, pipe it into ggplot() to visualize the trends over time in these countries.

<br>

### Exercise 2

Make sure you have run this code first:

```{r, eval=FALSE}
coronavirus_ttd <- coronavirus %>% 
  select(country, type, cases) %>%
  group_by(country, type) %>%
  summarize(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type,
              values_from = total_cases) %>%
  arrange(-confirmed)
```

Then add a new variable that shows the proportion of confirmed cases for which the outcome is still unknown (i.e. not counted as dead or recovered) for each country and show only countries with more than 1 million confirmed cases. Which country has the lowest proportion of undetermined outcomes? Why might that be?

<br>

### Exercise 3

How many countries have suffered more than 100,000 deaths so far and which five countries have recorded the highest death counts?

<br>

### Exercise 4

1. Go back to our original dataset coronavirus and identify where and when the highest death count in a single day was observed. Hint: you can either use or base::max or dplyr::arrange()

1. The first case was confirmed in the US on January 20 2020, two days before the earliest day included in this dataset. When was the first confirmed case recorded in Canada?

<br>

### Exercise 5

Which day has had the highest total death count globally so far?

If you have time, pipe your global daily death counts into ggplot to visualize the trend over time.

<br>

### Extra question

The month() function from the package lubridate extracts the month from a date. How many countries already have more than 1000 deaths in October?


