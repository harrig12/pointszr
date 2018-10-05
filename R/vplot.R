# vplot.R

#' \code{vplot} create a volcano plot with point size variation
#'
#' \code{vplot}
#'
#' @param DDSresult a DESeqResults object
#' @param szModifier a vector containing the variable that point size is varied based on
#' @param method a string that selects the method to use when scaling point size
#' @param colSig colour points based on significance. Red if padj<0.05, orange of log2FC>1, green if both. (from http://www.gettinggeneticsdone.com/2014/05/r-volcano-plots-to-visualize-rnaseq-microarray.html)
#' @param ... arguments to pass to plot()
#' @examples
#' load(system.file("extdata/dev/exampleDDSresult.RData", package = "pointszr"))
#' vplot(exDDSresult, main = "Example output for vplot()")
#' @export
vplot <- function(DDSresult, szModifier, method, colSig=T, ...) {
  if(colSig == T){
    with(DDSresult, plot(log2FoldChange, -log10(pvalue), ...))
    with(subset(DDSresult, padj<.05 ), points(log2FoldChange, -log10(pvalue), pch=20, col="red"))
    with(subset(DDSresult, abs(log2FoldChange)>1), points(log2FoldChange, -log10(pvalue), pch=20, col="orange"))
    with(subset(DDSresult, padj<.05 & abs(log2FoldChange)>1), points(log2FoldChange, -log10(pvalue), pch=20, col="green"))
  }
  else{
    with(DDSresult, plot(log2FoldChange, -log10(pvalue), ...))
  }
}
