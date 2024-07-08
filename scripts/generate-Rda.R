require(jsonlite)
require(igraph)
require(usethis)

colleganza.pairs.date <- read.csv("../data-raw/colleganza-pairs-date.csv",header=F)

colnames(colleganza.pairs.date) <- c("Family1", "Family2", "date")
use_data(colleganza.pairs.date, overwrite=T)

colleganza.families <- fromJSON("../data-raw/colleganza-families.json")
use_data(colleganza.families,overwrite=T)

colleganza.graph <- graph_from_data_frame(colleganza.pairs.date, directed=F)
use_data(colleganza.graph, overwrite=T)

great.council.families <- fromJSON("../data-raw/great-council-families.json")
use_data(great.council.families, overwrite=T)

great.council.families.dates <- read.csv("../data-raw/families-great-council-date.csv",sep=";")
great.council.families.dates$Start <- as.numeric(trimws(great.council.families.dates$Start))
great.council.families.dates$Family <- trimws(great.council.families.dates$Family)
great.council.families.date <- great.council.families.dates[ !is.na(great.council.families.dates$Start),]
use_data(great.council.families.date, overwrite=T)
all.great.council.families.date <- great.council.families.dates
use_data(all.great.council.families.date, overwrite=T)

colleganza.family.types <- read.csv("../data-raw/colleganza-family-types.csv",header=T,sep=";")
use_data(colleganza.family.types, overwrite=T)

colleganza.family.flips <- read.csv("../data-raw/contract-family-flips.csv",header=T)
use_data(colleganza.family.flips, overwrite=T)

colleganza.family.flips.pre <- read.csv("../data-raw/contract-family-flips-pre.csv",header=T)
use_data(colleganza.family.flips.pre, overwrite=T)

colleganza.family.flips.post <- read.csv("../data-raw/contract-family-flips-post.csv",header=T)
use_data(colleganza.family.flips.post, overwrite=T)

contract.data.families <- read.csv("../data-raw/contract-data-families.csv",header=T)
use_data(contract.data.families, overwrite=T)

