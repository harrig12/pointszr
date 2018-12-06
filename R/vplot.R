# vplot.R

#' \code{vplot} create a volcano plot
#'
#' \code{vplot} plot the differentially expressed genes, as specified in DDSresult
#'
#' @param DDSresult a DESeqResults object
#' @param main plot title
#' @param xlab plot x axis label
#' @param ylab plot y axis label
#' @param pch point style to be displayed. by default pch = 20.
#' @param cex point size to be displayed. by default cex = 0.5
#' @param ... additional arguments to pass to plot().
#' @return no return, plotting side effect
#' @seealso \link{par}
#' @examples
#' require(DESeq2)
#' simDDS <- DESeq(simDDS)
#' res <- results(simDDS)
#' vplot(res, xlab = "log2FoldChange", ylab = "-log10(pvalue)")
#'
#' @export

vplot <- function(DDSresult, main = "Volcano Plot", xlab = "log2 Fold Change",
                  ylab = "-log10 p-value", pch = 20, cex = 0.5, ...){

  #check that input is a DESeq result set (referenced from DESeq2 package)
  if (!methods::is(DDSresult, "DESeqResults")){
    stop("passed object DDSresult is not a DESeqResults")
  }

  #create plot
  graphics::plot(DDSresult$log2FoldChange, -log10(DDSresult$pvalue),
                 pch = pch, cex = cex, main = main,
                 xlab = xlab, ylab = ylab, ...)

}

# [END]
