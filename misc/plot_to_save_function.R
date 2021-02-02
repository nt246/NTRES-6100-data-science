library(tidyverse)
library(gapminder)

gap_to_plot <- gapminder %>%
  filter(country == "Afghanistan")

## plot
my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  ## add title and save
  labs(title = paste("Afghanistan", "GDP per capita", sep = " "))
ggsave(filename = "docs/assets/Afghanistan_gdpPercap.png", plot = my_plot)



?get

dir.create("figures") 
dir.create("figures/function") 

## create a list of countries. Calculations go here, not in the for loop

print_plot <- function(cntry) {
  
  ## filter the country to plot
  gap_to_plot <- gapminder %>%
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpTot)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpTot.png", sep = ""), 
         plot = my_plot)
  
}}