#test_fileToDESeq2.R

context("fileToDESeq2.R")
library(DESeq2)

# ==== BEGIN SETUP AND PREPARE =================================================
#

#temporary file created from simDDS
mySmallData <- assay(simDDS[,1:2])

tmpPath <- tempfile(pattern = "file", tmpdir = tempdir(), fileext = "")
write.csv(mySmallData, file = tmpPath)
read.csv(tmpPath)

#
# ==== END SETUP AND PREPARE ===================================================


test_that("a sample input produces the expected output",  {

  expect_equal(assay(fileToDESeq2(tmpPath)), assay(simDDS[,1:2]))

})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().

file.remove(tmpPath)
rm(list = c("mySmallData", "tmpPath"))

# ==== END  TEARDOWN AND RESTORE ===============================================



#[END]
