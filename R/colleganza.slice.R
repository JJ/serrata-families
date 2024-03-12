data("colleganza.pairs.date")
colleganza.slice <- function( from=1173,to=1342) {
  colleganza.pairs.slice <- colleganza.pairs.date[ colleganza.pairs.date$date >= from & colleganza.pairs.date$date <= to,]

}
