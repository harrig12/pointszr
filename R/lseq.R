# lseq.R

#' \code{lseq} output a sequence of logarithmically spaced numbers.
#'
#' \code{lseq} works like \code{seq} in that it returns a vector of numbers with \code{from} as the first element, \code{to} as the last elelemnt, and \code{length.out} as the length of the vector, but the values are logarithmically spaced.
#'
#' @param from first number in the sequence.
#' @param to last number in the sequence.
#' @param length.out length of the sequence, a positive integer > 1. Default is 10.
#' @return A numeric vector.
#' @seealso \code{\link{seq}}
#' @examples
#' plot(c(0.1,10), c(0,1))
#' abline(v = lseq(0.1, 10, length.out = 20), col="#3366FF66")
#' @export
lseq <- function(from, to, length.out = 10) {
  #check arguments provided
  passed <- names(base::match.call())
  if (! "from" %in% passed){
    stop("argument \"from\" is missing, with no default")
  }
  if (! "to" %in% passed){
    stop("argument \"to\" is missing, with no default")
  }

  x <- seq(log(from), log(to), length.out = length.out)
  return(exp(x))
}

# [END]
