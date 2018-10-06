# vplot.R

#' \code{vplot} create a volcano plot
#'
#' \code{vplot}
#'
#' @param DDSresult a DESeqResults object
#' @param pch point style to be displayed. by default pch = 20.
#' @param cex point size to be displayed. by default cex = 0.5
#' @param ... additional arguments to pass to plot().
#' @return returns the DESeqResults object that was used for plotting.
#' @seealso DESeq2
#' @examples
#' library(DESeq2)
#' simDDS <- DESeq(simDDS)
#' res <- results(simDDS)
#'
#' @export

vplot <- function(DDSresult, pch = 20, cex = 0.5, ...){

  with(DDSresult, plot(log2FoldChange, -log10(pvalue),
                       pch = pch, cex = cex, ...))
  return(DDSresult)
}
