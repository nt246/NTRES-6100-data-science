In class exercise: iteration with for loop
================

``` r
library(tidyverse)
library(gapminder)
```

#### 1. Write a script that loops through the gapminder data by continent and prints out whether the mean life expectancy is smaller or larger than 50 years.

Solution 1.

``` r
continent_gapminder <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_lifeExp = mean(lifeExp))
continent_list <- unique(gapminder$continent)
for (cont in continent_list) {
  each_continent <- filter(continent_gapminder, continent == cont)$mean_lifeExp
  if (each_continent > 50) {
  print(paste("Average life expectancy in", cont, "is greater than 50", sep = " "))
  }
  else {
    print(paste("Average life expectancy in", cont, "is less than 50", sep = " "))
  }
}
```

    ## [1] "Average life expectancy in Asia is greater than 50"
    ## [1] "Average life expectancy in Europe is greater than 50"
    ## [1] "Average life expectancy in Africa is less than 50"
    ## [1] "Average life expectancy in Americas is greater than 50"
    ## [1] "Average life expectancy in Oceania is greater than 50"

Solution 2.

``` r
continents <- unique(gapminder$continent)
for (cont in continents) {
  temp <- gapminder %>% 
    filter(continent == cont) %>% 
    summarize(mean_lifeExp = mean(lifeExp))
  if (temp$mean_lifeExp < 50) {
    print(paste("Average Life Expectancy in", cont, "is < 50"))
  } else {
    print(paste("Average Life Expectancy in", cont, "is > 50"))
  }
}
```

    ## [1] "Average Life Expectancy in Asia is > 50"
    ## [1] "Average Life Expectancy in Europe is > 50"
    ## [1] "Average Life Expectancy in Africa is < 50"
    ## [1] "Average Life Expectancy in Americas is > 50"
    ## [1] "Average Life Expectancy in Oceania is > 50"

Solution 3.

``` r
for (c in unique(gapminder$continent)){
  mean_life_exp <- filter(gapminder, continent == c) %>%
    .$lifeExp %>%
    mean()
  if (mean_life_exp < 50){
    cat("Average life expectancy in", c, "is less than 50. \n")
  } else {
    cat("Average life expectancy in", c, "is greater than 50. \n")
  }
}
```

    ## Average life expectancy in Asia is greater than 50. 
    ## Average life expectancy in Europe is greater than 50. 
    ## Average life expectancy in Africa is less than 50. 
    ## Average life expectancy in Americas is greater than 50. 
    ## Average life expectancy in Oceania is greater than 50.

#### 2. Modify the script from above to loop over each country. This time print out whether the life expectancy is smaller than 50, between 50 and 70, or greater than 70.

Solution 1.

