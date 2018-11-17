#test_getPlotLims.R

context("getPlotLims")
library(DESeq2)

# ==== BEGIN SETUP AND PREPARE =================================================
#
simDDS <- DESeq(simDDS)
res <- results(simDDS)

xMax <- max(res$log2FoldChange, na.rm = T)
xMin <- min(res$log2FoldChange, na.rm = T)

yMax <- -log10(min(res$pvalue, na.rm = T))
yMin <- -log10(max(res$pvalue, na.rm = T))


#
# ==== END SETUP AND PREPARE ===================================================


test_that("a sample input prouces the expected output",  {
  expect_equal(getPlotLims(res)$x, c(xMin, xMax))
  expect_equal(getPlotLims(res)$y, c(yMin, yMax))
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().

rm(list = c("xMin", "xMax", "yMin", "yMax", "simDDS", "res"))


# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]
