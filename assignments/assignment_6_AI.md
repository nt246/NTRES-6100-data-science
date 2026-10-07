# Assignment 6: Data import and tidy data


## Instructions: Please read through this before you begin

- This assignment is due by **10pm on Wednesday 10/14/2026**. Please
  submit it using your personal GitHub repository for this class.
- **Download this Quarto (`.qmd`) file**, place it in your personal
  GitHub repository for the class, and **work directly in this file**.
- Please name the file `assignment_6.qmd`. It is set up to render to
  GitHub Flavored Markdown (`assignment_6.md`).
- Write your code in the chunks provided and show **BOTH your code and
  its output**, unless instructed otherwise.
- Replace *“Write your response here”* with your response when a written
  answer is requested.
- Examine messages and warnings before using Quarto options to hide
  them.
- When finished, render `assignment_6.qmd` to produce `assignment_6.md`,
  and commit and push **both files**.
- You only need to complete **three of the five questions in Exercise
  1**. **Exercise 3 is optional.**

<br>

### Use of AI

As in the previous assignments, this assignment has two goals:

1.  Practice and reinforce the data import and tidying skills we have
    been developing in class.
2.  Practice using generative AI as a **coding partner without
    outsourcing your understanding**.

Questions marked **Code yourself** should be completed without
generative AI. Course notes, R help (`?function_name`), and package
documentation are fine.

Questions marked **Use AI intentionally** ask you to document part of
your AI interaction. The goal is not simply to get working code:
practice writing useful prompts, evaluating responses, testing code, and
deciding whether a suggestion is appropriate.

Questions that ask you to use AI **as a reviewer** or **as a tutor** are
designed so that you do some of the reasoning or coding first. Follow
the order given rather than asking AI to solve the entire task from the
start.

For every AI question, **you remain responsible for the final code you
submit** and should be able to explain every line.

------------------------------------------------------------------------

## Load packages

``` r
library(tidyverse)
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.2.1     ✔ readr     2.2.0
    ✔ forcats   1.0.1     ✔ stringr   1.6.0
    ✔ ggplot2   4.0.3     ✔ tibble    3.3.1
    ✔ lubridate 1.9.5     ✔ tidyr     1.3.2
    ✔ purrr     1.2.2     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library(knitr)
```

<br>

## Exercise 1. Tibble and data import

