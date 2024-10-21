require(igraph)
require(dupNodes)
require(serrata.families)
require(ggplot2)

load("../data/colleganza.graph.rda")
V(colleganza.graph)$betweenness <- betweenness(colleganza.graph)
plot(colleganza.graph, vertex.size=V(colleganza.graph)$betweenness/100, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza graph")

colleganza.subgraph <- induced_subgraph(colleganza.graph, V(colleganza.graph)[V(colleganza.graph)$betweenness > 0])

V(colleganza.subgraph)$degree <- degree(colleganza.subgraph)
colleganza.subgraph <- induced_subgraph(colleganza.subgraph, V(colleganza.subgraph)[V(colleganza.subgraph)$degree > 0])

components <- igraph::components(colleganza.subgraph, mode="weak")
biggest_cluster_id <- which.max(components$csize)
colleganza.subgraph <- induced_subgraph(colleganza.subgraph, V(colleganza.subgraph)[components$membership == biggest_cluster_id])


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

load("../data/colleganza.family.types.rda")

for ( family in V(pre.serrata)$name ) {
  if ( family %in% colleganza.family.types$Family ) {
    V(pre.serrata)[family]$type <- colleganza.family.types[colleganza.family.types$Family == family,]$Type
  } else {
    V(pre.serrata)[V(pre.serrata)$name == family]$type <- "Unknown"
  }
}

V(pre.serrata)$shape <- "circle"
V(pre.serrata)[V(pre.serrata)$type == "Both"]$shape <- "square"
V(pre.serrata)[V(pre.serrata)$type == "Tractor"]$shape <- "csquare"

plot(pre.serrata, vertex.size=V(pre.serrata)$betweenness/200, vertex.color=V(pre.serrata)$color, edge.arrow.size=0.5, edge.curved=0.1, edge.color="grey", main="Colleganza graph, pre-serrata",vertex.shapes=V(pre.serrata)$shape)

# Compute average betweenness for every type of node
V(pre.serrata)$type <- factor(V(pre.serrata)$type)
betweenness.type <- tapply(V(pre.serrata)$betweenness, V(pre.serrata)$type, mean)

V(pre.serrata)$DNSLbetweenness <- DNSLbetweenness_for_graph(pre.serrata)
DNSLbetweenness.type <- tapply(V(pre.serrata)$DNSLbetweenness, V(pre.serrata)$type, mean)

DNSLbetweenness.type.df <- data.frame(DNSLbetweenness=V(pre.serrata)$DNSLbetweenness, type=V(pre.serrata)$type)

ggplot(DNSLbetweenness.type.df, aes(x=DNSLbetweenness, fill=type)) + geom_density(alpha=0.5) + ggtitle("DNSL betweenness by type")

ggplot(DNSLbetweenness.type.df, aes(x=DNSLbetweenness, fill=type)) + geom_histogram(position="dodge") + ggtitle("DNSL betweenness by type")

ggplot(DNSLbetweenness.type.df, aes(x=type, fill=type, y=DNSLbetweenness)) + geom_violin() + ggtitle("DNSL betweenness by type")
