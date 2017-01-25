#' @title
#' Column selection
#'
#' @description
#' The function \code{pull} selects a column in a data frame
#' and transforms it into a vector.
#' This is useful to use it in combination with \pkg{magrittr}'s pipe operator
#' and \pkg{dplyr}'s verbs.
#'
#' @param .data
#' A tbl.
#'
#' @param j
#' integer. The column to be extracted.
#'
#' @return
#' A vector of length \code{nrow(.data)}
#'
#' @author Adapted from Tommy O' Dell, 
#' see \url{http://stackoverflow.com/a/24730843/3902976} on StackOverflow. 
#'
#' @export
#'
#' @examples
#' library(dplyr)
#' mtcars[["mpg"]]
#' mtcars %>% pull(mpg)
#'
#' # more convenient than (mtcars %>% filter(mpg > 20))[[3L]]
#' mtcars %>%
#'   filter(mpg > 20) %>%
#'   pull(3)
#'
pull <-
function(.data,
         j)
{
  j <- if (is.name(substitute(j))) deparse(substitute(j)) else j
  pull_(.data, j)
}


#' @importFrom lazyeval is_formula
#' @importFrom lazyeval f_rhs
#' @export
#' @rdname pull
#' 
pull_ <-
function(.data, 
         j)
{
  UseMethod("pull_")
}


#' @export
#' @rdname pull
#' 
pull_.data.frame <-
function(.data, 
         j)
{
  j <- if (lazyeval::is_formula(j)) as.character(lazyeval::f_rhs(j)) else j
  .data[, j, drop = FALSE][[1L]]
}


#' @export
#' @rdname pull
#'
pull_.matrix <- 
function(.data, 
         j)
{
  pull_(as.data.frame(.data))
}


#' @export
#' @rdname pull
#' 
pull_.list <-
function(.data, 
         j)
{
  j <- if (lazyeval::is_formula(j)) as.character(lazyeval::f_rhs(j)) else j
  .data[[j]]
}
