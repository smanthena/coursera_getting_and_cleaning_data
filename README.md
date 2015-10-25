# coursera_getting_and_cleaning_data
Getting and Cleaning Data: Course Project
Introduction
This repository contains my assignment for the course project for the Coursera course "Getting and Cleaning data", part of the Data Science specialization. 

About the raw data
The features (561 of them) are unlabeled and can be found in the x_test.txt. The activity labels are in the y_test.txt file. The test participants are in the subject_test.txt file.

The same holds for the training set.

About the R program 
A program called run_analysis.R is created which will merge the test and training sets together. Prerequisites for this script:

the UCI HAR Dataset must be extracted and..
the UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"
set the working directory to your current working directory/UCI HAR Dataset
After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept along with the participant and activity

About the Tidy Set
A tidy data set containing the means of all the columns per test participant and per activity is created. This tidy dataset will be written to a tab-delimited file called tidy.txt, which can also be found in this repository.

About the Code Book

The CodeBook.md file explains the resulting data and variables.
