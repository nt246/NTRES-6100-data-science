## Relational data
We'll review how to [define the key columns](https://r4ds.had.co.nz/relational-data.html#join-by) for mutating joins and then we'll discuss [filtering joins](https://r4ds.had.co.nz/relational-data.html#filtering-joins) with the `semi_join()` and `anti_join()` functions.
                                                                                                                                                              
                                                                                                                                                              <br>
                                                                                                                                                                
                                                                                                                                                                #### Optional exercises (from the R for Data Science chapter)
                                                                                                                                                                Once you have given each exercise a try, you can check the solutions [here](https://jrnold.github.io/r4ds-exercise-solutions/relational-data.html)
                                                                                                                                                              
                                                                                                                                                              <br>
                                                                                                                                                                
                                                                                                                                                                1.  **R4DS exercise 13.4.1:** Compute the average delay by destination, then join on the `airports`
                                                                                                                                                              data frame so you can show the spatial distribution of delays. Here's an
    easy way to draw a map of the United States:

```{r, include = FALSE}
library(tidyverse)
library(nycflights13) #install.packages("nycflights13")
```

    ```{r, eval = FALSE}
    library(maps) #install.packages("maps")

    airports %>%
      semi_join(flights, c("faa" = "dest")) %>%
      ggplot(aes(lon, lat)) +
        borders("state") +
        geom_point() +
        coord_quickmap()
    ```

    (Don't worry if you don't understand what `semi_join()` does --- you'll
                                                                                                                                                              learn about it next.)

You might want to use the `size` or `colour` of the points to display
the average delay for each airport.

<br>
  
  2.  **R4DS exercise 13.4.2:** Add the location of the origin _and_ destination (i.e. the `lat` and `lon`)
to `flights`.

<br>
  
  3.  **R4DS exercise 13.4.3:** Is there a relationship between the age of a plane and its delays?
  