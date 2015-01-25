---
title: "Readme for John Hopkins and Cleaning Data course project"
author: "Karol Dorniak"
date: "Sunday, January 25, 2015"
output: word_document
---

The objective of the project is to create a tidy.csv data set based on the raw data collected from the accelerometers from the Samsung Galaxy S smartphone. 

To fulfil the project's requirements, the R script has been developed: run_analysis.R, which purpose was to collect, transform and tidy raw data. The final results were saved in the tidy.csv file.

Raw data used by run_analysis.R has been downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extracted to "UCI HAR Dataset" folder.

The following source files from the "UCI HAR Dataset" folder were used by run_analysis.R to produce tidy.csv:

* UCI HAR Dataset/activity_labels.txt - an activity's user friendly desciption of a given activity id
* UCI HAR Dataset/features.txt - list of all features (variables in X_train.txt, X_test.txt). The label of the column Nth of the X_train.txt/X_test.txt can be found in the row N of features.txt.
* UCI HAR Dataset/train/X_train.txt - training data set
* UCI HAR Dataset/train/subject_train.txt - each row identifies the subject who performed the activity for each window sample. The data in the Nth row of training data set relates to a subject identified in the Nth row of subject_train.txt
* UCI HAR Dataset/train/y_train.txt -  data in the Nth row of the training data set relates to an activity id identified in the Nth row of the y_train.txt. An activity's user friendly desciption of a given activity id can be found in the activity_labels.txt
* UCI HAR Dataset/test/X_test.txt - test data set
* UCI HAR Dataset/test/subject_test.txt - each row identifies the subject who performed the activity for each window sample. The data in the Nth row of test data set relates to a subject identified in the Nth row of subject_test.txt
* UCI HAR Dataset/test/y_test.txt - data in the Nth row of the training data set relates to an activity id identified in the Nth row of the y_test.txt. An activity's user friendly description of a given activity id can be found in the activity_labels.txt

**run_analysis.R script and "UCI HAR Dataset" folder are located in the working directory (same location).**

run_analysis.R conducts the following operations on the raw data to produce tidy.csv file:

1. Merge the training and the test sets to create one data set and provide descriptive variable names . 
2. Extract from the new merged data set only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
5. Save independent tidy data to tidy.csv

**run_analysis.R code has been explained in details using script commentaries - open the script file to read code explanation**