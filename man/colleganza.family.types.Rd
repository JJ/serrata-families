\name{colleganza.family.types}
\alias{colleganza.family.types}
\title{Load colleganza family types data into the environment}
\usage{
data("colleganza.family.types")
}
\description{
Load \code{colleganza.family.types} into the environment, with data on which families participated in colleganza contracts according to Puga & Treffler \insertCite{serrata}{serrata.families}. For every family, it marks whether it is (according to the same data) part of the Great Council of Venice, and whether it was a stan family (investor), tractor (travelling seaman) or both (acting like one or the other in different contracts).
}

\value{
A list with the names of the families, in its Italian or standard form (in the case they had a seat in the Great Council), and the type of family they are, in columns \code{family}, \code{type} and \code{great.council} respectively.
}

\references{
\insertAllCited{}
}
\examples{
library(serrata.families)
data("colleganza.family.types")

# How many families were there
print(length(colleganza.family.types$family))
}
