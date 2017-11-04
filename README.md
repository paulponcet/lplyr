# lplyr: dplyr verbs for lists and other verbs for data frames

[![Travis-CI Build Status](https://travis-ci.org/paulponcet/lplyr.svg?branch=master)](https://travis-ci.org/paulponcet/lplyr) [![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/lplyr)](https://cran.r-project.org/package=lplyr) [![](https://cranlogs.r-pkg.org/badges/lplyr)](https://cran.r-project.org/package=lplyr)


## Installation

You can install 'lplyr' from GitHub with:

```R
# install.packages("devtools")
devtools::install_github("paulponcet/lplyr")
```

## Verbs for lists and pairlists 

The package 'lplyr' extends some dplyr verbs to lists and pairlists: 

```R
library(lplyr)

xs <- list(x1 = 1:3, 
           x2 = 2:5, 
           x3 = list("alpha", c("beta", "gamma")))
           
mutate(xs, x4 = 4)
rename(xs, x0 = x1)
```
Usual verbs made for standard evaluation work as well: 

```R
mutate_(xs, x4 = ~ 4)
rename_(xs, x0 = ~ x1)
```


## New verbs for data frames

The `mutate_which` and `transmute_which` functions are made for adding new variables or modifying existing ones on a subset of the data. 

```R
df <- mtcars[1:10,]
mutate_which(df, gear==4, carb = 100)
transmute_which(df, gear==4, carb = 100)
```

There is also a standard evaluation version of these functions, 
called `mutate_which_` and `transmute_which_`: 

```R
mutate_which_(df, ~ gear==4, carb = ~ 100)
transmute_which_(df, ~ gear==4, carb = ~ 100)
```

The function `pull` selects a column in a data frame 
and transforms it into a vector. 
This is useful to use it in combination with 
magrittr's pipe operator and dplyr's verbs.

```R
mtcars[["mpg"]]
mtcars %>% pull(mpg)

# more convenient than (mtcars %>% filter(mpg > 20))[[3L]]
mtcars %>%
 filter(mpg > 20) %>%
 pull(3)
```
