\name{colleganza.pairs.date}
\alias{colleganza.pairs.date}
\title{Load data into the environment}
\usage{
data("colleganza.pairs.date")
}
\description{
Load \code{colleganza.pairs.date} into the environment, that is, the dates and family names of that appear in a contract, with the columns \code{Family1}, \code{Family2} and \code{date}.
}

\value{
A dataframe with pairs of families that have participated in a colleganza contract, extracted from the Puga&Treffler dataset \insertCite{serrata}{serrata.families}.
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
