\name{great.council.families.date}
\alias{great.council.families.date}
\title{Load data into the environment}
\usage{
data("great.council.families.date")
}
\description{
Load \code{great.council.families.date} into the environment. Taken from Raines paper.
}

\value{
A dataframe with family names that were included into the great council, and the date where that took place.
\itemize{
  \item \code{Family} Family name.
  \item \code{Start} Year when they were included in the Great Council.
  \item \code{End} Documented last year when they participated in the Great Council.
}
}

\examples{
library(serrata.families)
data("great.council.families.date")

# A summary of dates of contracts
summary(great.council.families.date$Start)


}
