require(igraph)
require(dupNodes)
require(serrata.families)

load("../data/colleganza.graph.rda")
V(colleganza.graph)$betweenness <- betweenness(colleganza.graph)
plot(colleganza.graph, vertex.size=V(colleganza.graph)$betweenness/100, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza graph")

colleganza.subgraph <- induced_subgraph(colleganza.graph, V(colleganza.graph)[V(colleganza.graph)$betweenness > 0])
plot(colleganza.subgraph, vertex.size=V(colleganza.subgraph)$betweenness/300, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza subgraph")

load("../data/colleganza.pairs.date.rda")
colleganza.btw <- DNSL.betweenness(colleganza.pairs.date,first.node="Family1",second.node="Family2")

print(colleganza.btw[order(colleganza.btw,decreasing=T)])

load("../data/great.council.families.rda")
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



pre.serrata.components <- igraph::components(pre.serrata, mode="weak")
pre.serrata.biggest_cluster_id <- which.max(pre.serrata.components$csize)
pre.serrata.vert_ids <- V(pre.serrata)[pre.serrata.components$membership == pre.serrata.biggest_cluster_id]

connected.pre.serrata <- induced_subgraph(pre.serrata, pre.serrata.vert_ids)
connected.simplified.pre.serrata <- simplify(connected.pre.serrata)

E(connected.simplified.pre.serrata)$weight <- 1
pro.communities.pre.serrata <- simplify(connected.simplified.pre.serrata,edge.attr.comb=list(weight="sum"))

pre.serrata.communities <- cluster_edge_betweenness(pro.communities.pre.serrata)
plot(pre.serrata.communities, pro.communities.pre.serrata, vertex.size=V(pre.serrata)$betweenness/200, vertex.color=V(pre.serrata)$color, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza communities, pre-serrata")


post.serrata <- colleganza.slice(from=1310)
V(post.serrata)$betweenness <- betweenness(post.serrata)
V(post.serrata)$color <- "yellow"
V(post.serrata)[V(post.serrata)$name %in% great.council.families]$color <- rgb(0.7,0,0,0.5)
plot(post.serrata, vertex.size=V(post.serrata)$betweenness/200, vertex.color=V(post.serrata)$color, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza graph, post-serrata")

