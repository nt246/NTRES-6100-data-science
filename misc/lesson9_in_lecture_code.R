library(tidyverse)
library(nycflights13)  # install.packages("nycflights13")



# Binding rows together ---------------------------------------------------

fship <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")

ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")

rking <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")


lotr_untidy <- bind_rows(fship, ttow, rking)

base::rbind(fship, ttow, rking)

ttow_nofemales <- ttow %>% 
  select(Film, Race, Male)

bind_rows(fship, ttow_nofemales, rking)

ttow_shuffled <- ttow %>% 
  select(Females, Film, Race, Male)


t <- bind_cols(fship, ttow)
t <- cbind(fship, ttow)




# Introducing the flights data --------------------------------------------

airports %>% 
  count(faa) %>% 
  filter(n > 1)

planes %>% 
  count(tailnum) %>% 
  filter(n > 1)

flights
dim(flights)
View(flights)

flights %>% 
  count(tailnum) %>% 
  filter(n > 1)


# Subsetting the flights data ---------------------------------------------

dim(flights)

flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2



# Join functions ----------------------------------------------------------

airlines

flights2 %>% 
  left_join(airlines, by = "carrier")

?left_join

# Exercise: Add information about each plane to flights
planes


# Slides: Understanding joins (including duplicate keys)

# Defining the key columns

# Natural join
weather

flights2 %>% 
  left_join(weather)

# By character vector
flights2 %>% 
  left_join(planes, by = "tailnum")

# What happens if we don't specify tailnum?
flights2 %>% 
  left_join(planes)


flights2 %>% 
  left_join(planes, by = "tailnum", suffix = c("_flight", "_manufacture"))


# A named character vector: by = c("a" = "b")

flights2 %>% 
  left_join(airports, c("dest" = "faa"))


# Exercise: Add the location of the origin and destination (i.e. the lat and lon) to flights. You may want to use the suffix parameter to disambiguate variable names in your output

airports

airports_loc <- 
  airports %>% 
  select(faa, name, lat, lon)

airports_loc <- 
  airports %>% 
  select(-alt, -tz, -dst, -tzone)

  
flights2 %>% 
  left_join(airports_loc, c("dest" = "faa")) %>% 
  left_join(airports_loc, c("origin" = "faa"), suffix = c("_dest", "_origin"))


# Optional exercise: Is there a relationship between the age of a plane and its delays? [You will have to work with the full flights data to access delay data]
https://jrnold.github.io/r4ds-exercise-solutions/relational-data.html#exercise-13.4.3



# Filtering joins ---------------------------------------------------------------

Slides

top_dest <- 
  flights %>% 
  count(dest, sort = TRUE) %>% 
  head(10)

flights2 %>% 
  semi_join(top_dest)

# Alternative
flights %>% 
  filter(dest %in% top_dest$dest)


# Antijoin: diagnosing join mismatches. 
# Do all flights have a match in planes?

flights2 %>% 
  anti_join(planes, by = "tailnum") %>% 
  count(tailnum, sort = TRUE)




## OPTIONAL EXERCISE about delay by destination
https://jrnold.github.io/r4ds-exercise-solutions/relational-data.html#exercise-13.4.1







# Factors -----------------------------------------------------------------

# Familiarize yourself with the data

gss_cat

gss_cat %>% 
  count(race)

ggplot(gss_cat, aes(race)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE)

ggplot(gss_cat, aes(rincome)) +
  geom_bar() +
  coord_flip()

gss_cat %>% 
  count(partyid, sort = TRUE)


# Re-ordering levels

relig_summary <- gss_cat %>% 
  group_by(relig) %>% 
  summarize(
    tvhours = mean(tvhours, na.rm = TRUE)
  )

ggplot(relig_summary, aes(tvhours, relig)) +
  geom_point()

ggplot(relig_summary, aes(tvhours, fct_reorder(relig, tvhours))) +
  geom_point()


rincome_summary <- gss_cat %>% 
  group_by(rincome) %>% 
  summarize(age = mean(age, na.rm = TRUE))

ggplot(rincome_summary, aes(age, fct_reorder(rincome, age))) +
  geom_point()

ggplot(rincome_summary, aes(age, fct_relevel(rincome, "Not applicable"))) +
  geom_point()


by_age <- gss_cat %>% 
  filter(!is.na(age)) %>% 
  count(age, marital)

ggplot(by_age, aes(age, n, color = marital)) +
  geom_line()

ggplot(by_age, aes(age, n, color = fct_reorder2(marital, age, n))) +
  geom_line()


ggplot(gss_cat, aes(fct_infreq(marital))) +
  geom_bar()





# Re-naming levels

gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat"
  )) %>%
  count(partyid)


gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat",
                              "Other"                 = "No answer",
                              "Other"                 = "Don't know",
                              "Other"                 = "Other party"
  )) %>%
  count(partyid)


gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) %>%
  count(partyid)

























