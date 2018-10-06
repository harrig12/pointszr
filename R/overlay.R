# overlay.R

#' \code{overlay} create a layer on an existing volcano plot
#'
#' \code{overlay} should be executed after vplot(), and can be re-executed several times to build up layers on a plot.
#'
#' @param DDSresult a DESeqResults object
#' @param szMod sizing modifier, a numerical vector to be applied to the elements of DDSResult. Vectors shorter than the axis they're being applied to will be recycled.
#' @param pch point style to be displayed. by default pch = 20.
#' @param ... additional arguments to pass to points()
#' @examples
#' library(DESeq2)
#' simDDS <- DESeq(simDDS)
#' resAB <- results(simDDS, contrast = c("condition", "A","B"))
#' resAC <- results(simDDS, contrast = c("condition", "A","C"))
#'
#' @export
#'
overlay <- function(DDSresult, szMod = 1, pch = 20, ...){
    szMod <- rep_len(szMod, length.out = dim(DDSresult)[1])
    with(DDSresult, points(log2FoldChange, -log10(pvalue),
                           pch = pch, cex=szMod, ...))
}
