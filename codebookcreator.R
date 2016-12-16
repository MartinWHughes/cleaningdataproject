# This function creates the code book. It is not part of the analysis
createcodebook <- function(filename, varnames) {
    codebook <- "# Code book for aggregated data set (aggregated.txt)
## Summary of data

This data file contains a summary of the data contained in the full
Human Activity dataset aggregated by taking the mean
    
All data has been normalized to the range [-1:1]
Acceleration was in the units of Gs prior to normalization

Each row is the mean of each variable for each activity and each subject

## Column contents
"
    bullets <- paste("*",varnames)
    codebook <- c(codebook, bullets)
    writeLines(codebook, filename)
}
