% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gep2pep.R
\name{buildPEPs}
\alias{buildPEPs}
\title{Build PEPs from GEPs and stores them in the repository.}
\usage{
buildPEPs(rp, geps, min_size = 3, max_size = 500, parallel = FALSE,
  collections = "all", replace_existing = FALSE, donotstore = FALSE,
  progress_bar = TRUE, rawmode_id = NULL,
  rawmode_outdir = file.path(rp$root(), "raw"))
}
\arguments{
\item{rp}{A repository created by \code{\link{createRepository}}.}

\item{geps}{A matrix of ranks where each row corresponds to a gene
and each column to a condition. Each column must include all
ranks from 1 to the number of rows. Row and column names must
be defined. Row names will be matched against gene identifiers
in the pathways collections, and unrecognized gene names will
not be used.}

\item{min_size}{An integer representing the minimum number of genes
that must be included in a set before the KS statistic is
computed. Smaller gene sets will get ES=NA and p=NA. Default is
3. Ignored for SGE mode (see \code{addSingleGeneSets}).}

\item{max_size}{An integer representing the maximum number of genes
that must be included in a set before the KS statistic is
computed. Larger gene sets will get ES=NA and p=NA. Default is
500.}

\item{parallel}{If TRUE, gene sets will be processed in
parallel. Requires a parallel backend.}

\item{collections}{A subset of the collection names returned by
\code{getCollections}. If set to "all" (default), all the
collections in \code{rp} will be used.}

\item{replace_existing}{What to do if PEPs, identified by column
names of \code{geps} are already present in the repository. If
set to TRUE, they will be replaced, otherwise they will be
skipped and only PEPs of new conditions will be computed and
added. Either ways, will throw a warning.}

\item{donotstore}{Just compute and return the pathway-based
profiles without storing them in the repository. The repository
is still required to load pathway data, however it will not be
modified.}

\item{progress_bar}{If set to TRUE (default) will show a progress
bar updated after coversion of each column of \code{geps}.}

\item{rawmode_id}{An integer to be appended to files produced in
raw mode (see details). If set to NULL (default), raw mode is
turned off.}

\item{rawmode_outdir}{A charater vector specifying the destination
path for files produced in raw mode (by the fault it is
ROOT/raw, where ROOT is the root of the repository). Ignored if
\code{rawmode_id} is NULL.}
}
\value{
Nothing. The computed PEPs will be available in the
    repository.
}
\description{
Given a matrix of ranked lists of genes (GEPs) and a \code{gep2pep}
repository, converts GEPs to PEPs and stores the latter in the
repository.
}
\details{
By deault, output is written to the repository as new
    items named using the collection name. However, it is possible
    to avoid the repository and write the output to regular files
    turning 'raw mode' on through the \code{rawmode_id} and
    \code{rawmode_outdir} parameters. This is particuarly useful
    when dealing with very large corpora of GEPs, and conversions
    are split into independent jobs submitted to a scheduler. At
    the end, the data will need to be reconstructed and put into
    the repository using \code{importFromRawMode} in order to
    perform \code{CondSEA} or \code{PathSEA} analysis.
}
\examples{
db <- loadSamplePWS()
repo_path <- file.path(tempdir(), "gep2pepTemp")

rp <- createRepository(repo_path, db)
## Repo root created.
## Repo created.
## [15:45:06] Storing pathway data for collection: c3_TFT
## [15:45:06] Storing pathway data for collection: c3_MIR
## [15:45:06] Storing pathway data for collection: c4_CGN

rp
##          ID   Dims     Size
## c3_TFT_sets   10   18.16 kB
## c3_MIR_sets   10   17.25 kB
## c4_CGN_sets   10     6.9 kB

## Loading sample gene expression profiles
geps <- loadSampleGEP()

geps[1:3,1:3]
##       (+)_chelidonine (+)_isoprenaline (+/_)_catechin
## AKT3               88              117            417
## MED6              357              410             34
## NR2E3             383              121            453

buildPEPs(rp, geps)

rp
##           ID  Dims     Size
##   c3_TFT_sets   10 18.16 kB
##   c3_MIR_sets   10 17.25 kB
##   c4_CGN_sets   10   6.9 kB
##        c3_TFT    2  1.07 kB
##        c3_MIR    2  1.07 kB
##        c4_CGN    2  1.04 kB

unlink(repo_path, TRUE)

}
\seealso{
buildPEPs
}
