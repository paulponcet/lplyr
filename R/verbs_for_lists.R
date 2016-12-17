#' @title 
#' Dplyr verbs for lists
#' 
#' @description 
#' We add methods for the verbs \code{\link[dplyr]{mutate}}, 
#' \code{\link[dplyr]{rename}}, \code{\link[dplyr]{select}}, 
#' and \code{\link[dplyr]{transmute}}. 
#' 
#' @param .data
#' A list. 
#' 
#' @param ...
#' Comma separated list of unquoted expressions. 
#' 
#' @param .dots
#' Used to work around non-standard evaluation. 
#' 
#' @return 
#' A list. 
#' 
#' @seealso \code{\link[dplyr]{mutate}},  
#' \code{\link[dplyr]{rename}}, 
#' \code{\link[dplyr]{select}},  
#' \code{\link[dplyr]{transmute}} from package \pkg{dplyr}. 
#' 
#' @importFrom dplyr mutate_
#' @importFrom lazyeval all_dots
#' @importFrom lazyeval lazy_eval
#' @export
#' 
#' @examples 
#' library(dplyr)
#' xs <- list(x1 = 1:3, 
#'            x2 = 2:5, 
#'            x3 = list("alpha", c("beta", "gamma")))
#' 
#' # Non-standard evaluation
#' mutate(xs, x4 = 4)
#' rename(xs, x0 = x1)
#' select(xs, -x3)
#' transmute(xs, x5 = 5)
#' 
#' # Standard evaluation
#' mutate_(xs, x4 = ~ 4)
#' rename_(xs, x0 = ~ x1)
#' select_(xs, ~ (-x3))
#' transmute_(xs, x5 = ~ 5)
#' 
mutate_.list <-
function(.data, ..., .dots)
{
  dots <- lazyeval::all_dots(.dots, ..., all_named = TRUE)
  c(.data, lazyeval::lazy_eval(dots))
}


#' @importFrom dplyr rename_
#' @importFrom dplyr rename_vars_
#' @importFrom lazyeval all_dots
#' @export
#' @rdname mutate_.list
#' 
rename_.list <-
function(.data, ..., .dots)
{
  dots <- lazyeval::all_dots(.dots, ...)
  vars <- dplyr::rename_vars_(names(.data), dots)
  names(.data) <- names(vars)
  .data
}


#' @importFrom dplyr select_
#' @importFrom dplyr select_vars_
#' @importFrom lazyeval all_dots
#' @export
#' @rdname mutate_.list
#' 
select_.list <- 
function(.data, ..., .dots)
{
  dots <- lazyeval::all_dots(.dots, ...)
  vars <- dplyr::select_vars_(names(.data), dots)
  .data[vars]
}

# todo
#summarise_.list <-
#function(.data, ..., .dots)
#{
#  dots <- lazyeval::all_dots(.dots, ..., all_named = TRUE)
#  
#}


#' @importFrom dplyr mutate_
#' @importFrom dplyr select_
#' @importFrom dplyr transmute_
#' @importFrom lazyeval all_dots
#' @export
#' @rdname mutate_.list
#' 
transmute_.list <- 
function(.data, ..., .dots)
{
  dots <- lazyeval::all_dots(.dots, ..., all_named = TRUE)
  out <- dplyr::mutate_(.data, .dots = dots)
  keep <- names(dots)
  dplyr::select_(out, .dots = keep)
}
