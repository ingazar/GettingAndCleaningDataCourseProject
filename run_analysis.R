## Download the data and unzip the file
fileURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,"Dataset.zip")
unzip("Dataset.zip")

## Load the required libraries
library(data.table)
library(plyr)
library(tidyr)
library(dplyr)

## Read TRAIN data tables
trainX<- read.table("./train/X_train.txt")
trainY<- read.table("./train/Y_train.txt")
subject_train<- read.table("./train/subject_train.txt")
## Read TEST data table
testX<- read.table("./test/X_test.txt")
testY<- read.table("./test/Y_test.txt")
subject_test<- read.table("./test/subject_test.txt")
## Read activities labels into a table
activities<- read.table("activity_labels.txt")
## Read data with features descriptions as a string vector
features<- as.character(read.table("features.txt")$V2)

## 4. Appropriately labels the data set with descriptive variable names. 
names(trainX)<- features
names(trainY)<- "activity.label"
names(subject_train)<- "person"
names(testX)<- features
names(testY)<- "activity.label"
names(subject_test)<- "person"
names(activities)<- c("label","activity")

## 2. Extracts only the measurements on the mean 
##      and standard deviation for each measurement. 
train<- trainX[,grep("mean\\(\\)|std\\(\\)",names(trainX), value= TRUE)]
test<- testX[,grep("mean\\(\\)|std\\(\\)",names(testX), value= TRUE)]

## 1. Merges the training and the test sets to create one data set.
train<- cbind(subject_train,trainY,train)
test<- cbind(subject_test,testY,test)
df<- rbind(train,test)

## 3. Uses descriptive activity names to name the activities in the data set
mergedData<- merge(activities, df, by.x="label",by.y="activity.label", 
                   all=TRUE, sort = FALSE)
mergedData$label<-NULL

## 5. From the data set in step 4, creates a second, independent 
##      tidy data set with the average of each variable for each 
##      activity and each subject.
tidyData<- ddply(mergedData, .(activity,person), function(x) {colMeans(x[, 3:68])})
write.table(tidyData, file = "tidyData.txt", row.name = FALSE)

## Generate the CodeBook        
write.table(colnames(mergedData), file = "CodeBook.md", row.name = FALSE, quote = FALSE)
