#' @title 
#' Dplyr verbs for lists and pairlists
#' 
#' @description 
#' We add methods for the verbs \code{\link[dplyr]{mutate}}, 
#' \code{\link[dplyr]{rename}}. 
#' 
#' @param .data
#' A list or pairlist. 
#' 
#' @param ...
#' Comma separated list of unquoted expressions. 
#' 
#' @param .dots
#' Used to work around non-standard evaluation. 
#' 
#' @return 
#' A list or a pairlist. 
#' 
#' @seealso \code{\link[dplyr]{mutate}},  
#' \code{\link[dplyr]{rename}} from package \pkg{dplyr}. 
#' 
#' @importFrom lazyeval all_dots
#' @importFrom lazyeval lazy_eval
#' @export
#' 
#' @examples 
#' xs <- list(x1 = 1:3, 
#'            x2 = 2:5, 
#'            x3 = list("alpha", c("beta", "gamma")))
#' 
#' # Non-standard evaluation
#' mutate(xs, x4 = 4)
#' rename(xs, x0 = x1)
#' 
#' # Standard evaluation
#' mutate_(xs, x4 = ~ 4)
#' rename_(xs, x0 = ~ x1)
#' 
mutate_.list <- 
function(.data, ..., .dots)
{
  dots <- lazyeval::all_dots(.dots, ..., all_named = TRUE)
  c(.data, lazyeval::lazy_eval(dots))
}


#' @export
#' @rdname mutate_.list
#' 
mutate_.pairlist <- mutate_.list


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


#' @export
#' @rdname mutate_.list
#' 
rename_.pairlist <- rename_.list


# #' @importFrom dplyr select_vars_
# #' @importFrom lazyeval all_dots
# #' @export
# #' @rdname mutate_.list
# #' 
# select_.list <-  
# function(.data, ..., .dots)
# {
#   dots <- lazyeval::all_dots(.dots, ...)
#   vars <- dplyr::select_vars_(names(.data), dots)
#   .data[vars]
# }


# #' @export
# #' @rdname mutate_.list
# #' 
# select_.pairlist <- select_.list


# todo
#summarise_.list <-
#function(.data, ..., .dots)
#{
#  dots <- lazyeval::all_dots(.dots, ..., all_named = TRUE)
#  
#}


# #' @importFrom dplyr mutate_
# #' @importFrom dplyr select_
# #' @importFrom lazyeval all_dots
# #' @export
# #' @rdname mutate_.list
# #' 
# transmute_.list <-  
# function(.data, ..., .dots)
# {
#   dots <- lazyeval::all_dots(.dots, ..., all_named = TRUE)
#   out <- dplyr::mutate_(.data, .dots = dots)
#   keep <- names(dots)
#   dplyr::select_(out, .dots = keep)
# }


# #' @export
# #' @rdname mutate_.list
# #' 
# transmute_.pairlist <- transmute_.list
