
# from tidyr
append_df <-
function(x, 
         values, 
         after = length(x)) 
{
  y <- append(x, values, after = after)
  class(y) <- class(x)
  attr(y, "row.names") <- attr(x, "row.names")
  y
}
