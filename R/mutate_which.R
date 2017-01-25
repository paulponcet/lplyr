#' @title 
#' Add new variables or modify existing ones 
#' on a subset of the data
#' 
#' @description 
#' The functions \code{mutate_which} and \code{transmute_which} are 
#' similar to \code{\link[dplyr]{mutate}} and \code{\link[dplyr]{transmute}} 
#' from package \pkg{dplyr}, except that they work only on a subset 
#' of \code{.data}, this subset being defined by the \code{.condition}. 
#' 
#' The functions \code{mutate_which_} and \code{transmute_which_} are 
#' standard evaluation versions, similar to \code{\link[dplyr]{mutate_}} and 
#' \code{\link[dplyr]{transmute_}}. 
#' 
#' @param .data
#' A tbl or data.frame. 
#' 
#' @param .condition
#' A condition defining the subset on which the mutate 
#' or transmute operation applies. 
#' New variables are initialized to \code{NA}. 
#' 
#' @param ...
#' Name-value pairs of expressions. Use \code{NULL} to drop a variable.
#' 
#' @param .dots
#' Used to work around non-standard evaluation.
#' 
#' @return 
#' A tbl or a data frame, depending on the class of \code{.data}. 
#' 
#' @author 
#' Adapted from G. Grothendieck on StackOverflow, see 
#' \url{http://stackoverflow.com/a/34096575}. 
#' 
#' @seealso \code{\link[dplyr]{mutate}},  
#' \code{\link[dplyr]{mutate_}}, 
#' \code{\link[dplyr]{transmute}},  
#' \code{\link[dplyr]{transmute_}} from package \pkg{dplyr}. 
#' 
#' @importFrom dplyr mutate_
#' @importFrom lazyeval lazy_dots
#' @export
#' 
#' @examples
#' df <- mtcars[1:10,]
#' 
#' # Non-standard evaluation
#' mutate_which(df, gear==4, carb = 100)
#' transmute_which(df, gear==4, carb = 100)
#' 
#' # Standard evaluation
#' mutate_which_(df, ~ gear==4, carb = ~ 100)
#' transmute_which_(df, ~ gear==4, carb = ~ 100)
#' 
mutate_which <- 
function(.data, 
         .condition, 
         ...)
{
  dots <- lazyeval::lazy_dots(...)
  .condition <- lazyeval::lazy(.condition)
  mutate_which_(.data, .condition, .dots = dots)
}


#' @importFrom dplyr mutate_
#' @importFrom lazyeval lazy_dots
#' @export
#' @rdname mutate_which
#' 
mutate_which_ <- 
function(.data, 
         .condition, 
         ..., 
         .dots)
{
  dots <- lazyeval::all_dots(.dots, ..., all_named = TRUE)
  expr <- lazyeval::all_dots(.condition)[[1]]$expr
  .condition <- eval(expr, .data, parent.frame())#, parent.frame())#, envir = list(.data, parent.frame()))
  
  # New variables are initialized to NA
  n <- setdiff(names(dots), names(.data))
  .data[, n] <- NA
  
  w <- rows_(.condition, .data)
  .data[w, ] <- dplyr::mutate_(.data[w, ], .dots = dots)
  .data
}


#' @importFrom dplyr select_
#' @importFrom lazyeval lazy_dots
#' @export
#' @rdname mutate_which
#' 
transmute_which <-
function (.data, 
          .condition, 
          ...) 
{
  dots <- lazyeval::lazy_dots(...)
  .condition <- lazyeval::lazy(.condition)
  transmute_which_(.data, .condition, .dots = dots)
}


#' @importFrom dplyr select_
#' @importFrom lazyeval all_dots
#' @export
#' @rdname mutate_which
#' 
transmute_which_ <-
function (.data, 
          .condition, 
          ..., 
          .dots) 
{
  dots <- lazyeval::all_dots(.dots, ..., all_named = TRUE)
  out <- mutate_which_(.data, .condition, .dots = dots)
  keep <- names(dots)
  dplyr::select_(out, keep)
}
