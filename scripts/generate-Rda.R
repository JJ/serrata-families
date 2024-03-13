require(jsonlite)
require(igraph)
require(usethis)

colleganza.pairs.date <- read.csv("../data-raw/colleganza-pairs-date.csv",header=F)

colnames(colleganza.pairs.date) <- c("Family1", "Family2", "date")
use_data(colleganza.pairs.date, overwrite=T)

colleganza.families <- fromJSON("../data-raw/colleganza-families.json")
use_data(colleganza.families)

colleganza.graph <- graph_from_data_frame(colleganza.pairs.date, directed=F)
use_data(colleganza.graph, overwrite=T)

great.council.families <- fromJSON("../data-raw/great-council-families.json")
use_data(great.council.families)

