\name{colleganza.graph}
\alias{colleganza.graph}
\title{Load families data into the environment}
\usage{
data("colleganza.graph")
}
\description{
Load \code{colleganza.graph} into the environment, a graph that has families as nodes and collaboration in a colleganza contract as edge. It is an undirected graph, with data from Puga & Treffler
}

\value{
There are as many edges as contracts, nodes are labelled with the normalized (or Italian, in case they were not in the Great Council) family name
}

\examples{
library(serrata.families)
data("colleganza.graph")

plot(colleganza.graph)
}
