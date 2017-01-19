
#' @importFrom base2 is.wholenumber
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
  } else if (base2::is.wholenumber(.condition)) {
    w <- .condition
  } else {
    stop("incorrect '.condition' argument")
  }
  w
}
