library(dplyr)
library(data.table)
library(magrittr)

###################################################################
###1. Merges the training and the test sets to create one data set.
###   Appropriately labels the data set with descriptive variable names. 
###################################################################
#load activity ids and labels:
activity <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE,sep="")

#load list of variables of each feature vector 
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE,sep="")
features <- as.character(features[,2])
features <- make.names(features) #example: tBodyAcc-mean()-X becomes tBodyAcc.mean...X

###TRAIN set 
#load train data:
train <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE,sep="")
#renaming columns in train using features data frame, we want to have user friendly varable name, example: V1 becomes "tBodyAcc-mean()-X"
train_old_names = names(train)
train <- setnames(train, old = train_old_names, new = features)

#each row in the train data frame corressponds to a subject, loading subject ids:
train_subject_id <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE,sep="")
#assigning user friendly variable name to a column in train_subject_id, V1 becomes SubjectID
train_subject_id <- rename(train_subject_id,SubjectID=V1)

#train activity label id
train_activity_id <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE,sep="")
#assigning user friendly variable name to a column in train_activity_id, V1 becomes ActivityID
train_activity_id <- rename(train_activity_id,ActivityID=V1) 

#creating final train table by column binding train_subject_id and _traind_audit_id and train 
train_F <- cbind(train_subject_id, train_activity_id, train)

###TEST set
#load test data:
test <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE,sep="")
#renaming columns in test using features data frame, we want to have user friendly variable name, example: V1 becomes "tBodyAcc-mean()-X"
test_old_names = names(test)
test <- setnames(test, old = test_old_names, new = features)

#each row in the test data frame corressponds to a subject, loading subject ids:
test_subject_id <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep="")
#assigning user friendly variable name to a column in train_subject_id, V1 becomes SubjectID
test_subject_id <- rename(test_subject_id,SubjectID=V1)

#test activity label id
test_activity_id <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE,sep="")
#assigning user friendly variable name to a column in train_activity_id, V1 becomes ActivityID
test_activity_id <- rename(test_activity_id,ActivityID=V1) 

#creating final test table by column binding test_subject_id and test_audit_id and test 
test_F <- cbind(test_subject_id, test_activity_id, test)

###MERGE test_F and train_F (row binding)
merge <- rbind(train_F,test_F)

############################################################################################
###2. Extracts only the measurements on the mean and standard deviation for each measurement. 
############################################################################################
#in this step we are reducing the number of columns in the merge data frame to only those that we are interested in
#we are interested in ActivityID,SubjectID and any column that have "std.." or "mean.." in its name
colIndex <- sort(c(1,2,grep("std..",colnames(merge),value=FALSE,fixed=TRUE),grep("mean..",colnames(merge),value=FALSE,fixed=TRUE)))
mergeSubset <- merge[,colIndex]

############################################################################################
###3. Uses descriptive activity names to name the activities in the data set
############################################################################################
mergeSubset <- merge(mergeSubset,activity,by.x="ActivityID",by.y="V1",all=FALSE)
mergeSubset <- rename(mergeSubset,Activity=V2)

###################################################################################################################################################
###4. From the data set in step 3 (mergeSubset), create new independent tidy data set with the average of each variable for each activity and each subject.
###################################################################################################################################################
tidy <- mergeSubset[,2:69] #this will remove ActivityID field, we do not need it in the summarise_each
tidy <- tidy %>% group_by(Activity,SubjectID) %>% summarise_each(funs(mean))

#storing tidy and mergeSubset in the txt files - they Will be saved in the same location where R script is
write.table(tidy,"tidy.txt",row.names=FALSE)
write.table(mergeSubset,"mergeSubset.txt",row.names=FALSE)