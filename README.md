# lplyr: dplyr verbs for lists and other verbs for data frames

[![Travis-CI Build Status](https://travis-ci.org/paulponcet/lplyr.svg?branch=master)](https://travis-ci.org/paulponcet/lplyr)

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
select(xs, -x3)
transmute(xs, x5 = 5)
```
Usual verbs made for standard evaluation work as well: 

```R
mutate_(xs, x4 = ~ 4)
rename_(xs, x0 = ~ x1)
select_(xs, ~ (-x3))
transmute_(xs, x5 = ~ 5)
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

## Chunck 

The function `chunck` is identical to the `partition` function 
from package 'multidplyr', except that it adds a logical argument 
`ok`: if `ok=FALSE`, no partition is applied, 
the input dataset is returned unchanged.
This is convenient in programming to easily test the benefit of 
parallelizing or switch from non-parallel to parallel programming. 

```R
options(parallelize = FALSE)

mtcars %>% 
  chunck(ok = getOption("parallelize")) %>% 
  mutate(cyl2 = 2 * cyl) %>% 
  filter(vs == 1) %>% 
  summarise(n()) %>% 
  select(-cyl)
```

