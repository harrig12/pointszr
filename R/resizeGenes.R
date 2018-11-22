# resizeGenes.R

#' \code{resizeGenes} resize select subsets of  genes plotted from a DESeqDataSet
#'
#' \code{resizeGenes} plot the differentially expressed genes, as specified \cr
#' in DDSresult, sized accordingly
#'
#' @param DDSresult a DESeqResults object
#' @param geneLists a list of lists of genes to be resized
#' @param sz a list of sized to be assigned to genes.
#' @param pch point style to be displayed. by default pch = 20.
#' @param ... additional arguments to pass to par.
#' @seealso \link{par}, \link{overlay}, , \link{vplot}
#' @examples
#' require(DESeq2)
#' simDDS <- DESeq(simDDS)
#' res <- results(simDDS)
#' vplot(res, xlab = "log2FoldChange", ylab = "-log10(pvalue)")
#' potentialCancerDrivers <- sample(rownames(res), 100)
#' knownOncogenes <- c("gene866", "gene882", "gen614", "gene89", "gene70", "gene700", "gene205")
#' knownTumorRepressors <- c("gene614", "gene170", "gene441", "gene229", "gene363")
#' geneSets <- list(potentialCancerDrivers, knownOncogenes, knownTumorRepressors)
#' resizeGenes(res, geneSets, sz = 1:3, col = 2)
#' legend("top",c("Known Occogenes","Known Tumor Repressors",
#'                "Potential Cancer drivers", "Other Genes"),
#'        pt.cex = 1:3, col = c(2,2,2,1), pch = 20)
#'
#' @export
resizeGenes <- function(DDSresult, geneLists,
                        sz = lseq(1, 6, length.out = length(geneLists)),
                        pch = 20, ...){

  #if fewer sizes than genes are provided, recycle sizes
  sz <- rep_len(sz, length(geneLists))

  for (i in 1:length(geneLists)){
    geneList <- geneLists[[i]]
    resSubset <- BiocGenerics::subset(DDSresult, rownames(DDSresult) %in% geneList)
    overlay(resSubset, szMod = sz[i], ...)
  }

}

# [END]
