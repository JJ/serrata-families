library(trend)
library(dplyr)
library(ggplot2)

load("data/colleganza.pairs.date.rda")

colleganza.pairs.date %>% group_by(date) %>% summarise(Contracts=n()) -> contracts.per.year
ggplot(contracts.per.year,aes(x=date,y=Contracts))+geom_point()

contracts.pre.serrata <- contracts.per.year[contracts.per.year$date <= 1261,]

lanzante.contracts <- lanzante.test(contracts.pre.serrata$Contracts)

changepoint.date <- contracts.pre.serrata[lanzante.contracts$estimate,]$date

contracts.pre.changepoint <- colleganza.pairs.date[ colleganza.pairs.date$date <= changepoint.date,]

