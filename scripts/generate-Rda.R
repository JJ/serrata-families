require(jsonlite)
require(igraph)

colleganza.pairs.date <- read.csv("../data/colleganza-pairs-date.csv",header=F)
#rename columns
colnames(colleganza.pairs.date) <- c("Family1", "Family2", "date")
saveRDS(colleganza.pairs.date, file = "../data/colleganza-pairs-date.rds")

colleganza.families <- fromJSON("../data/colleganza-families.json")
saveRDS(colleganza.families, file = "../data/colleganza-families.rds")

