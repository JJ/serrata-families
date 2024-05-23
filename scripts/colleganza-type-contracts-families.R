library(ggplot2)
library(tidyverse)

colleganza.family.contract.types <- read.csv("data-raw/contract-family-year.csv",header=T)

colleganza.family.contract.types %>% group_by( Family,Contract.Type ) %>% summarise(n=n()) -> colleganza.family.contract.types.summary

ggplot(colleganza.family.contract.types, aes(x=Family, y=Year, color=Contract.Type, group=Family)) + geom_point() + geom_line() + theme_minimal() + labs(title="Colleganza Family Contracts", x="Year", y="Contract Type") + geom_label( data=filter(colleganza.family.contract.types, .by=Family, Year==max(Year)), aes(label=Family))
