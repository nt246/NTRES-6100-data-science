
# Loading libraries -------------------------------------------------------

library(tidyverse)
library(gapminder)
library(gridExtra) # install.packages("gridExtra")



# Examining the data and factor structure ---------------------------------

gapminder

str(gapminder$continent)
levels(gapminder$continent)
nlevels(gapminder$continent)
class(gapminder$continent)

table(gapminder$continent)

gapminder %>% 
  count(continent)

nlevels(gapminder$country)

# Subsetting the dataframe to only include data for five countries
h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")

# First without dropping unused factor levels
h_gap <- gapminder %>% 
  filter(country %in% h_countries)

nlevels(h_gap$country)
nlevels(h_gap$continent)

# Unused factor levels ignored by ggplot
h_gap %>% 
  ggplot(aes(year, lifeExp, col = country)) +
  geom_line()

# Now dropping unused factor levels
h_gap <- h_gap %>% 
  droplevels()
nlevels(h_gap_dropped$country)
nlevels(h_gap_dropped$continent)

h_gap$country %>% 
  fct_drop()




# Sort factor levels by their frequency of occurrence ---------------------
# A job for fct_infreq()

gapminder$continent %>% 
  levels()

gapminder %>%
  count(continent)

gapminder$continent %>% 
  fct_infreq() %>% 
  fct_rev() %>% 
  levels()

# Compare these plots
p1 <- gapminder %>% 
  ggplot(aes(x = continent)) +
  geom_bar() +
  coord_flip()

p2 <- gapminder %>% 
  ggplot(aes(x = fct_infreq(continent))) +
  geom_bar() +
  coord_flip()

p3 <- gapminder %>% 
  mutate(continent = fct_infreq(continent)) %>% 
  ggplot(aes(x = continent)) +
  geom_bar() +
  coord_flip()


grid.arrange(p1, p2, p3, nrow = 1)



# Sort factor levels by the value of a different variable -----------------
# A job for ftc_reorder()

# Let's subset the dataframe
gap_asia_2007 <- gapminder %>% 
  filter(year == 2007, continent == 'Asia')

# Compare these plots

p1 <- gap_asia_2007 %>% 
  ggplot(aes(x = lifeExp, y = country)) +
  geom_point()

p2 <- gap_asia_2007 %>% 
  ggplot(aes(x = lifeExp, y = fct_reorder(country, lifeExp))) +
  geom_point()

grid.arrange(p1, p2, nrow = 1)



# Sort factor level with specified order ----------------------------------
# A job for fct_relevel


h_gap$country %>% levels()
h_gap$country %>% fct_relevel("Thailand", "Haiti") %>% levels()




# Exercise 1 --------------------------------------------------------------
# Make a plot of gdpPercap for each Asian country in 2007
# Make sure the countries appear in order in increasing gdpPercap
# OPTIONAL: Move Thailand to be the first country displayed

gap_asia_2007 %>% 
  mutate(country = fct_reorder(country, gdpPercap)) %>% 
  ggplot(aes(gdpPercap, fct_relevel(country, "Thailand"))) +
  geom_point()


gapminder$country %>% 
  levels() %>% 
  head()

?fct_reorder
fct_reorder(gapminder$country, gapminder$lifeExp, .desc = TRUE) %>% 
  levels() %>% 
  head()


gap_asia_2007_ordered <- gap_asia_2007 %>% 
  mutate(country = fct_reorder(country, gdpPercap)) %>% 
  droplevels()

levels(gap_asia_2007_ordered$country)


h_gap

p1 <- ggplot(h_gap, aes(x = year, y = lifeExp, color = country)) +
  geom_line()

p2 <- ggplot(h_gap, aes(x = year, y = lifeExp, color = fct_reorder2(country, year, lifeExp))) +
  geom_line() +
  labs(color = "country")

grid.arrange(p1, p2, nrow = 1)



# Renaming factor levels --------------------------------------------------
# A job for ftc_recode()


i_gap <- gapminder %>% 
  filter(country %in% c("United States", "Sweden", "Australia")) %>% 
  droplevels()

i_gap$country %>% levels()

i_gap$country %>%
  fct_recode("USA" = "United States", "Oz" = "Australia") %>% levels()
?rename

