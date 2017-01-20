
#' @importFrom bazar is.wholenumber
#' 
rows_ <- 
function(.condition, 
         .data)
{
  n <- nrow(.data)
  if (missing(.condition) || is.null(.condition)) {
    w <- seq_len(n)
  } else if (is.logical(.condition) && length(.condition)==n) {
    w <- which(.condition)
  } else if (is.logical(.condition) && length(.condition)==1L) {
    w <- which(rep(.condition, n))
  } else if (bazar::is.wholenumber(.condition)) {
    w <- .condition
  } else {
    stop("incorrect '.condition' argument")
  }
  w
}
