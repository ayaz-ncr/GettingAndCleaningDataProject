library(dplyr)
library(reshape2)
setwd("C:/Users/sag/Ný flokkun/Vinna og nám/Coursera/R-kóðar/3. Cetting and Cleaning Data")

## Getting the data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- c('subjects')
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
names(Y_test) <- c('labels')
test_a <- cbind(subject_test,Y_test,X_test)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- c('subjects')
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
names(Y_train) <- c('labels')
train_a <- cbind(subject_train,Y_train,X_train)
features <- read.table("UCI HAR Dataset/features.txt")
features_use <- features[(grepl("std()+",features[,2] , perl=TRUE)|grepl("mean()+",features[,2] , perl=TRUE)) & !(grepl("meanFreq()+",features[,2] , perl=TRUE)),]
features_use[,2] <- as.character(features_use[,2])
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
#activities <- as.data.frame(activities)
activities[,2] <- as.character(activities[,2])

##** Merge the training and test data to get one data set
all_data <- rbind(test_a,train_a)

##** Extract only the mean and std for each measurement
data_use <- cbind(all_data[,1:2],all_data[,paste0('V',features_use[,1])])

##** Appropriately labels the data set with descriptive variable names.
colnames(data_use) <- c("subject", "activity", features_use[,2])

##** Use descriptive activity names to name the activities in the data set
data_use$activity <- factor(data_use$activity, levels = activities[,1], labels = activities[,2])
data_use$subject <- as.factor(data_use$subject)


##** Independent tidy data set with the average of each variable for each activity and each subject.
data_use_melt <- melt(data_use, id = c("subject", "activity"))
data_use_average <- dcast(data_use_melt, subject + activity ~ variable, mean)

write.table(data_use_average, "tidy_data.txt", row.names = FALSE, quote = FALSE)