``` r
country_list <- unique(gapminder$country)

for (cont in country_list) {  
  temp <- gapminder %>% 
    filter(country == cont) %>% 
    summarize(mean_lifeExp = mean(lifeExp))
  
  if (temp$mean_lifeExp < 50) {
    print(paste("Average Life Expectancy in", cont, "is <50"))
  } else if (temp$mean_lifeExp >= 50 & temp$mean_lifeExp < 70) {
    print(paste("Average Life Expectancy in", cont, "is between 50 and 70")) 
  } else {
    print(paste("Average Life Expectancy in", cont, "is >70")) 
  }
}
```

    ## [1] "Average Life Expectancy in Afghanistan is <50"
    ## [1] "Average Life Expectancy in Albania is between 50 and 70"
    ## [1] "Average Life Expectancy in Algeria is between 50 and 70"
    ## [1] "Average Life Expectancy in Angola is <50"
    ## [1] "Average Life Expectancy in Argentina is between 50 and 70"
    ## [1] "Average Life Expectancy in Australia is >70"
    ## [1] "Average Life Expectancy in Austria is >70"
    ## [1] "Average Life Expectancy in Bahrain is between 50 and 70"
    ## [1] "Average Life Expectancy in Bangladesh is <50"
    ## [1] "Average Life Expectancy in Belgium is >70"
    ## [1] "Average Life Expectancy in Benin is <50"
    ## [1] "Average Life Expectancy in Bolivia is between 50 and 70"
    ## [1] "Average Life Expectancy in Bosnia and Herzegovina is between 50 and 70"
    ## [1] "Average Life Expectancy in Botswana is between 50 and 70"
    ## [1] "Average Life Expectancy in Brazil is between 50 and 70"
    ## [1] "Average Life Expectancy in Bulgaria is between 50 and 70"
    ## [1] "Average Life Expectancy in Burkina Faso is <50"
    ## [1] "Average Life Expectancy in Burundi is <50"
    ## [1] "Average Life Expectancy in Cambodia is <50"
    ## [1] "Average Life Expectancy in Cameroon is <50"
    ## [1] "Average Life Expectancy in Canada is >70"
    ## [1] "Average Life Expectancy in Central African Republic is <50"
    ## [1] "Average Life Expectancy in Chad is <50"
    ## [1] "Average Life Expectancy in Chile is between 50 and 70"
    ## [1] "Average Life Expectancy in China is between 50 and 70"
    ## [1] "Average Life Expectancy in Colombia is between 50 and 70"
    ## [1] "Average Life Expectancy in Comoros is between 50 and 70"
    ## [1] "Average Life Expectancy in Congo, Dem. Rep. is <50"
    ## [1] "Average Life Expectancy in Congo, Rep. is between 50 and 70"
    ## [1] "Average Life Expectancy in Costa Rica is >70"
    ## [1] "Average Life Expectancy in Cote d'Ivoire is <50"
    ## [1] "Average Life Expectancy in Croatia is >70"
    ## [1] "Average Life Expectancy in Cuba is >70"
    ## [1] "Average Life Expectancy in Czech Republic is >70"
    ## [1] "Average Life Expectancy in Denmark is >70"
    ## [1] "Average Life Expectancy in Djibouti is <50"
    ## [1] "Average Life Expectancy in Dominican Republic is between 50 and 70"
    ## [1] "Average Life Expectancy in Ecuador is between 50 and 70"
    ## [1] "Average Life Expectancy in Egypt is between 50 and 70"
    ## [1] "Average Life Expectancy in El Salvador is between 50 and 70"
    ## [1] "Average Life Expectancy in Equatorial Guinea is <50"
    ## [1] "Average Life Expectancy in Eritrea is <50"
    ## [1] "Average Life Expectancy in Ethiopia is <50"
    ## [1] "Average Life Expectancy in Finland is >70"
    ## [1] "Average Life Expectancy in France is >70"
    ## [1] "Average Life Expectancy in Gabon is between 50 and 70"
    ## [1] "Average Life Expectancy in Gambia is <50"
    ## [1] "Average Life Expectancy in Germany is >70"
    ## [1] "Average Life Expectancy in Ghana is between 50 and 70"
    ## [1] "Average Life Expectancy in Greece is >70"
    ## [1] "Average Life Expectancy in Guatemala is between 50 and 70"
    ## [1] "Average Life Expectancy in Guinea is <50"
    ## [1] "Average Life Expectancy in Guinea-Bissau is <50"
    ## [1] "Average Life Expectancy in Haiti is between 50 and 70"
    ## [1] "Average Life Expectancy in Honduras is between 50 and 70"
    ## [1] "Average Life Expectancy in Hong Kong, China is >70"
    ## [1] "Average Life Expectancy in Hungary is between 50 and 70"
    ## [1] "Average Life Expectancy in Iceland is >70"
    ## [1] "Average Life Expectancy in India is between 50 and 70"
    ## [1] "Average Life Expectancy in Indonesia is between 50 and 70"
    ## [1] "Average Life Expectancy in Iran is between 50 and 70"
    ## [1] "Average Life Expectancy in Iraq is between 50 and 70"
    ## [1] "Average Life Expectancy in Ireland is >70"
    ## [1] "Average Life Expectancy in Israel is >70"
    ## [1] "Average Life Expectancy in Italy is >70"
    ## [1] "Average Life Expectancy in Jamaica is between 50 and 70"
    ## [1] "Average Life Expectancy in Japan is >70"
    ## [1] "Average Life Expectancy in Jordan is between 50 and 70"
    ## [1] "Average Life Expectancy in Kenya is between 50 and 70"
    ## [1] "Average Life Expectancy in Korea, Dem. Rep. is between 50 and 70"
    ## [1] "Average Life Expectancy in Korea, Rep. is between 50 and 70"
    ## [1] "Average Life Expectancy in Kuwait is between 50 and 70"
    ## [1] "Average Life Expectancy in Lebanon is between 50 and 70"
    ## [1] "Average Life Expectancy in Lesotho is between 50 and 70"
    ## [1] "Average Life Expectancy in Liberia is <50"
    ## [1] "Average Life Expectancy in Libya is between 50 and 70"
    ## [1] "Average Life Expectancy in Madagascar is <50"
    ## [1] "Average Life Expectancy in Malawi is <50"
    ## [1] "Average Life Expectancy in Malaysia is between 50 and 70"
    ## [1] "Average Life Expectancy in Mali is <50"
    ## [1] "Average Life Expectancy in Mauritania is between 50 and 70"
    ## [1] "Average Life Expectancy in Mauritius is between 50 and 70"
    ## [1] "Average Life Expectancy in Mexico is between 50 and 70"
    ## [1] "Average Life Expectancy in Mongolia is between 50 and 70"
    ## [1] "Average Life Expectancy in Montenegro is >70"
    ## [1] "Average Life Expectancy in Morocco is between 50 and 70"
    ## [1] "Average Life Expectancy in Mozambique is <50"
    ## [1] "Average Life Expectancy in Myanmar is between 50 and 70"
    ## [1] "Average Life Expectancy in Namibia is between 50 and 70"
    ## [1] "Average Life Expectancy in Nepal is <50"
    ## [1] "Average Life Expectancy in Netherlands is >70"
    ## [1] "Average Life Expectancy in New Zealand is >70"
    ## [1] "Average Life Expectancy in Nicaragua is between 50 and 70"
    ## [1] "Average Life Expectancy in Niger is <50"
    ## [1] "Average Life Expectancy in Nigeria is <50"
    ## [1] "Average Life Expectancy in Norway is >70"
    ## [1] "Average Life Expectancy in Oman is between 50 and 70"
    ## [1] "Average Life Expectancy in Pakistan is between 50 and 70"
    ## [1] "Average Life Expectancy in Panama is between 50 and 70"
    ## [1] "Average Life Expectancy in Paraguay is between 50 and 70"
    ## [1] "Average Life Expectancy in Peru is between 50 and 70"
    ## [1] "Average Life Expectancy in Philippines is between 50 and 70"
    ## [1] "Average Life Expectancy in Poland is >70"
    ## [1] "Average Life Expectancy in Portugal is >70"
    ## [1] "Average Life Expectancy in Puerto Rico is >70"
    ## [1] "Average Life Expectancy in Reunion is between 50 and 70"
    ## [1] "Average Life Expectancy in Romania is between 50 and 70"
    ## [1] "Average Life Expectancy in Rwanda is <50"
    ## [1] "Average Life Expectancy in Sao Tome and Principe is between 50 and 70"
    ## [1] "Average Life Expectancy in Saudi Arabia is between 50 and 70"
    ## [1] "Average Life Expectancy in Senegal is between 50 and 70"
    ## [1] "Average Life Expectancy in Serbia is between 50 and 70"
    ## [1] "Average Life Expectancy in Sierra Leone is <50"
    ## [1] "Average Life Expectancy in Singapore is >70"
    ## [1] "Average Life Expectancy in Slovak Republic is >70"
    ## [1] "Average Life Expectancy in Slovenia is >70"
    ## [1] "Average Life Expectancy in Somalia is <50"
    ## [1] "Average Life Expectancy in South Africa is between 50 and 70"
    ## [1] "Average Life Expectancy in Spain is >70"
    ## [1] "Average Life Expectancy in Sri Lanka is between 50 and 70"
    ## [1] "Average Life Expectancy in Sudan is <50"
    ## [1] "Average Life Expectancy in Swaziland is <50"
    ## [1] "Average Life Expectancy in Sweden is >70"
    ## [1] "Average Life Expectancy in Switzerland is >70"
    ## [1] "Average Life Expectancy in Syria is between 50 and 70"
    ## [1] "Average Life Expectancy in Taiwan is >70"
    ## [1] "Average Life Expectancy in Tanzania is <50"
    ## [1] "Average Life Expectancy in Thailand is between 50 and 70"
    ## [1] "Average Life Expectancy in Togo is between 50 and 70"
    ## [1] "Average Life Expectancy in Trinidad and Tobago is between 50 and 70"
    ## [1] "Average Life Expectancy in Tunisia is between 50 and 70"
    ## [1] "Average Life Expectancy in Turkey is between 50 and 70"
    ## [1] "Average Life Expectancy in Uganda is <50"
    ## [1] "Average Life Expectancy in United Kingdom is >70"
    ## [1] "Average Life Expectancy in United States is >70"
    ## [1] "Average Life Expectancy in Uruguay is >70"
    ## [1] "Average Life Expectancy in Venezuela is between 50 and 70"
    ## [1] "Average Life Expectancy in Vietnam is between 50 and 70"
    ## [1] "Average Life Expectancy in West Bank and Gaza is between 50 and 70"
    ## [1] "Average Life Expectancy in Yemen, Rep. is <50"
    ## [1] "Average Life Expectancy in Zambia is <50"
    ## [1] "Average Life Expectancy in Zimbabwe is between 50 and 70"

