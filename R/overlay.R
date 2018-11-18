# overlay.R

#' \code{overlay} create a layer on an existing volcano plot
#'
#' \code{overlay} should be executed after vplot(), and can be re-executed \cr
#' several times to build up layers on a plot.
#'
#' \code{addLabels} will add point labels to a plot. This can be done using \cr
#' the default parameters by setting labelPoints = TRUE in \code{overlay}.
#'
#' @param DDSresult a DESeqResults object
#' @param szMod sizing modifier, a numerical vector to be applied to the \cr
#' elements of DDSResult. Vectors shorter than the axis they're being \cr
#' applied to will be recycled.
#' @param pch point style to be displayed.
#' @param labelPoints boolean, whether to label the points from DDSresult \cr
#' using \code{addLabels}.
#' @param pos label position relative to point
#' @param labels names for points
#' @param ... additional arguments to pass to par
#' @examples
#' require(DESeq2)
#' simDDS <- DESeq(simDDS)
#' resAB <- results(simDDS, contrast = c("condition", "A","B"))
#' resAC <- results(simDDS, contrast = c("condition", "A","C"))
#' vplot(resAB, xlab = "log2FoldChange", ylab = "-log10(pvalue)")
#' overlay(resAC, col=2)
#'
#' @seealso \link{par}, \link{vplot}
#' @export

overlay <- function(DDSresult, szMod = 0.5, pch = 20, labelPoints = F, ...){

  #throw warning if points will not be visible on plot
  xyLim <- graphics::par("usr")

  exceedsX <- ((DDSresult$log2FoldChange < xyLim[1]) |
                 (DDSresult$log2FoldChange > xyLim[2]))
  exceedsY <- ((-log10(DDSresult$pvalue) < xyLim[3]) |
                          (-log10(DDSresult$pvalue) > xyLim[4]))
  #set NA's to false
  exceedsX[is.na(exceedsX)] <- F
  exceedsY[is.na(exceedsY)] <- F

  if (any(exceedsX) | any(exceedsY)){
    warning("Some of the points overlayed exceed plot margins.
            Consider resizing base plot.")
  }

  #plot points
  szMod <- rep_len(szMod, length.out = dim(DDSresult)[1])
  graphics::points(DDSresult$log2FoldChange, -log10(DDSresult$pvalue),
                   pch = pch, cex=szMod, ...)

  #add labels
  if (labelPoints){
    addLabels(DDSresult)
  }
}

#' @rdname overlay
#' @export
addLabels <- function(DDSresult, pos = 3, labels = rownames(DDSresult), ...){

  #plot labels
  graphics::text(DDSresult$log2FoldChange, -log10(DDSresult$pvalue), pos = pos,
       labels = labels, ...)

}

