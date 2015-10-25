# Set the working directory
setwd("C:/NYL/2015/Training/Coursera/Getting and Cleaning Data/Assignment/UCI HAR Dataset")

# This program performs the following on the data downloaded from
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
#read train, test data, activity labels and features
sub_train <- read.table("train/subject_train.txt")
sub_test <- read.table("test/subject_test.txt")

x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")

y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")

features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

## Extract only the measurements on the mean and standard deviation for each measurement
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

#3. Uses descriptive activity names to name the activities in the data set
currentActivity = 1
for (currentActivityLabel in activity_labels$V2) {
  y_train$V1 <- gsub(currentActivity, currentActivityLabel, y_train$V1)
  y_test$V1 <- gsub(currentActivity, currentActivityLabel, y_test$V1)
  currentActivity <- currentActivity + 1
}


# create 'train' and 'test' data set - combine
train_data <- cbind(x_train, y_train, sub_train)
test_data <- cbind(x_test, y_test,sub_test)

# correct the column names
names(train_data) <- c(features[, 2], "Activity", "Participant")
names(test_data) <- c(features[, 2], "Activity", "Participant")

nrow(train_data)
ncol(test_data)

#1. Merges the training and the test sets to create one data set.
combined_data <- rbind(train_data, test_data)
#names(combined_data)
#head(combined_data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
subsetCols <- grep(".*Mean.*|.*Std.*", features[,2])
#subsetCols <- c(subsetCols, "Activity", "Participant")

combined_data <- combined_data[,c(subsetCols,562,563)]
ncol(combined_data)

#4. Appropriately labels the data set with descriptive variable names. 
names(combined_data)
names(combined_data) <- gsub("Acc", "Accelerator", names(combined_data))
names(combined_data) <- gsub("Mag", "Magnitude", names(combined_data))
names(combined_data) <- gsub("Gyro", "Gyroscope", names(combined_data))


#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data = aggregate(combined_data, by=list(Activity = combined_data$Activity, Participant=combined_data$Participant), mean)
#ncol(tidy_data)
write.table(tidy_data, "tidy.txt", sep="\t")