Solution 2.

``` r
for (c in unique(gapminder$country)){
  mean_life_exp <- filter(gapminder, country == c) %>%
    .$lifeExp %>%
    mean()
  if (mean_life_exp < 50){
    cat("Average life expectancy in", c, "is less than 50. \n")
  } else if (mean_life_exp >= 50 & mean_life_exp < 70) {
    cat("Average life expectancy in", c, "is between 50 and 70. \n")
    } else {
    cat("Average life expectancy in", c, "is more than 70. \n")
  }
}
```

#### 3. Use an if() statement to print a suitable message reporting whether there are any records from 2002 in the gapminder dataset. Now do the same for 2012.

Solution 1.

``` r
yr <- 2002
if (nrow(filter(gapminder, year == yr)) > 0) {
  print(paste("The gapminder does have records from", yr))
} else {
  print(paste("The gapminder does not have records from", yr))
}
```

    ## [1] "The gapminder does have records from 2002"

``` r
yr <- 2012
if (nrow(filter(gapminder, year == yr)) > 0) {
  print(paste("The gapminder does have records from", yr))
} else {
  print(paste("The gapminder does not have records from", yr))
}
```

    ## [1] "The gapminder does not have records from 2012"

Solution 2.

``` r
for (year in c(2002, 2012)) {
  if (year %in% gapminder$year){
    cat("Record(s) for the year ", year, " found.\n")
  } else {
    cat("Record(s) for the year ", year, " not found.\n")
}
}
```

    ## Record(s) for the year  2002  found.
    ## Record(s) for the year  2012  not found.
