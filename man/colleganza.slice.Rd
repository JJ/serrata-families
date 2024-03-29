% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/colleganza.slice.R
\name{colleganza.slice}
\alias{colleganza.slice}
\title{Create social networks with slices from the colleganza Dataset}
\usage{
colleganza.slice(from = 1073, to = 1342)
}
\arguments{
\item{from}{Year of the first contract, 1073 by default}

\item{to}{Year of the last contract, 1342 by default, which is the last in the dataset}
}
\value{
A graph with with families as nodes, co-occurrence in a contract as edges, but only for the contracts between those dates
}
\description{
Create social networks with slices from the colleganza Dataset
}
