\name{great.council.families.date}
\alias{great.council.families.date}
\title{Load data into the environment}
\usage{
data("great.council.families.date")
}
\description{
Load \code{great.council.families.date} into the environment. Taken from Raines paper \insertCite{raines2003cooptazione}{serrata.families}.
}

\value{
A dataframe with family names that were included into the great council, and the date where that took place, in the columns \code{Family}, \code{Start} and \code{End}, these last representing the dates when their participation in the Great Council started and ended.
}

\references{
\insertAllCited{}
}

\examples{
library(serrata.families)
data("great.council.families.date")

# A summary of dates of contracts
summary(great.council.families.date$Start)


}
