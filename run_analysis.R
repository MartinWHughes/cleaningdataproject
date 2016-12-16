library(dplyr)

retrievedata <- function(myurl) {
    # Read and unzip the data sets to the current working directory
    # return the name of the subdirectory unzip created
    temp <- tempfile()
    download.file(myurl, destfile = temp)
    unzip(temp)
    # delete the temp file that was created to hold the zip file
    unlink(temp)
    # use OS independant means to build file paths.
    file.path(getwd(),"UCI HAR Dataset")
}

cleannames <- function(dirtynames) {
    # Follow the guidelines in the first lecture of Week 4 to clean variable names
    # Note: In this case, I think it makes the variables less readable, but I
    # assume they want us to show mastery of cleaning names
    # Return the cleaned names
  
    # convert to all lowercase
    clean <- tolower(dirtynames)
    # Get rid of dashes, commas, (, ), and underscores
    gsub("-|,|\\(|\\)| |_","",clean)
}

readnames <- function(filename) {
    # Read the files that contain the names of the variables, activities, etc
    # return a vector of the values read
    mynames <- read.table(filename,strip.white=TRUE)
    mynames <- t(mynames$V2)
    cleannames(as.vector(mynames))
}

readdata <- function(testtype, features) {
    # Read the data set for the given test type (test or training)
    # The data, subject ids, and activities have to be read independently
    # and combined into one table
    subject <- read.table(file.path(datadir, testtype, paste0("subject_", testtype, ".txt")), col.names = "subject")
    activity <- read.table(file.path(datadir, testtype, paste0("y_", testtype, ".txt")), col.names = "activity")
    my_df <- read.table(file.path(datadir, testtype, paste0("X_", testtype, ".txt")), col.names = features)
    # It's easier to go ahead and strip out the variables that we are interested in here
    # It also allows the memory of the uninteresting data to be reclaimed my_df goes out
    # of scope after returning.
    my_df <- select(my_df, grep("mean|std",features))
    cbind(cbind(subject, activity), my_df)
}

#  Read the zipped data set and unzip
datadir <- retrievedata("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

# Read the veriable names and clean them
features <- readnames(file.path(datadir, "features.txt"))

# Merge the training and the test sets to create one data set.
mydata <- rbind(readdata("test", features), readdata("train", features))

# Create a second, independent tidy data set with the mean of each variable
# for each activity and each subject
results <- aggregate(mydata[3:ncol(mydata)], by=list(mydata$subject,mydata$activity), FUN=mean)
colnames(results)[1:2] <- c("subject", "activity")

# Give descriptive activity names to the activities in the data set
activities <- readnames(file.path(datadir, "activity_labels.txt"))
results <- mutate(results, activity = activities[activity])

# Write the second data set
write.table(results, "aggregated.txt", row.names = FALSE, col.names = FALSE)

# Create the code book here for ease of adding the variable names
source("codebookcreator.R")
createcodebook("codebook.md", names(results))