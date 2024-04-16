\name{all.great.council.families.date}
\alias{all.great.council.families.date}
\title{Load data into the environment}
\usage{
data("all.great.council.families.date")
}
\description{
Load \code{all.great.council.families.date} into the environment. Taken from Raines paper \insertCite{raines2003cooptazione}{serrata.families}. This includes also families with unknown dates.
}

\value{
A dataframe with family names that were included into the great council, and the date where that took place, in the columns \code{Family}, \code{Start} and \code{End}, these last representing the dates when their participation in the Great Council started and ended. In some cases, \code{Start} is unknown.
}

\references{
\insertAllCited{}
}

\examples{
library(serrata.families)
data("all.great.council.families.date")

# A summary of dates of contracts
summary(all.great.council.families.date$Start)


}
