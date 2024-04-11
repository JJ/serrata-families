library(serrata.families)
library(ggplot2)
library(igraph)

load("../data/great.council.families.date.rda")

ggplot(great.council.families.date, aes(x=Start)) +
  geom_histogram(binwidth=1, fill="blue", color="black") +
  labs(title="Great Council Families Dates", x="Date", y="Count") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

families.enlargement <- great.council.families.date[great.council.families.date$Start >= 1297 & great.council.families.date$Start <= 1330,]$Family

contracts.pre.1261 <- colleganza.slice(to=1261)
families.colleganza <- V(contracts.pre.1261)$name
