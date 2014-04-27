Getting_and_Cleaning_Data_Project
=================================

This repository has been created for submitting the Peer Assessment Project for the Coursera course "Getting and Cleaning Data".

The submitted R script "run_analysis.R" provides a complete solution to the task given in the peer assessment project. It runs approximately 2 minutes on a MacBook Air and saves the tidy dataset to the working directory. It does not uses any additional libraries. The script breaks down the task in the following steps:

1. set working directory: 

2. download and unzip the raw data

3. read the data into R: 
Reads from the folder "UCI HAR Dataset" (and subfolders) the following files 
"subject_train.txt"
"X_train.txt"
"Y_train.txt"
"subject_test.txt"
"X_test.txt"
"Y_test.txt"

4. combine all data to one data frame

5. rename the variables of the data table: 
The colums of the data frame are renamed using the file "features.txt" in the "UCI HAR Dataset" folder

6. subset the activity data frame to "-mean" and "-std" values: 
A data frame has been created by selecting all columns containing "-mean" and "-std" in the column names (including the "Subject" column and the "Activity" column)

7. replace the integer coding of the "Activity" column by descriptive activity names: 
The "activity_labels.txt" file in the "UCI HAR Dataset" folder has been used to recode the "Activity" column with meaningful activity names

8. calculate the mean values for each "Subject" and each "Activity" and combine them in a data frame: 
The requested tidy dataset has been created by looping over the subjects (ID 1-30) and the activities (activity code 1-6). The mean of the variables of the created subset has been calculated and written to a new data frame ("tidy_activity")

9. rename the columns of the tidy dataset and recode the activity labels: 
The created tidy dataset has been completed with proper column names and activity names in the "Activity" column

10. write the tidy dataset to the working directory: 
The tidy dataset has been written to the working directory as a .csv file.


### End of code ###
