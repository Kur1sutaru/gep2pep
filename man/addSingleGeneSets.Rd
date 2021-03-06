% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gep2pep.R
\name{addSingleGeneSets}
\alias{addSingleGeneSets}
\title{Adds a collection of single-gene psuedo-sets.}
\usage{
addSingleGeneSets(rp, genes, organism = "Homo Sapiens")
}
\arguments{
\item{rp}{A repository created by \code{\link{createRepository}}.}

\item{genes}{a character vector containing the gene names. For each
og them a single-gene \code{GeneSet} will be created.}

\item{organism}{Character vector used to annotate the created
sets. "Homo Sapiens" by default.}
}
\value{
Nothing, used for side effects.
}
\description{
This function can be used to add single-gene (as opposed to
pathway) -based collections. Sets including a single gene don't need
to go through normal Kolmogorov-Smirnov statistic computation and
are treated differently for performance.
}
\details{
Enrichment Scores and p-values for sets including a single gene are
computed with dedicated (fast) routines. Although a statistic based
on a single gene is not efficient per se, it is useful to have data
in the same format as pathway-based profiles. \code{buildPEPs}
internally calls single gene dedicated routines whenever a gene set
collection is tagged (see repo function \code{tag}) with "SGE"
("Single Gene Expression"), which is done automatically by
\code{addSingleGeneSets}. In that case, the \code{min_size}
parameter is ignored.
}
\examples{

db <- loadSamplePWS()
repo_path <- file.path(tempdir(), "gep2pepTemp")

rp <- createRepository(repo_path, db)

## The following will create PEPs in 2 separate files
geps <- loadSampleGEP()
addSingleGeneSets(rp, rownames(geps))

unlink(repo_path, TRUE)

}
\seealso{
buildPEPs
}
