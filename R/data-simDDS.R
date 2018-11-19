#' simDDS data
#'
#' Data simulated by using DESeq2's makeExampleDESeqDataSet()
#'
#' @details created in R:
#' \code{
#' simDDS <- makeExampleDESeqDataSet(n = 1000, m = 12)
#' colData(simDDS)$condition <- factor(c(rep("A", 4), rep("B", 4), rep("C", 4)))
#' }
#'
#' @format A DESeqDataSet with 1000 rows and 12 columns:
#' \describe{
#'   class: DESeqDataSet
#'   dim: 1000 12
#'   metadata(1): version
#'   assays(1): counts
#'   rownames(1000): gene1 gene2 ... gene999 gene1000
#'   rowData names(3): trueIntercept trueBeta trueDisp
#'   colnames(12): sample1 sample2 ... sample11 sample12
#'   colData names(1): condition
#' }
#'
#' @seealso DESeq2::makeExampleDESeqDataSet
#' @examples
#' \dontrun{
#' (simDDS)
#' }
#' @docType data
#' @name simDDS
NULL

#[END]
