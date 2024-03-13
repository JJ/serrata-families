\name{colleganza.families}
\alias{colleganza.families}
\title{Load families data into the environment}
\usage{
data("colleganza.families")
}
\description{
Load \code{colleganza.families} into the environment, with data on which families hold seats in the great Council of Venice in 1261, according to Puga & Treffler
}

\value{
A list with the names of the families, standardized, that held a seat in the Great Council in 1261
}

\examples{
library(serrata.families)
data("colleganza.families")

# How many families were there
print(length(colleganza.families))
}
