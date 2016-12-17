#' @title
#' Partition data across a cluster
#'
#' @description
#' The function \code{chunck} is identical to
#' \code{\link[multidplyr]{partition}} from package \pkg{multidplyr},
#' except that it adds a logical argument \code{ok};
#' if \code{ok=FALSE}, no partition is applied,
#' the input dataset is returned unchanged.
#'
#' @param .data
#' Dataset to partition
#'
#' @param ...
#' Variables to partition by.
#' Will generally work best when you have many more groups than nodes.
#' If omitted, will randomly parition rows across nodes.
#'
#' @param cluster
#' Cluster to use.
#' The default is to call \code{\link[multidplyr]{get_default_cluster}()}.
#'
#' @param ok
#' logical.
#' If \code{FALSE}, no partition is applied,
#' \code{.data} is returned unchanged.
#'
#' @return
#' The dataset partitioned accross a cluster.
#' 
#' @author 
#' Straightforward adaptation of Hadley Wickham's 
#' \code{\link[multidplyr]{partition}}. 
#' 
#' @seealso
#' \code{\link[multidplyr]{partition}} from package \pkg{multidplyr}.
#'
#' @importFrom multidplyr get_default_cluster
#' @importFrom multidplyr partition
#' @importFrom lazyeval lazy_dots
#' @export
#'
chunck <-
function(.data,
         ...,
         cluster = NULL,
         ok = FALSE)
{
  if (!ok) {
    return(.data)
  }
  if (missing(cluster) || is.null(cluster)) {
    cluster <- multidplyr::get_default_cluster()
  }
  dots <- lazyeval::lazy_dots(...)
  multidplyr::partition(.data, ..., cluster)
}


#' @export
#' @rdname chunck
#'
partition_ok <- chunck
