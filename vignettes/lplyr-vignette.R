## ---- eval=FALSE, message=FALSE, warning=FALSE---------------------------
#  library(lplyr)
#  
#  xs <- list(x1 = 1:3,
#             x2 = 2:5,
#             x3 = list("alpha", c("beta", "gamma")))
#  
#  mutate(xs, x4 = 4)
#  rename(xs, x0 = x1)
#  select(xs, -x3)
#  transmute(xs, x5 = 5)

## ---- eval=FALSE, message=FALSE, warning=FALSE---------------------------
#  mutate_(xs, x4 = ~ 4)
#  rename_(xs, x0 = ~ x1)
#  select_(xs, ~ (-x3))
#  transmute_(xs, x5 = ~ 5)

## ---- eval=FALSE, message=FALSE, warning=FALSE---------------------------
#  df <- mtcars[1:10,]
#  mutate_which(df, gear==4, carb = 100)
#  transmute_which(df, gear==4, carb = 100)

## ---- eval=FALSE, message=FALSE, warning=FALSE---------------------------
#  mutate_which_(df, ~ gear==4, carb = ~ 100)
#  transmute_which_(df, ~ gear==4, carb = ~ 100)

## ---- eval=FALSE, message=FALSE, warning=FALSE---------------------------
#  mtcars[["mpg"]]
#  mtcars %>% pull(mpg)
#  
#  # more convenient than (mtcars %>% filter(mpg > 20))[[3L]]
#  mtcars %>%
#   filter(mpg > 20) %>%
#   pull(3)

## ---- eval=FALSE, message=FALSE, warning=FALSE---------------------------
#  options(parallelize = FALSE)
#  
#  mtcars %>%
#    chunck(ok = getOption("parallelize")) %>%
#    mutate(cyl2 = 2 * cyl) %>%
#    filter(vs == 1) %>%
#    summarise(n()) %>%
#    select(-cyl)

