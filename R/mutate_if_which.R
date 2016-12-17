
mutate_if_which <-
function(.data, 
         .condition, 
         .predicate, 
         .funs, 
         ...)
{
  .condition <- lazyeval::lazy(.condition)
  mutate_if_which_(.data, .condition, .predicate, .funs, ...)
}


mutate_if_which_ <-
function(.data, 
         .condition, 
         .predicate, 
         .funs, 
         ...)
{
  df <- dplyr::mutate_if(.data, .predicate, .funs, ...)
  
  w <- rows_(.condition, .data)
  .data[w, ] <- df[w,]
  .data
}
