\name{colleganza.families}
\alias{colleganza.families}
\title{Load families data into the environment}
\usage{
data("colleganza.families")
}
\description{
Load \code{colleganza.families} into the environment, with data on which families participated in colleganza contracts according to Puga & Treffler
}

\value{
A list with the names of the families, in its Italian or standard form (in the case they had a seat in the Great Council)
}

\examples{
library(serrata.families)
data("colleganza.families")

# How many families were there
print(length(colleganza.families))
}
