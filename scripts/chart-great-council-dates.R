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

families.in.both <-  intersect(families.colleganza,families.enlargement)

print(length(families.in.both)/length(families.colleganza))
print(length(families.in.both)/length(families.enlargement))

load("../data/colleganza.graph.rda")
all.families.colleganza <- V(colleganza.graph)$name

load("../data/all.great.council.families.date.rda")
all.great.council.families <- all.great.council.families.date$Family

all.families.in.both <- intersect(all.families.colleganza,all.great.council.families)

families.only.in.colleganza <- setdiff(all.families.colleganza,all.families.in.both)
write.csv(sort(families.only.in.colleganza),"../data/families-only-in-colleganza.csv")
families.only.in.great.council <- setdiff(all.great.council.families,all.families.in.both)
write.csv(sort(families.only.in.great.council),"../data/families-only-in-great-council.csv")
