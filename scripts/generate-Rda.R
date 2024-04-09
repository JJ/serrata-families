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

great.council.families.dates <- read.csv("../data-raw/families-great-council-date.csv",sep=";")
great.council.families.dates$Start <- as.numeric(trimws(great.council.families.dates$Start))
great.council.families.date <- great.council.families.dates[ !is.na(great.council.families.dates$Start),]
use_data(great.council.families.date, overwrite=T)
