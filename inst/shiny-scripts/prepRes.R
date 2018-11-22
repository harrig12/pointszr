#prepRes.R

#Check file uploaded ----
req(input$file1)

tryCatch(
  {
    userDDS <- pointszr:::fileToDESeq2(input$file1$datapath,
                                       header = input$header,
                                       sep = input$sep)
  },
  error = function(e) {
    # return a safeError if a parsing error occurs
    stop(safeError(e))
  }
)

#Compute result ----
userDDS <- DESeq2::DESeq(userDDS)
res <- DESeq2::results(userDDS)

#Further processing for plotting, brush rendering ----
resPoints <- res
#remove NA's (can't select or plot these)
resPoints <- resPoints[stats::complete.cases(resPoints$pvalue),]
#and transform
resPoints$pvalue <- -log10(resPoints$pvalue)
colnames(resPoints)[colnames(resPoints) == "pvalue"] <- "negative_log10_pvalue"



#[END]
