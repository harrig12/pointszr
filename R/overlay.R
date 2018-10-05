# overlay.R

#' \code{overlay} create a layer on an existing volcano plot
#'
#' \code{overlay} should be executed after vplot(), and can be re-executed several times to build up layers on a plot.
#'
#' @param DDSresult a DESeqResults object
#' @param szMod sizing modifier, a numerical vector to be applied to the elements of DDSResult. Vectors shorter than the axis they're being applied to will be recycled.
#' @param axis num, value either 1 for rows or 2 for columns. Indicated whether sizing modifier applies to rows or columns of DDSResult.
#'
#'
#'
#' @export
overlay <- function(DDSresult, szMod, axis = 1, ...){
  if(axis == (1|2)){
    szMod <- rep_len(szMod, length.out = dim(DDSresult)[axis])
    with(DDSresult, points(log2FoldChange, -log10(pvalue),
                           cex=szMod, ...))
  }
  else {
    stop("invalid value for axis. should be num 1 or 2")
  }
}
