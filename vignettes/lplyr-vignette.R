## ---- echo = FALSE, message = FALSE, warning = FALSE---------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(dplyr)
library(lplyr)

## ------------------------------------------------------------------------
xs <- list(x1 = 1:3, 
           x2 = 2:5, 
           x3 = "alpha")

## ---- eval = FALSE-------------------------------------------------------
#  mutate(xs, x4 = 4) %>% str
#  rename(xs, x0 = x1) %>% str

## ------------------------------------------------------------------------
mutate_(xs, x4 = ~ 4) %>% str
rename_(xs, x0 = ~ x1) %>% str

## ------------------------------------------------------------------------
df <- mtcars[1:6,]
mutate_which(df, gear==4, carb = 100)
transmute_which(df, gear==4, carb = 100)

## ------------------------------------------------------------------------
mutate_which_(df, ~ gear==4, carb = ~ 100)
transmute_which_(df, ~ gear==4, carb = ~ 100)

## ------------------------------------------------------------------------
df[["mpg"]]
df %>% pull(mpg)

# more convenient than (mtcars %>% filter(mpg > 20))[[3L]]
df %>%
  filter(mpg > 20) %>%
  pull(3)

