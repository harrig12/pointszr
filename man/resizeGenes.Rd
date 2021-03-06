% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/resizeGenes.R
\name{resizeGenes}
\alias{resizeGenes}
\title{\code{resizeGenes} resize select subsets of  genes plotted from a DESeqDataSet}
\usage{
resizeGenes(DDSresult, geneLists, sz = lseq(1, 6, length.out =
  length(geneLists)), pch = 20, ...)
}
\arguments{
\item{DDSresult}{a DESeqResults object}

\item{geneLists}{a list of lists of genes to be resized}

\item{sz}{a list of sized to be assigned to genes.}

\item{pch}{point style to be displayed. by default pch = 20.}

\item{...}{additional arguments to pass to par.}
}
\value{
no return, plotting side effect
}
\description{
\code{resizeGenes} plot the differentially expressed genes, as specified \cr
in DDSresult, sized accordingly
}
\examples{
require(DESeq2)
simDDS <- DESeq(simDDS)
res <- results(simDDS)
vplot(res, xlab = "log2FoldChange", ylab = "-log10(pvalue)")
potentialCancerDrivers <- sample(rownames(res), 100)
knownOncogenes <- c("gene866", "gene882", "gen614", "gene89", "gene70", "gene700", "gene205")
knownTumorRepressors <- c("gene614", "gene170", "gene441", "gene229", "gene363")
geneSets <- list(potentialCancerDrivers, knownOncogenes, knownTumorRepressors)
resizeGenes(res, geneSets, sz = 1:3, col = 2)
legend("top",c("Known Occogenes","Known Tumor Repressors",
               "Potential Cancer drivers", "Other Genes"),
       pt.cex = 1:3, col = c(2,2,2,1), pch = 20)

}
\seealso{
\link{par}, \link{overlay}, , \link{vplot}
}
