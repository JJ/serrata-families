require(igraph)
data("colleganza.pairs.date")
colleganza.slice <- function( from=1173,to=1342) {
  colleganza.pairs.slice <- colleganza.pairs.date[ colleganza.pairs.date$date >= from & colleganza.pairs.date$date <= to,]
  return( graph_from_data_frame(colleganza.pairs.slice, directed=F))
}
