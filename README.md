# Getting and cleaning data course project
Coursera course project

Data for the project from this link
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
I've downloaded and uzipped the file via the R code in the run_analysis.R file.
I read the data into the following variables
* trainX
* trainY
* subject_train
* testX
* testY
* subject_test
* activities
* features

First, I assigned the right column names to each variable. Second, I extraced the columns with only mean and standard deviation values. Third, I merged together all the data into one data frame. The next step was to replace the activity labels with the actual names of the activity. Lastly, I summarised the data by person and activity and calculated mean value of the reading for each person-activity pair. Final steps were to write the data into a .txt file and create a CodeBook.
