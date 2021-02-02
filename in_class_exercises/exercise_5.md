Exercise 5: Data transformation, part 1
================

Please work through these exercises in an RMarkdown file in your personal GitHub repository. This way, you will have a chance to practice your RMarkdown and GitHub skills, and will be able to share your work easily with the class.

To start, first load all the required package with the following code. Install them if they are not installed yet.

``` r
library(tidyverse)
library(knitr)
```

Exercise 1: Iris morphometrics
------------------------------

This exercise uses the famous (Fisher's or Anderson's) `iris` data set, which gives the measurements in centimeters of the variables sepal length and width and petal length and width, respectively, for 50 flowers from each of 3 species of iris.

``` r
kable(head(iris))
```

|  Sepal.Length|  Sepal.Width|  Petal.Length|  Petal.Width| Species |
|-------------:|------------:|-------------:|------------:|:--------|
|           5.1|          3.5|           1.4|          0.2| setosa  |
|           4.9|          3.0|           1.4|          0.2| setosa  |
|           4.7|          3.2|           1.3|          0.2| setosa  |
|           4.6|          3.1|           1.5|          0.2| setosa  |
|           5.0|          3.6|           1.4|          0.2| setosa  |
|           5.4|          3.9|           1.7|          0.4| setosa  |

<br>

#### 1.1 Select the last two columns of the `iris` dataset using their column names.

``` r
iris1<-select(iris, Petal.Width, Species)
kable(head(iris1))
```

|  Petal.Width| Species |
|------------:|:--------|
|          0.2| setosa  |
|          0.2| setosa  |
|          0.2| setosa  |
|          0.2| setosa  |
|          0.2| setosa  |
|          0.4| setosa  |

<br>

#### 1.2 Select all the columns of the `iris` dataset except for `Petal Width`. Do not manually list all the columns to include.

``` r
iris2<-select(iris, -Petal.Width)
kable(head(iris2))
```

|  Sepal.Length|  Sepal.Width|  Petal.Length| Species |
|-------------:|------------:|-------------:|:--------|
|           5.1|          3.5|           1.4| setosa  |
|           4.9|          3.0|           1.4| setosa  |
|           4.7|          3.2|           1.3| setosa  |
|           4.6|          3.1|           1.5| setosa  |
|           5.0|          3.6|           1.4| setosa  |
|           5.4|          3.9|           1.7| setosa  |

<br>

#### 1.3 Select all columns of the `iris` dataset that start with the character string “S”. Do not manually list all the columns to include.

``` r
iris3<-select(iris, starts_with("S"))
kable(head(iris3))
```

|  Sepal.Length|  Sepal.Width| Species |
|-------------:|------------:|:--------|
|           5.1|          3.5| setosa  |
|           4.9|          3.0| setosa  |
|           4.7|          3.2| setosa  |
|           4.6|          3.1| setosa  |
|           5.0|          3.6| setosa  |
|           5.4|          3.9| setosa  |

<br>

#### 1.4 Filter the rows of the `iris` dataset for `Species` to be `versicolor` or for `Sepal.Width` smaller than or equal to 2.9

``` r
iris4<-filter(iris, Species=="versicolor" | Sepal.Width <= 2.9 )
kable(head(iris4))
```

|  Sepal.Length|  Sepal.Width|  Petal.Length|  Petal.Width| Species    |
|-------------:|------------:|-------------:|------------:|:-----------|
|           4.4|          2.9|           1.4|          0.2| setosa     |
|           4.5|          2.3|           1.3|          0.3| setosa     |
|           7.0|          3.2|           4.7|          1.4| versicolor |
|           6.4|          3.2|           4.5|          1.5| versicolor |
|           6.9|          3.1|           4.9|          1.5| versicolor |
|           5.5|          2.3|           4.0|          1.3| versicolor |

<br>

#### 1.5 Sort the rows by `Sepal.Length` and secondarily by `Sepal.Width`, in both cases from the largest to the smallest value.

``` r
iris5<-arrange(iris, desc(Sepal.Length), desc(Sepal.Width))
kable(head(iris5))
```

|  Sepal.Length|  Sepal.Width|  Petal.Length|  Petal.Width| Species   |
|-------------:|------------:|-------------:|------------:|:----------|
|           7.9|          3.8|           6.4|          2.0| virginica |
|           7.7|          3.8|           6.7|          2.2| virginica |
|           7.7|          3.0|           6.1|          2.3| virginica |
|           7.7|          2.8|           6.7|          2.0| virginica |
|           7.7|          2.6|           6.9|          2.3| virginica |
|           7.6|          3.0|           6.6|          2.1| virginica |

<br>

#### 1.6 Add a new column called `Proportion` to the iris dataset, which is the ratio of `Petal.Width` to `Petal.Length`.

``` r
iris6<-mutate(iris, Proportion=Petal.Width/Petal.Length)
kable(head(iris6))
```

|  Sepal.Length|  Sepal.Width|  Petal.Length|  Petal.Width| Species |  Proportion|
|-------------:|------------:|-------------:|------------:|:--------|-----------:|
|           5.1|          3.5|           1.4|          0.2| setosa  |   0.1428571|
|           4.9|          3.0|           1.4|          0.2| setosa  |   0.1428571|
|           4.7|          3.2|           1.3|          0.2| setosa  |   0.1538462|
|           4.6|          3.1|           1.5|          0.2| setosa  |   0.1333333|
|           5.0|          3.6|           1.4|          0.2| setosa  |   0.1428571|
|           5.4|          3.9|           1.7|          0.4| setosa  |   0.2352941|

<br>

#### 1.7 Find the average `Petal.Length` of the species `virginica`.

``` r
iris_virginica <- filter(iris, Species=="virginica")
mean(iris_virginica$Petal.Length)
```

    ## [1] 5.552
