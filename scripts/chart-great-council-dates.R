library(serrata.families)
library(ggplot2)
library(igraph)

load("../data/great.council.families.rda")

load("../data/great.council.families.date.rda")

ggplot(great.council.families.date, aes(x=Start)) +
  geom_histogram(binwidth=1, fill="blue", color="black") +
  labs(title="Great Council Families Dates", x="Date", y="Count") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

families.initial <- great.council.families.date[great.council.families.date$Start == 1297,]$Family

families.post.1261 <- setdiff(families.initial,great.council.families)
write.csv( sort(families.post.1261), "../data/families-post-1261.csv")
families.enlargement <- great.council.families.date[great.council.families.date$Start > 1297 & great.council.families.date$Start <= 1330,]$Family

contracts.pre.1261 <- colleganza.slice(to=1261)
families.colleganza <- V(contracts.pre.1261)$name

families.in.both <-  intersect(families.colleganza,families.enlargement)

initial.families.in.both <- intersect(families.initial,families.colleganza)

post.1261.families.in.both <- intersect(families.post.1261,families.colleganza)

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

contracts.post.1261 <- colleganza.slice(from=1310)
families.colleganza.post.1261 <- V(contracts.post.1261)$name

initial.families.in.both <- intersect(families.initial,families.colleganza.post.1261)

post.1261.families.in.both <- intersect(families.post.1261,families.colleganza.post.1261)

families.only.in.colleganza.post.1261 <- setdiff(families.colleganza.post.1261,initial.families.in.both)

