## Exercise 1: Practicing `join` functions (20 mins)

#### This exercise is borrowed from the [STAT545 course at UBC](https://stat545guidebook.netlify.app/tibble-joins.html)

For this exercise, we will need two data files from Joey Bernhardt's R package `singer`. We have to first load the `tidyverse` library, then we can load these datasets from the STAT545 GitHub repo.


<!---The following chunk allows errors when knitting--->

```{r allow errors, echo = FALSE}
knitr::opts_chunk$set(error = TRUE)
```


The package `singer` comes with two smallish data frames about songs. Let's first import them and take a look at them (after minor modifications by renaming and shuffling):
  
  Import the data
```{r}

library(tidyverse)

songs <- read_csv("https://raw.githubusercontent.com/STAT545-UBC/Classroom/master/data/singer/songs.csv")
locations <- read_csv("https://raw.githubusercontent.com/STAT545-UBC/Classroom/master/data/singer/loc.csv")

```

```{r}
(time <- as_tibble(songs) %>% 
    rename(song = title))
```

```{r}
(album <- as_tibble(locations) %>% 
    select(title, everything()) %>% 
    rename(album = release,
           song  = title))
```


1. We really care about the songs in `time`. But, which of those songs do we know its corresponding album?
  
  ```{r}
time %>% 
  FILL_THIS_IN(album, by = FILL_THIS_IN)
```

2. Go ahead and add the corresponding albums to the `time` tibble, being sure to preserve rows even if album info is not readily available.

```{r}
time %>% 
  FILL_THIS_IN(album, by = FILL_THIS_IN)
```

3. Which songs do we have "year", but not album info?
  
  ```{r}
time %>% 
  FILL_THIS_IN(album, by = "song")
```

4. Which artists are in `time`, but not in `album`?
  
  ```{r}
time %>% 
  anti_join(album, by = "FILL_THIS_IN")
```

5. You've come across these two tibbles, and just wish all the info was available in one tibble. What would you do?

```{r}
FILL_THIS_IN %>% 
  FILL_THIS_IN(FILL_THIS_IN, by = "song")
```

<br>
<br>
