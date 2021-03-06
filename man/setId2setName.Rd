% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gep2pep.R
\name{setId2setName}
\alias{setId2setName}
\title{Converts gene set IDs to gene set names}
\usage{
setId2setName(sets, ids)
}
\arguments{
\item{sets}{An object of class GeneSetCollection}

\item{ids}{character vector of gene set IDs to be converted to set
names}
}
\value{
A vector of gene set names
}
\description{
Converts gene set IDs to gene set names
}
\examples{
collection <- loadSamplePWS()
setId2setName(collection, c("M3128", "M11607"))
}
\seealso{
CondSEA, PathSEA
}
