#test_lseq.R

context("lseq")

# ==== BEGIN SETUP AND PREPARE =================================================
#
tmp <- c(  1.0
         , 1.778279410038922980775
         , 3.162277660168379522787
         , 5.623413251903492060535
         , 10.0)

#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(lseq(), "argument \"from\" is missing, with no default", fixed = T)
  expect_error(lseq(2), "argument \"to\" is missing, with no default", fixed = T)
  expect_error(lseq(0,10), "'from' cannot be NA, NaN or infinite")
  expect_error(lseq(10,0), "'to' cannot be NA, NaN or infinite")
})

test_that("a sample input prouces the expected output",  {
  expect_equal(lseq(1,10, length.out = 5), tmp)
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]
