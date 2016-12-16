# Analyzing data from study on Human Activity Recognition
This project aggregates data from a study of smart phone accelerometer data during various activities. The data was collected as part of a study documented on this web page:
[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

We summarize the data from this project by taking the mean of each mean and standard deviation included in the original dataset.

The scripts contained within this repository perform the following:
* Download and unzip the study data
* Merges the training and test sets to create one data set
* Extracts only the mean and standard deviation for each measurement. All other measurements are discarded.
* All variable names and activity names are cleaned based on guidelines from Johns Hopkins Unversity Getting and Cleaning Data course. (Week 4, first lecture)
* A second, independent tidy data set is created and saved with the average of each variable for each activity and each subject.

## Files in this repository
* README.md - This file
* aggregated.txt - The aggragated data set produced
* codebook.md - The codebook for all data set contained in aggregated.txt
* codebookcreator.R - An ancilary R script to create the codebook
* run_analysis.R - The R script that does the analysis. Detailed steps are documented in the script
