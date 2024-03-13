library(igraph)

globalVariables(c("colleganza.pairs.date"))

#' Create social networks with slices from the colleganza Dataset
#' @param from Year of the first contract, 1073 by default
#' @param to Year of the last contract, 1342 by default, which is the last in the dataset
#' @return A graph with with families as nodes, co-occurrence in a contract as edges, but only for the contracts between those dates
#' @export
#'
#

colleganza.slice <- function( from=1073,to=1342) {
  colleganza.pairs.slice <- colleganza.pairs.date[ colleganza.pairs.date$date >= from & colleganza.pairs.date$date <= to,]
  return( graph_from_data_frame(colleganza.pairs.slice, directed=F))
}
