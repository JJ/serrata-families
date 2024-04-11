\name{great.council.families}
\alias{great.council.families}
\title{Load families data into the environment}
\usage{
data("great.council.families")
}
\description{
Load \code{great.council.families} into the environment, with data on which families hold seats in the great Council of Venice in 1261, according to Puga & Treffler \insertCite{serrata}{serrata.families}.
}

\value{
A list with the names of the families, standardized, that held a seat in the Great Council in 1261.
}

\references{
\insertAllCited{}
}

\examples{
library(serrata.families)
data("great.council.families")

# How many families were there
print(length(great.council.families))
}
