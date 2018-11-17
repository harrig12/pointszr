#test_overlay.R

context("overlay")

# ==== BEGIN SETUP AND PREPARE =================================================
#

require(DESeq2)
simDDS <- DESeq(simDDS)
res <- results(simDDS)

#
# ==== END SETUP AND PREPARE ===================================================

#remaining tests require initialized plot
plot(1:5, xlim = c(0,0.5), ylim = c(0,0.5))

test_that("expect warning when points exceed plot margins", {
  expect_warning(overlay(res),
                 "Some of the points overlayed exceed plot margins. Consider resizing base plot", fixed = T)
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
