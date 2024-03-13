require(igraph)
require(dupNodes)
require(serrata.families)

readRDS("../data/colleganza-graph.rds")
V(colleganza.graph)$betweenness <- betweenness(colleganza.graph)
plot(colleganza.graph, vertex.size=V(colleganza.graph)$betweenness/100, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza graph")

colleganza.subgraph <- induced_subgraph(colleganza.graph, V(colleganza.graph)[V(colleganza.graph)$betweenness > 0])
plot(colleganza.subgraph, vertex.size=V(colleganza.subgraph)$betweenness/300, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza subgraph")

readRDS("../data/colleganza-pairs-date.rds")
colleganza.btw <- DNSL.betweenness(colleganza.pairs.date,first.node="Family1",second.node="Family2")

print(colleganza.btw[order(colleganza.btw,decreasing=T)])

readRDS("../data/great-council-families.rds")
V(colleganza.graph)$color <- "yellow"
V(colleganza.graph)[V(colleganza.graph)$name %in% great.council.families]$color <- rgb(0.7,0,0,0.5)
plot(colleganza.graph, vertex.size=V(colleganza.graph)$betweenness/200, vertex.color=V(colleganza.graph)$color, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza graph")

components <- igraph::components(colleganza.graph, mode="weak")
biggest_cluster_id <- which.max(components$csize)
vert_ids <- V(colleganza.graph)[components$membership == biggest_cluster_id]

connected.colleganza.graph <- induced_subgraph(colleganza.graph, vert_ids)

plot(connected.colleganza.graph, vertex.size=V(connected.colleganza.graph)$betweenness/200, vertex.color=V(connected.colleganza.graph)$color, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza graph")

pre.serrata <- colleganza.slice(to=1261)
V(pre.serrata)$betweenness <- betweenness(pre.serrata)
V(pre.serrata)$color <- "yellow"
V(pre.serrata)[V(pre.serrata)$name %in% great.council.families]$color <- rgb(0.7,0,0,0.5)
plot(pre.serrata, vertex.size=V(pre.serrata)$betweenness/200, vertex.color=V(pre.serrata)$color, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza graph, pre-serrata")

post.serrata <- colleganza.slice(from=1310)
V(post.serrata)$betweenness <- betweenness(post.serrata)
V(post.serrata)$color <- "yellow"
V(post.serrata)[V(post.serrata)$name %in% great.council.families]$color <- rgb(0.7,0,0,0.5)
plot(post.serrata, vertex.size=V(post.serrata)$betweenness/200, vertex.color=V(post.serrata)$color, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza graph, post-serrata")

