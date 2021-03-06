# szPreview.R

#' \code{szPreview} Display what a list of point sizes looks like when plotted
#'
#' @param sz an list of sizes to make points
#' @seealso \link{par}
#' @return no return, plotting side effect
#' @examples
#' sizes <- lseq(0.5, 8, 6)
#' szPreview(sizes)
#' @export

szPreview <- function(sz){
  graphics::plot(1:length(sz), ylim = c(-1,1), pch = "",  ylab = "", yaxt = 'n',
                 xaxt = 'n', xlab = "Index in sz", main = "Point size preview")
  graphics::points(1:length(sz), rep(0, length(sz)), pch = 20, cex = sz)
  graphics::axis(side = 1, at = seq(0, length(sz), by = 1))
}

#[END]
