library(igraph)
library(dupNodes)

readRDS("../data/colleganza-graph.rds")
# V(colleganza.graph)$betweenness <- betweenness(colleganza.graph)
plot(colleganza.graph, vertex.size=V(colleganza.graph)$betweenness/100, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza graph")

# select subgraph from colleganza.graph where betwenness > 0

colleganza.subgraph <- induced_subgraph(colleganza.graph, V(colleganza.graph)[V(colleganza.graph)$betweenness > 0])
plot(colleganza.subgraph, vertex.size=V(colleganza.subgraph)$betweenness/300, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza subgraph")

readRDS("../data/colleganza-pairs-date.rds")
colleganza.btw <- DNSL.betweenness(colleganza.pairs.date,first.node="Family1",second.node="Family2")

# print colleganza.btw sorted by value
print(colleganza.btw[order(colleganza.btw,decreasing=T)])

# Assign blue color to nodes of families that belong to the great council
