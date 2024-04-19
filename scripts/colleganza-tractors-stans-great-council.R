library(jsonlite)
library(dplyr)
library(usethis)

tractors <- fromJSON("data-raw/colleganza-tractors.json")
stans <- fromJSON("data-raw/colleganza-stans.json")
great.council <- fromJSON("data-raw/great-council-families.json")

colleganza.family.types <- data.frame(family=character(), type=character(), great.council=logical(), stringsAsFactors=FALSE)

tractor.families <- names(tractors)
stan.families <- names(stans)

colleganza.families <- unique(c(tractor.families, stan.families))
for (family in colleganza.families) {
  print(family)
  if (family %in% tractor.families) {
    colleganza.family.type <- "tractor"
  }

  if (family %in% stan.families) {
    colleganza.family.type <- "stan"
  }

  if ( (family %in% tractor.families) & (family %in% stan.families) ) {
    colleganza.family.type <- "both"
  }

  if (family %in% great.council) {
    in.great.council = TRUE
  } else {
    in.great.council = FALSE
  }

  colleganza.family.types <- rbind(colleganza.family.types, data.frame(family=family, type=colleganza.family.type, great.council=in.great.council))
}

colleganza.family.types %>%
  group_by(type) %>%
  summarise(n= n(), great_council_percentage = sum(great.council) / n() * 100) -> colleganza.family.types.summary

use_data(colleganza.family.types, overwrite=TRUE)
