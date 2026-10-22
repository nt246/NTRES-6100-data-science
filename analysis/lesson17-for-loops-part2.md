---
title: "Lesson 17: Iteration with `for` loops and conditional execution with `if` statements - Part 2"
output: 
  html_document:
    keep_md: yes 
    toc: true
---
  


<br>

## Readings

#### Required:

If you didn't have a chance to read it yet, have a look at [Chapter 21 on for loops in R for Data Science, first edition](https://r4ds.had.co.nz/iteration.html)

OPTIONAL (for a more detailed overview of other types of iteration than those we will cover in class): [Chapter 26 on iteration in R for Data Science (2e)](https://r4ds.hadley.nz/iteration)



<br>
<br>


## Today's learning objectives

By the end of today's class, you should be able to:

* Write a `for` loop to repeat operations on different input
* Implement `if` and `if else` statements for conditional execution of code

<br>
<br>


We'll first finish where we left off last time and work through the rest of that lesson. Then we'll look at some other ways to write for loops by working through [these Data Carpentry's notes](https://datacarpentry.org/semester-biology/materials/for-loops-R/).

We can also apply this to the `gapminder` data. 

<br>
<br>

## Looping with an index and storing results
In the `gapminder` example we've been using to build a for loop together, we've been iterating over a list of countries (in turn assigning each of these to our `cntry` object). You may often see for loops iterating over a numerical index, often using `i` as the object that in turn gets assigned each number from a sequence. Here is an example:


``` r
for (i in 1:10) {
  print(str_c("Part_", i, sep = ""))
}
```
<br>

As another example, last class, we needed to calculate the product of gdp-per-cap and population size for each year and each country. We did this efficiently in a single step for all years and countries with a `mutate()`, prior to defining our loop or function. 


``` r
gap_europe <- gapminder_est |>  # Here we use the gapminder_est that includes information on whether data were estimated
  filter(continent == "Europe") |>
  mutate(gdp_tot = gdp_per_cap * pop)
```

<br>

A (not very computationally efficient) alternative would be to do this calculation for a specific country with a `for` loop and using square bracket indexing to select the i'th element of a vector.


``` r
gapminder$gdp_tot <-  vector(length = nrow(gapminder))

for (i in 1:nrow(gapminder)) {
  gapminder$gdp_tot[i] <- gapminder$gdp_per_cap[i] * gapminder$pop[i]
} 
```

<br>

To understand how this loop is working exactly the same way as our previous loop, have a look of the list of elements `1:nrow(gapminder)` that we loop over.


``` r
1:nrow(gapminder)
```

You see that this just gives a vector of integers from 1 to the number of rows in the gapminder data. Each of these numbers in turn get assigned to i as we run through the loop.

<br>
<br>

## For loops versus vectorized operations

We've now seen how we can use a `for` loop to repeat a calculation for different values. But in R, we often don't actually need a loop to do this! Many operations in R are **vectorized**, meaning that we can apply an operation to an entire vector at once, rather than explicitly going through its elements one by one.

Let's look at an example similar to the one in the [Data Carpentry lesson](https://datacarpentry.github.io/semester-biology/materials/for-loops-R/). Suppose we're estimating the masses of three organisms from their volumes, using a relationship of the form $mass = a \times volume^b$. The values of `a` and `b` differ among the organisms.


``` r
volumes <- c(1.6, 3, 8)
as <- c(2.65, 1.28, 3.29)
bs <- c(0.9, 1.1, 1.2)
```

<br>

We can use a `for` loop to calculate the mass for each organism. Since we need to access the corresponding values in all three vectors, we'll loop over an index, `i`, and store each result in a vector called `masses`.


``` r
masses <- numeric(length(volumes))

for (i in seq_along(volumes)) {
  masses[i] <- as[i] * volumes[i]^bs[i]
}

masses
```

<br>

Take a moment to make sure you understand what happens in each iteration. When `i` is 1, R uses the first value from each vector; when `i` is 2, it uses the second values, and so on.

But we can accomplish exactly the same thing without a loop:


``` r
masses <- as * volumes^bs
masses
```

R performs the calculation **element by element**, matching the first value of each vector, then the second, and so on. This is called **vectorization**. It's one of the reasons we can often write very concise code in R.

<br>

**Which approach would you prefer if you had measurements from thousands of organisms?**

In general, when a calculation can be expressed using vectorized operations, that will be simpler and often faster than writing a loop. We've already used vectorization many times, for example when we created new columns with `mutate()`.

So why do we still need loops? Not everything we want to repeat is a calculation on elements of a vector. Sometimes we need to perform a series of operations separately for different inputs, such as generating plots for individual countries or reading data from multiple files. Let's look at the latter example next.

<br>
<br>

## Looping over files

Imagine we've collected tracking data from several animals, and each animal's observations are stored in a separate CSV file. Rather than reading each file individually, we can use a `for` loop to process them all.

We'll use simulated satellite collar data from the [Data Carpentry tutorial](https://datacarpentry.github.io/semester-biology/materials/for-loops-R/).

<br>
<br>

### Download the data

Run the following code to download and unzip the files into your current RStudio Project. We only need to do this once.


``` r
# First, make a subdirectory for datasets if you don't have one already - to keep things organized
dir.create("datasets", showWarnings = FALSE)

download.file(
  "https://www.datacarpentry.org/semester-biology/data/locations.zip",
  "datasets/locations.zip",
  mode = "wb"  # Download as a binary file (needed for ZIP files)
)
unzip("datasets/locations.zip", exdir = "datasets")
```

<br>

Have a look in the Files pane in RStudio. You should now see several files whose names begin with `locations-`.

We can use `list.files()` to get the names of files in our working directory:


``` r
list.files("datasets")
```

However, we only want the files containing the tracking data. The `pattern` argument lets us select files based on their names, in this case only get the files that start with "locations-":


``` r
data_files <- list.files(
  path = "datasets",
  pattern = "locations-",
  full.names = TRUE
)

data_files
```

<br>

The result is a character vector of filenames. The pattern selects names beginning with `locations-`. We need to specify the path because our files are located within a subdirectory.

<br>
<br>

### Count the observations in each file

First, let's write a loop that reads each file and counts how many rows it contains. We'll use `seq_along()` to loop over the positions in `data_files`, and create a vector to store the counts.


``` r
row_counts <- vector("numeric", length(data_files))

for (i in seq_along(data_files)) {
  filename <- data_files[i]
  data <- read_csv(filename)
  row_counts[i] <- nrow(data)
}

row_counts
```

<br>

Notice that `filename` changes during each iteration. We use it to tell `read_csv()` which file to read. The `nrow()` function counts the number of rows in that file, and we store the result in the corresponding position in `row_counts`.

It would be helpful to know which count belongs to which file. We can combine the filenames and counts into a tibble:


``` r
file_summary <- tibble(
  filename = data_files,
  n_observations = row_counts
)

file_summary
```

<br>

**Your turn:** Modify the loop so that it also prints a message reporting the filename and number of observations each time a file is read. You can use `str_c()` to construct the message.

<br>
<br>

### Combine all the files into one data frame

Sometimes we don't just want to calculate a summary for each file. We want to **combine the observations from all the files into one data frame**, so we can analyze them together.

We've previously used `bind_rows()` to combine data frames by stacking their rows. We can do the same thing inside a loop, adding the observations from each new file to those we've already read.

There is one small complication: during the first iteration, we don't yet have a combined data frame to add rows to. We can use an `if`/`else` statement to handle this.


``` r
for (i in seq_along(data_files)) {
  filename <- data_files[i]
  data <- read_csv(filename)

  if (i == 1) {
    combined <- data
  } else {
    combined <- bind_rows(combined, data)
  }
}
```

<br>

Let's walk through what happens:

- When `i == 1`, we read the first file and assign its contents to `combined`.
- For every subsequent file, we use `bind_rows()` to append the new observations to `combined`.
- After the loop finishes, `combined` contains the observations from all the files.

Have a look at the result:


``` r
glimpse(combined)
nrow(combined)
```

<br>
<br>

**Question:** How can we check that the loop combined all the observations correctly? Compare the number of rows in `combined` with the sum of the counts we calculated earlier.


``` r
sum(row_counts)
nrow(combined)
```

The two numbers should be the same, assuming each file was read successfully and no rows were removed.

One thing to keep in mind is that `bind_rows()` matches columns by their names. If a column is missing from one of the files, the corresponding values will be filled with `NA`. If columns have incompatible data types, combining the files may produce an error.

<br>
<br>

### Extra challenge: Keep track of the source file

Once we've combined the files, can we still tell which observations came from which original file?

Modify the loop to add a new column called `source_file` to each data frame **before** combining them. The column should contain the filename from which the observations were read.

**Hint:** Use `mutate()` inside the loop, after reading each file but before the `if` statement.

<details>
<summary>Click to see a possible solution</summary>


``` r
for (i in seq_along(data_files)) {
  filename <- data_files[i]
  data <- read_csv(filename, show_col_types = FALSE) |>
    mutate(source_file = filename)

  if (i == 1) {
    combined <- data
  } else {
    combined <- bind_rows(combined, data)
  }
}

combined |>
  count(source_file)
```

</details>

<br>
<br>

### When should we use a loop?

The examples today illustrate two different situations:

- **Vectorized operations** are usually the simplest choice when we want to perform the same calculation on corresponding elements of vectors or columns of a data frame.
- **For loops** are useful when we want to repeat a sequence of operations for different inputs, especially when each iteration involves several steps or conditional execution.

There are also other ways to iterate in R, including the `map()` functions in the `purrr` package. We won't cover those in detail today, but you can read about them in [R for Data Science, Chapter 26](https://r4ds.hadley.nz/iteration.html).


<br>
<br>


## Exercises (if time allows)

Exercises from [R for Data Science](https://r4ds.had.co.nz/iteration.html#exercises-58)

Work with the specified datasets that are built into R or in the listed packages. You can access them just by typing the name (for `flights` you will have to first load the `nycflights13` package).

Write `for` loops to:

* Compute the mean of every column in `mtcars`
* Determine the type of each column in the `gapminder` dataset
* Compute the number of unique values in each column of `iris`


<br>
<br>

**Answers**

<details>
  <summary>click to see our approach</summary>

[from here](https://jrnold.github.io/r4ds-exercise-solutions/iteration.html#for-loops)

Compute the mean of every column in `mtcars`

``` r
output <- vector("double", ncol(mtcars))
names(output) <- names(mtcars)
for (i in names(mtcars)) {
  output[i] <- mean(mtcars[[i]])

output
}
```

<br>

Determine the type of each column in the `gapminder` dataset

``` r
library(gapminder)
library(tidyverse)

output <- vector("character", ncol(gapminder))
names(output) <- names(gapminder)
for (i in names(gapminder)) {
  output[i] <- class(gapminder[[i]])
}

output
```

<br>

Compute the number of unique values in each column of `iris`

``` r
iris_uniq <- vector("double", ncol(iris))
names(iris_uniq) <- names(iris)
for (i in names(iris)) {
  iris_uniq[i] <- n_distinct(iris[[i]])
}
iris_uniq
```

</details>

<br>
<br>


### Functional programming and map functions
For loops are a great place to start implementing iteration in our code because they make iteration very explicit, so it’s obvious what’s happening. However, for loops are quite verbose, and require quite a bit of bookkeeping code that is duplicated for every for loop. Functional programming (FP) offers tools to extract out this duplicated code, so each common for loop pattern gets its own function. If you are going to implement a lot of iteration in your code (which many of us will), I strongly recommend that you learn about the map functions in the purr package. [R4DS (2e)](https://r4ds.hadley.nz/iteration) provides a great introduction.


