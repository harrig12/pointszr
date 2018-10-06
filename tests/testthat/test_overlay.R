#test_overlay.R

context("lseq")

# ==== BEGIN SETUP AND PREPARE =================================================
#

load(system.file("extdata/dev/exampleDDSresult.RData", package = "pointszr"))

#init empty plot, from
#https://stackoverflow.com/questions/4785657/how-to-draw-an-empty-plot
plot(1, type="n", xlab="", ylab="", xlim=c(-4, 4), ylim=c(0, 20))

#
# ==== END SETUP AND PREPARE ===================================================

##TODO: check vplot() called first

test_that("invalid axis causes error",  {
  #expect_error(overlay(exDDSresult, c(1,2), axis = 0), "invalid value for axis. should be num 1 or 2")

})

test_that("a sample input prouces the expected output",  {
  #expect_equal(lseq(1,10, length.out = 5), tmp)
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#

rm(exDDSresult)

# ==== END  TEARDOWN AND RESTORE ===============================================


# [END]
