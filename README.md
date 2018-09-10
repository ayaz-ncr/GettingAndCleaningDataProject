# GettingAndCleaningDataProject
Course Project

run_analysis.R is a R script that reads the files with the dataset, activity list and feature list.
Merges all the data from the test and the train set.
Then a subset is created where only those colums with mean or standard deviations.
Converts the activity and subject columns into factors
Creates a tidy dataset that consists of the average  value of each variable for each subject and activity pair.
The end result is in the file tidy_data.txt.
