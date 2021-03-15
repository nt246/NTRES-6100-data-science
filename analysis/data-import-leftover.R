## Part 1: Data import

So far, we've been working with datasets that are built into R or we have just provided code to run to import data into R. 

When working in the tidyverse, the most common import function we will use are the `read_xx()` functions from the tidyverse package `readr`.

* `read_csv()` reads comma delimited files, `read_csv2()` reads semicolon separated files (common in countries where `,` is used as the decimal place), `read_tsv()` reads tab delimited files, and `read_delim()` reads in files with any delimiter.

* `read_fwf()` reads fixed width files. You can specify fields either by their widths with `fwf_widths()` or their position with `fwf_positions()`. `read_table()` reads a common variation of fixed width files where columns are separated by white space.

We can also read directly from spreadsheet formats:

* `readxl::read_excel()` reads directly from Excel spreadsheets

* `googlesheets::gs_read()` from the package [googlesheets](https://cran.r-project.org/web/packages/googlesheets/vignettes/basic-usage.html#read-all-the-data-in-one-worksheet) reads in data directly from Google Sheets

<br>

For all of these, we can either read in data from a file path or directly from a URL.

So for example, for a dataset we will be working with later, I can either load my local copy or grab it from the github site where it is made available
```{r}

lotr <- read_csv("../datasets/lotr_tidy.csv")

lotr <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")

```

All the `readr::read_xx()` functions has many additional options including the ability to skip columns, skip rows, rename columns on import, trim whitespace, and much more. They all use the same syntax, so once you get familiar with one, you can easily apply your knowledge to all the other functions in `readr`.

You can examine the options by looking at the documentation, e.g `?read_csv()`. There is also a very useful overview in [Chapter 11 of Grolemund and Wickham's R for Data Science](https://r4ds.had.co.nz/data-import.html)
