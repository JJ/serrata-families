library(ggplot2)
library(tidyverse)

colleganza.family.flips <- read.csv("data-raw/contract-family-flips.csv",header=T)

colleganza.family.flips %>% group_by( Flips ) %>% summarise(n=n()) -> colleganza.family.flips.summary

colleganza.family.flips[ colleganza.family.flips$Flips == 0,] %>% group_by( First ) %>% summarise(n=n(), percentage=n()/nrow(.)) -> colleganza.family.flips.first.summary

colleganza.family.flips[ colleganza.family.flips$Flips > 0,] %>% group_by( First,Last ) %>% summarise(n=n(), percentage=n()/nrow(.)) -> colleganza.family.both.summary

colleganza.family.flips[ colleganza.family.flips$Flips == 1,] %>% group_by( First,Last ) %>% summarise(n=n(), percentage=n()/nrow(.)) -> colleganza.family.both.once.summary
