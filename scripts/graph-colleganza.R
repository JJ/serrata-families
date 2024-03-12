library(igraph)

load("../data/colleganza-graph.rds")
V(colleganza.graph)$betweenness <- betweenness(colleganza.graph)
plot(colleganza.graph, vertex.size=V(colleganza.graph)$betweenness/100, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza graph")

# select subgraph from colleganza.graph where betwenness > 0

colleganza.subgraph <- induced_subgraph(colleganza.graph, V(colleganza.graph)[V(colleganza.graph)$betweenness > 0])
plot(colleganza.subgraph, vertex.size=V(colleganza.subgraph)$betweenness/300, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza subgraph")
