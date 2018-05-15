##Getting and Cleaning Data Course Project

##Part 1: Merge the training and the test sets to create one data set.
##Part 2: Extracts only the measurements on the mean and standard deviation for 
##each measurement.

##I decided to extract the mean and standard deviation measurements first
##as it will make the merge faster.

library(data.table)

##Selecting only the features with mean(), std() or meanFreq() 
features <- fread("features.txt", select = 2, col.names = "featureName")
extractIndex <- grep("mean|std",features$featureName, perl = TRUE)
featuresExtracted <- unlist(features[extractIndex,])

##Reading the training data
trainingSubjects <- fread("train/subject_train.txt", col.names = "Subject")
trainingActivities <- fread("train/y_train.txt",col.names = "Activity")
trainingData1 <- fread("train/X_train.txt",select = extractIndex,
       col.names = featuresExtracted)
trainingData2 <- cbind(trainingSubjects,trainingActivities,trainingData1)

##Reading the test data
testSubjects <- fread("test/subject_test.txt", col.names = "Subject")
testActivities <- fread("test/y_test.txt",col.names = "Activity")
testData1 <- fread("test/X_test.txt",select = extractIndex,
                       col.names = featuresExtracted)
testData2 <- cbind(testSubjects,testActivities,testData1)

##Merge the data
combinedData <- rbind(trainingData2,testData2)

##Part 3: Uses descriptive activity names to name the activities in the data set
activityLabels <- fread("activity_labels.txt",col.names = c("Index","Activity"))
for (i in 1:6){
  combinedData$Activity[which(combinedData$Activity == i)] <- activityLabels$Activity[i] 
}

##Part 4: Appropriately labels the data set with descriptive variable names.
## This was already done when I merged the data

##Part 5: From the data set in step 4, creates a second, independent tidy data 
##set with the average of each variable for each activity and each subject.

library(dplyr)

groupedData <- group_by(combinedData,Subject,Activity)
tidyMeans <- summarise_all(groupedData,mean)

fwrite(tidyMeans,"tidyMeans.csv")
  