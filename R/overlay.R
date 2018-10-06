# overlay.R

#' \code{overlay} create a layer on an existing volcano plot
#'
#' \code{overlay} should be executed after vplot(), and can be re-executed several times to build up layers on a plot.
#'
#' @param DDSresult a DESeqResults object
#' @param szMod sizing modifier, a numerical vector to be applied to the elements of DDSResult. Vectors shorter than the axis they're being applied to will be recycled.
#' @param ... additional arguments to pass to points()
#'
#' @export
#'
overlay <- function(DDSresult, szMod = 1, ...){
    szMod <- rep_len(szMod, length.out = dim(DDSresult)[1])
    with(DDSresult, points(log2FoldChange, -log10(pvalue),
                           cex=szMod, ...))
}
