#fileToDESeq2.R

#' \code{fileToDESeq2} this function is for developer use only, with the pointszr \cr
#' shiny app. This function is very limited in its arguments, since the user \cr
#' can't do much manipulaiton once in the shiny app. \cr
#' Want to limit the options available.
#'
#' \code{fileToDESeq2} Create a DESeqDataSet from a file input
#'
#' @param fPath path to file on user's system. expect file to be a CSV of gene \cr
#' expression counts with first row names of test conditions, and first \cr
#' column names of genes (with no repeats)
#' @param header whether file contains header, passed to read.csv()
#' @param sep data delimiting character, passed to read.csv()
#'
#' @return DESeqDataSet
#'@seealso \link{read.csv}

fileToDESeq2 <- function(fPath, header = TRUE, sep = ","){

  myData <- utils::read.csv(fPath, row.names = 1, header = header,
                            sep = sep, stringsAsFactors = FALSE)
  conds <- base::factor(base::names(myData))

  myData <- base::as.matrix(myData)
  conds <- S4Vectors::DataFrame(conds)
  return(DESeq2::DESeqDataSetFromMatrix(myData, conds, ~conds))
}

#[END]
