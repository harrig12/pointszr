#test_vplot.R

context("vplot")

# ==== BEGIN SETUP AND PREPARE =================================================
#

require(DESeq2)
res <- results(DESeq(simDDS))

wrongObj <- TRUE

#
# ==== END SETUP AND PREPARE ===================================================


test_that("corrupt input generates errors", {

  expect_error(vplot(wrongObj),
                 "passed object DDSresult is not a DESeqResults", fixed = T)

})

test_that("correct input generates no output (plotting side effect)", {
  expect_silent(vplot(res))
})





# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#


rm(res)
rm(wrongObj)

# ==== END  TEARDOWN AND RESTORE ===============================================


# [END]
