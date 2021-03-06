# getPlotLims.R

#' \code{getPlotLims} Get the plot limits of a volcano plot for the passed \cr
#' DESeqResults object
#'
#' @param DDSresult a DESeqResults object
#' @return list of xlim and ylim of a vplot for the object
#' @seealso \link{par}
#' @examples
#' require(DESeq2)
#' simDDS <- DESeq(simDDS)
#' res <- results(simDDS)
#' getPlotLims(res)
#'
#' @export

getPlotLims <- function(DDSresult){

  x <- c(min(DDSresult$log2FoldChange, na.rm = TRUE),
         max(DDSresult$log2FoldChange, na.rm = TRUE))

  #for -log values, min and max will be inverted
  y <- c(-log10(max(DDSresult$pvalue, na.rm = TRUE)),
         -log10(min(DDSresult$pvalue, na.rm = TRUE)))

  return(list(x=x, y=y))

}
