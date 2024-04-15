\name{colleganza.pairs.date}
\alias{colleganza.pairs.date}
\title{Load data into the environment}
\usage{
data("colleganza.pairs.date")
}
\description{
Load \code{colleganza.pairs.date} into the environment
}

\value{
A dataframe with pairs of families that have participated in a colleganza contract, extracted from the Puga&Treffler dataset \insertCite{serrata}{serrata.families}.
}

\arguments{
  \item \code{Family1} First family name.
  \item \code{Family2} Name of the second family.
  \item \code{date} Date in which the colleganza contract took place.
}

\references{
\insertAllCited{}
}

\examples{
library(serrata.families)
data("colleganza.pairs.date")

# A summary of dates of contracts
summary(colleganza.pairs.date$date)


}
