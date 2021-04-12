# Let's illustrate how we can apply a function to many input values at the same time
library(tidyverse)

## Let's write a function that converts lengths measured in feet to m
## 1 foot = 0.3048 m

feet_to_m <- function(length) {
  length_m <- 0.3048 * length
  return(length_m)
}

# Let's test our function
feet_to_m(3)
feet_to_m(10)


# What if we have 5 different lengths measured in feet?
measurements <- c(5, 6, 13, 7, 2)


# We could write a for loop that iterate through these elements of our length vector
length_m <- vector("double", length = length(measurements))
for (i in seq_along(measurements)) {
  length_m[i] <- feet_to_m(measurements[i])
}


# But we don't have to! When we apply a function to a vector, it gets applied to each element of the vector
feet_to_m(measurements)


# When the vector we want to apply our function to is within a dataframe, we can use the function within a mutate() function

df <- tibble(sample = c(1, 2, 3), length_feet = c(6, 8, 4))
df_metric <- df %>% 
  mutate(length_m = feet_to_m(length_feet))

