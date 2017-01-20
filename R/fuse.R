#' @title 
#' Fuse multiple columns into one
#' 
#' @description 
#' \code{fuse} is a more flexible version of \code{\link[tidyr]{unite}} 
#' from package \pkg{tidyr}. 
#' 
#' @note 
#' This function has been inspired by the issue raised at 
#' \url{https://github.com/tidyverse/tidyr/issues/203}. 
#' 
#' @param .data
#' A tbl or data.frame
#' 
#' @param col
#' character. (Bare) name of column to add
#' 
#' @param ...
#' Specification of columns to fuse.  
#' 
#' @param from
#' character. A vector of the names of columns to fuse. 
#' 
#' @param fun
#' function. The function to be applied (\code{concat0} by default). 
#' 
#' @param remove
#' logical. If \code{TRUE} (the default), 
#' remove input columns from output data frame.
#' 
#' @seealso 
#' \code{\link[tidyr]{unite}} and  
#' \code{\link[tidyr]{unite_}} from package \pkg{tidyr}; 
#' 
#' \code{\link[bazar]{concat0}} from package \pkg{bazar}. 
#' 
#' @importFrom dplyr select_vars
#' @export
#' 
#' @examples 
#' df <- data.frame(x = c(NA, "a", NA), 
#'                  y = c("b", NA, NA))
#' fuse(df, "z", x, y)
#' 
#' # To be compared with: 
#' tidyr::unite(df, "z", x, y, sep = "")
#' # The same
#' fuse(df, "z", x, y, fun = function(x) concat0(x, na.rm = FALSE))
#' 
fuse <- 
function(.data, 
         col, 
         ..., 
         fun = concat0, 
         remove = TRUE)
{
  col <- col_name(substitute(col))
  from <- dplyr::select_vars(colnames(.data), ...)
  fuse_(.data, col, from, fun = fun, remove = remove)
}


#' @export
#' @rdname fuse
#' 
fuse_ <- 
function(.data, 
         col, 
         from, 
         fun = concat0, 
         #...,
         remove = TRUE) 
{
  UseMethod("fuse_")
}


#' @importFrom dplyr tbl_df
#' @export
#' @rdname fuse
#' 
fuse_.data.frame <- 
function(.data, 
         col, 
         from, 
         fun = concat0, 
         #...,
         remove = TRUE)
{
  .data <- dplyr::tbl_df(.data)
  as.data.frame(fuse_(.data, col, from, fun = fun, #...,
                      remove = remove))
}


#' @importFrom stats setNames
#' @export
#' @rdname fuse
#' 
fuse_.tbl_df <-
function(.data, 
         col, 
         from, 
         fun = concat0, 
         #...,
         remove = TRUE)
{
  #united <- do.call(fun, .data[from])#c(.data[from], list(...)))
  united <- apply(.data[from], 1, FUN = fun)
  first_col <- which(names(.data) %in% from)[1L]
  if (remove) {
    .data <- .data[setdiff(names(.data), from)]
  }
  name <- enc2utf8(col)
  append_df(.data, stats::setNames(list(united), name), 
            after = first_col - 1L)
}
