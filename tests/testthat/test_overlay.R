#test_overlay.R

context("overlay")

# ==== BEGIN SETUP AND PREPARE =================================================
#

load(system.file("extdata/dev/exampleDDSresult.RData", package = "pointszr"))


require(DESeq2)
simDDS <- DESeq(simDDS)
res <- results(simDDS)

#
# ==== END SETUP AND PREPARE ===================================================

test_that("plot has been initialized before overlay called", {
  expect_error(overlay(res), "plot.new has not been called yet", fixed = T)
})

#remaining tests require initialized plot
plot(1:5, xlim = c(0,0.5), ylim = c(0,0.5))

test_that("expect warning when points exceed plot margins", {
  expect_warning(overlay(res),
                 "Some of the points overlayed exceed plot margins. Consider resizing base plot", fixed = T)
})


test_that("a sample input prouces the expected output",  {
  #expect_equal(lseq(1,10, length.out = 5), tmp)
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#

rm(simDDS)
rm(res)
dev.off()

# ==== END  TEARDOWN AND RESTORE ===============================================


# [END]
