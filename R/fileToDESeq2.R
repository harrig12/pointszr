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
#'
#' @return DESeqDataSet
#'

fileToDESeq2 <- function(fPath){

  myData <- utils::read.csv(fPath, row.names = 1, header = T,
                            stringsAsFactors = F)
  conds <- base::factor(base::names(myData))

  myData <- base::as.matrix(myData)
  conds <- S4Vectors::DataFrame(conds)
  return(DESeq2::DESeqDataSetFromMatrix(myData, conds, ~conds))
}

#[END]
