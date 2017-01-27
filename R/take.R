#' @title 
#' Subset data frames 
#' 
#' @description 
#' Return subset of a data frame which meets conditions. 
#' 
#' @param .data
#' A tbl or data.frame. 
#' 
#' @param .condition
#' A condition defining the \code{\link[dplyr]{filter}} to be applied on 
#' \code{.data}. 
#' 
#' @param ...
#' Variable names to be \code{\link[dplyr]{select}}ed. 
#' 
#' @param .dots
#' character vector of variable names to be \code{\link[dplyr]{select}}ed. 
#' 
#' @return 
#' A tbl or data.frame
#' 
#' @seealso \code{\link[dplyr]{filter}} and \code{\link[dplyr]{select}} 
#' from package \pkg{dplyr}. 
#' 
#' @importFrom lazyeval lazy
#' @importFrom lazyeval lazy_dots
#' @export
#' 
#' @examples 
#' df <- mtcars[1:10,]
#' take(df, cyl %in% c(4, 6), mpg, disp)
#' take_(df, ~ cyl %in% c(4, 6), ~ mpg, ~ disp)
#' take_(df, ~ cyl %in% c(4, 6), .dots = c("mpg", "disp"))
#' 
take <- 
function(.data, 
         .condition, 
         ...)
{
  dots <- lazyeval::lazy_dots(...)
  .condition <- lazyeval::lazy(.condition)
  take_(.data, .condition, .dots = dots)  
}


#' @export
#' @rdname take
#' 
take_ <- 
function(.data, 
         .condition, 
         ..., 
         .dots)
{
  UseMethod("take_")
}


#' @importFrom dplyr tbl_df
#' @importFrom lazyeval all_dots
#' @export
#' @rdname take
#' 
take_.data.frame <- 
function(.data, 
         .condition, 
         ..., 
         .dots)
{
  dots <- lazyeval::all_dots(.dots, ...)
  as.data.frame(take_(dplyr::tbl_df(.data), .condition = .condition, .dots = dots))
}


#' @importFrom dplyr filter_
#' @importFrom dplyr select_
#' @importFrom lazyeval all_dots
#' @export
#' @rdname take
#' 
take_.tbl_df <- 
function(.data, 
         .condition, 
         ..., 
         .dots)
{
  dots <- lazyeval::all_dots(.dots, ...)
  .data <- dplyr::filter_(.data, .dots = .condition)
  dplyr::select_(.data, .dots = dots)
}
