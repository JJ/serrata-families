require(jsonlite)
require(igraph)

colleganza.pairs.date <- read.csv("../data-raw/colleganza-pairs-date.csv",header=F)

colnames(colleganza.pairs.date) <- c("Family1", "Family2", "date")
saveRDS(colleganza.pairs.date, file = "../data/colleganza-pairs-date.rds")

colleganza.families <- fromJSON("../data-raw/colleganza-families.json")
saveRDS(colleganza.families, file = "../data/colleganza-families.rds")

colleganza.graph <- graph_from_data_frame(colleganza.pairs.date, directed=F)
saveRDS(colleganza.graph, file = "../data/colleganza-graph.rds")