Import the data frames listed below into R and
[parse](https://r4ds.hadley.nz/data-import.html) the columns
appropriately when needed. Watch out for the formatting oddities of each
dataset. Print the results directly, **without** using `kable()`.

**You only need to finish any three out of the five questions in this
exercise in order to get credit.**

<br>

#### 1.1 Create a tibble manually — **Code yourself**

Create the following tibble manually, first using `tribble()` and then
using `tibble()`. Print both results. We did not have time to cover
these functions in class, so use the [R for Data Science tibble
documentation](https://r4ds.hadley.nz/data-import.html) or R/package
help as needed. Do not use generative AI for this question.

``` r
# Write your code here
```

`tribble()`:

    ## # A tibble: 2 × 3
    ##       a     b c     
    ##   <dbl> <dbl> <chr> 
    ## 1     1   2.1 apple 
    ## 2     2   3.2 orange

`tibble()`:

    ## # A tibble: 2 × 3
    ##       a     b c     
    ##   <int> <dbl> <chr> 
    ## 1     1   2.1 apple 
    ## 2     2   3.2 orange

<br>

#### 1.2 Import a simple text file — **Code yourself**

Import
`https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset2.txt`
into R. Change the column names to `Name`, `Weight`, and `Price`.

``` r
# Write your code here
```

    ## # A tibble: 3 × 3
    ##   Name   Weight Price
    ##   <chr>   <dbl> <dbl>
    ## 1 apple       1   2.9
    ## 2 orange      2   4.9
    ## 3 durian     10  19.9

<br>

#### 1.3 Diagnose a messy import — **Use AI intentionally**

Import
`https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset3.txt`
into R. Watch out for the first few lines, missing values, separators,
quotation marks, and delimiters.

Before asking AI, inspect the raw file yourself and write down **at
least two formatting features** that your import code will need to
handle.

*Write your response here.*

Now write an AI prompt that describes what you noticed and asks for help
choosing appropriate `readr` arguments. Ask for an explanation of the
arguments rather than only finished code.

> **Your AI prompt:**\
> *Write your prompt here.*

Examine the response before running anything. Which suggested arguments
address the formatting features you identified?

*Write your response here.*

Now write and run your final import code. You may use, modify, or reject
the AI suggestion.

``` r
# Write your final code here
```

Did the import produce the expected column types and missing values?
Briefly explain how you checked.

*Write your response here.*

    ## # A tibble: 3 × 3
    ##   Name   Weight Price
    ##   <chr>   <dbl> <dbl>
    ## 1 apple       1   2.9
    ## 2 orange      2  NA  
    ## 3 durian     NA  19.9

<br>

#### 1.4 Import data with comments, units, and decimal marks — **Code yourself**

Import
`https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset4.txt`
into R. Watch out for comments, units, and decimal marks (which are `,`
in this case).

``` r
# Write your code here
```

    ## Warning: One or more parsing issues, call `problems()` on your data frame for details,
    ## e.g.:
    ##   dat <- vroom(...)
    ##   problems(dat)

    ## # A tibble: 3 × 3
    ##   Name   Weight Price
    ##   <chr>   <dbl> <dbl>
    ## 1 apple       1   2.9
    ## 2 orange      2   4.9
    ## 3 durian     10  19.9

<br>

#### 1.5 Parse dates and times and write a file — **Code yourself**

Import
`https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset5.txt`
into R and parse the columns appropriately. You may use the [R for Data
Science data import chapter](https://r4ds.hadley.nz/data-import.html) or
package documentation. Write the imported and parsed data frame to a new
CSV file named `dataset5_new.csv` in your assignment folder.

``` r
# Write your code here
```

    ## # A tibble: 3 × 3
    ##   Name   `Expiration Date` Time  
    ##   <chr>  <date>            <time>
    ## 1 apple  2018-09-26        01:00 
    ## 2 orange 2018-10-02        13:00 
    ## 3 durian 2018-10-21        11:00

<br>

## Exercise 2. Weather station

This dataset contains the weather and air quality data collected by a
weather station in Taiwan. It was obtained from the Environmental
Protection Administration, Executive Yuan, R.O.C. (Taiwan).

#### 2.1 Variable descriptions — **Code yourself**

- The text file
  `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station_notes.txt`
  contains descriptions of different variables collected by the station.

- Import it into R and print it in a table as shown below with
  `kable()`.

``` r
# Write your code here
```

<br>

| Item | Unit | Description |
|:---|:---|:---|
| AMB_TEMP | Celsius | Ambient air temperature |
| CO | ppm | Carbon monoxide |
| NO | ppb | Nitric oxide |
| NO2 | ppb | Nitrogen dioxide |
| NOx | ppb | Nitrogen oxides |
| O3 | ppb | Ozone |
| PM10 | μg/m3 | Particulate matter with a diameter between 2.5 and 10 μm |
| PM2.5 | μg/m3 | Particulate matter with a diameter of 2.5 μm or less |
| RAINFALL | mm | Rainfall |
| RH | % | Relative humidity |
| SO2 | ppb | Sulfur dioxide |
| WD_HR | degress | Wind direction (The average of hour) |
| WIND_DIREC | degress | Wind direction (The average of last ten minutes per hour) |
| WIND_SPEED | m/sec | Wind speed (The average of last ten minutes per hour) |
| WS_HR | m/sec | Wind speed (The average of hour) |

`#` indicates invalid value by equipment inspection\
`*` indicates invalid value by program inspection\
`x` indicates invalid value by human inspection\
`NR` indicates no rainfall\
blank indicates no data

<br>

#### 2.2 Data tidying — **Code yourself first, then use AI as a reviewer**

- Import
  `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station.csv`
  into R. As you can see, this dataset is a classic example of untidy
  data: values of a variable (i.e. hour of the day) are stored as column
  names; variable names are stored in the `item` column.

- Clean this dataset up and restructure it into a tidy format.

- Parse the `date` variable into date format and parse `hour` into time.

- Turn all invalid values into `NA` and turn `NR` in rainfall into `0`.

- Parse all values into numbers.

- Show the first 6 rows and 10 columns of this cleaned dataset, as shown
  below, *without* using `kable()`.

*Hints: you don’t have to perform these tasks in the given order; also,
warning messages are not necessarily signs of trouble.*

Before writing code, explain in **2–3 sentences** what makes the
original dataset untidy and describe the main changes needed to make
each row represent one observation. **Do this without AI.**

*Write your response here.*

Now clean the data yourself. You may use course notes, R help, and
package documentation, but do not use generative AI until you have a
working attempt.

``` r
# Write your data-cleaning code here
```

After you have a working attempt, ask AI to **review your code rather
than replace it**. Ask whether your code accomplishes all of the
requirements above, and ask it to identify any potential problem while
explaining its reasoning.

> **Paste the prompt you used:**\
> *Write your prompt here.*

Did AI identify a real problem, suggest an unnecessary change, or
confirm your approach? If you changed your code after the review,
explain what you changed and why.

*Write your response here.*

<br>

Before cleaning:

    ## # A tibble: 6 × 10
    ##   date       station item     `00`  `01`  `02`  `03`  `04`  `05`  `06` 
    ##   <chr>      <chr>   <chr>    <chr> <chr> <chr> <chr> <chr> <chr> <chr>
    ## 1 2015/01/01 Cailiao AMB_TEMP 16    16    15    15    15    14    14   
    ## 2 2015/01/01 Cailiao CO       0.74  0.7   0.66  0.61  0.51  0.51  0.51 
    ## 3 2015/01/01 Cailiao NO       1     0.8   1.1   1.7   2     1.7   1.9  
    ## 4 2015/01/01 Cailiao NO2      15    13    13    12    11    13    13   
    ## 5 2015/01/01 Cailiao NOx      16    14    14    13    13    15    15   
    ## 6 2015/01/01 Cailiao O3       35    36    35    34    34    32    30

<br>

After cleaning:

    ## # A tibble: 6 × 10
    ##   date       station hour   AMB_TEMP    CO    NO   NO2   NOx    O3  PM10
    ##   <date>     <chr>   <time>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    ## 1 2015-01-01 Cailiao 00:00        16  0.74   1      15    16    35   171
    ## 2 2015-01-01 Cailiao 01:00        16  0.7    0.8    13    14    36   174
    ## 3 2015-01-01 Cailiao 02:00        15  0.66   1.1    13    14    35   160
    ## 4 2015-01-01 Cailiao 03:00        15  0.61   1.7    12    13    34   142
    ## 5 2015-01-01 Cailiao 04:00        15  0.51   2      11    13    34   123
    ## 6 2015-01-01 Cailiao 05:00        14  0.51   1.7    13    15    32   110

<br>

#### 2.3 Daily variation in ambient temperature — **Code yourself**

Using your cleaned dataset, plot the daily variation in ambient
temperature on September 25, 2015, as shown below.

``` r
# Write your code here
```

![](https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/assignments/assignment_6_files/figure-gfm/unnamed-chunk-11-1.png)

<br>

#### 2.4 Daily average ambient temperature — **Code yourself**

Plot the daily average ambient temperature throughout the year with a
**continuous line**, as shown below.

``` r
# Write your code here
```

![](https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/assignments/assignment_6_files/figure-gfm/unnamed-chunk-12-1.png)

<br>

#### 2.5 Monthly rainfall — **Code yourself**

Plot the total rainfall per month in a bar chart, as shown below.

``` r
# Write your code here
```

*Hint: separating date into three columns might be helpful.*

![](https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/assignments/assignment_6_files/figure-gfm/unnamed-chunk-13-1.png)

<br>

#### 2.6 Hourly PM2.5 through time — **Use AI intentionally**

Plot the hourly variation in PM2.5 during the first week of September
with a **continuous line**, as shown below.

First decide what variable you need on the x-axis. In particular, think
about whether `date` and `hour` can remain separate if you want one
continuous time series. **Do this before using AI.**

*Briefly describe your plan here.*

Now ask AI for help with **only the step of combining/parsing date and
hour into a date-time variable**. Ask it to explain the suggested
functions. Do not ask it to make the complete plot.

> **Your AI prompt:**\
> *Write your prompt here.*

Before running the suggestion, explain what you expect the new date-time
variable to contain.

*Write your response here.*

Now create the variable and make the plot yourself.

``` r
# Write your final code here
```

Did the resulting x-axis behave as you expected? How did you verify that
observations from successive days were ordered correctly?

*Write your response here.*

*Hint: uniting the date and hour and parsing the new variable might be
helpful.*

![](https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/assignments/assignment_6_files/figure-gfm/unnamed-chunk-14-1.png)

<br>

## Exercise 3. Camera data (OPTIONAL)

This dataset contains information on 1038 camera models. It was obtained
from the following website:
<https://perso.telecom-paristech.fr/eagan/class/igr204/>

<br>

#### 3.1 Split brand names and model names — **Code yourself**

- Import
  `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/camera.csv`
  to R.

- You will see that the `Model` columns contains both the brand names
  and model names of cameras. Split this column into two, one with brand
  name, and the other with model name, as shown below.

- Print the first 6 rows of the new data frame with `kable()`.

*Hint: `separate_wider_delim()` may be useful. Think carefully about
what should happen when a model name contains more than one space.*

``` r
# Write your code here
```

<br>

| Brand | Model | Release date | Max resolution | Low resolution | Effective pixels | Zoom wide (W) | Zoom tele (T) | Normal focus range | Macro focus range | Storage included | Weight (inc. batteries) | Dimensions | Price |
|:---|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Agfa | ePhoto 1280 | 1997 | 1024 | 640 | 0 | 38 | 114 | 70 | 40 | 4 | 420 | 95 | 179 |
| Agfa | ePhoto 1680 | 1998 | 1280 | 640 | 1 | 38 | 114 | 50 | 0 | 4 | 420 | 158 | 179 |
| Agfa | ePhoto CL18 | 2000 | 640 | 0 | 0 | 45 | 45 | 0 | 0 | 2 | 0 | 0 | 179 |
| Agfa | ePhoto CL30 | 1999 | 1152 | 640 | 0 | 35 | 35 | 0 | 0 | 4 | 0 | 0 | 269 |
| Agfa | ePhoto CL30 Clik! | 1999 | 1152 | 640 | 0 | 43 | 43 | 50 | 0 | 40 | 300 | 128 | 1299 |
| Agfa | ePhoto CL45 | 2001 | 1600 | 640 | 1 | 51 | 51 | 50 | 20 | 8 | 270 | 119 | 179 |

<br>

#### 3.2 Split product line names and model names — **Use AI as a tutor**

- Many model names start with a name for the product line, which is then
  followed by a name for the particular model.

- Select all Canon cameras, and further split the model names into
  product line names (in this case, they are either “Powershot” or
  “EOS”) and model names.

- Show the first 6 lines of this new data frame with `kable()`.

*Hint: notice that there is more than one possible separator.*

Try this yourself first. If you get stuck on how to handle multiple
possible separators, ask AI about that **specific string-separation
problem** rather than asking it to solve the whole exercise.

> **If you used AI, paste your prompt here:**\
> *Write your prompt here, or write “I did not use AI.”*

``` r
# Write your final code here
```

<br>

| Brand | Line | Model | Release date | Max resolution | Low resolution | Effective pixels | Zoom wide (W) | Zoom tele (T) | Normal focus range | Macro focus range | Storage included | Weight (inc. batteries) | Dimensions | Price |
|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Canon | PowerShot | 350 | 1997 | 640 | 0 | 0 | 42 | 42 | 70 | 3 | 2 | 320 | 93 | 149 |
| Canon | PowerShot | 600 | 1996 | 832 | 640 | 0 | 50 | 50 | 40 | 10 | 1 | 460 | 160 | 139 |
| Canon | PowerShot | A10 | 2001 | 1280 | 1024 | 1 | 35 | 105 | 76 | 16 | 8 | 375 | 110 | 139 |
| Canon | PowerShot | A100 | 2002 | 1280 | 1024 | 1 | 39 | 39 | 20 | 5 | 8 | 225 | 110 | 139 |
| Canon | PowerShot | A20 | 2001 | 1600 | 1024 | 1 | 35 | 105 | 76 | 16 | 8 | 375 | 110 | 139 |
| Canon | PowerShot | A200 | 2002 | 1600 | 1024 | 1 | 39 | 39 | 20 | 5 | 8 | 225 | 110 | 139 |

<br> <br>
