### Getting and Cleaning Data ###
### Code for the Peer Assessment ###


# set working directory
setwd("/Users/Joachim/Statistik_mit_R/Data_Science/30_Getting and Cleaning Data/Peer_Assessment/")

# download and unzip the raw data
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="Activity_Data.zip")
unzip("Activity_Data.zip")

# read the data into R
setwd("/Users/Joachim/Statistik_mit_R/Data_Science/30_Getting and Cleaning Data/Peer_Assessment/UCI HAR Dataset/train")
subject_train <- read.table( "subject_train.txt", header=FALSE, sep="")
X_train <- read.table( "X_train.txt", header=FALSE, sep="")
Y_train <- read.table( "Y_train.txt", header=FALSE, sep="")
setwd("/Users/Joachim/Statistik_mit_R/Data_Science/30_Getting and Cleaning Data/Peer_Assessment/UCI HAR Dataset/test")
subject_test <- read.table( "subject_test.txt", header=FALSE, sep="")
X_test <- read.table( "X_test.txt", header=FALSE, sep="")
Y_test <- read.table( "Y_test.txt", header=FALSE, sep="")

# combine all data to one data frame
test <- data.frame( subject_test, X_test, Y_test)
train <- data.frame( subject_train, X_train, Y_train)
activity <- rbind( test, train)

# rename the variables of the data table
setwd("/Users/Joachim/Statistik_mit_R/Data_Science/30_Getting and Cleaning Data/Peer_Assessment/UCI HAR Dataset")
features <- read.table( "features.txt", header=FALSE, sep="")
feature_names <- c( "Subject", as.character(features$V2), "Activity")
colnames(activity) <- feature_names

# subset the activity data frame to "-mean" and "-std" values
col_position <- sort( c( 1, grep( "-mean", names( activity)), grep( "-std", names( activity)), length( activity)))
activity_means <- activity[ ,col_position]

# replace the integer coding of the "Activity" column by descriptive activity names
activity_labels <- read.table( "activity_labels.txt", header=FALSE, sep="")
activity_means$Activity <- factor(activity_means$Activity, labels= activity_labels$V2)

# calculate the mean values for each "Subject" and each "Activity" and combine them in a data frame
tidy_activity <- data.frame(matrix( 0, nrow = 180, ncol = 81))
ij <- 0
for (i in 1:30){
  act_i <- subset( activity_means, activity_means$Subject == i)
  for (j in 1:6){
    ij <- ij+1
    act_ij <- subset( act_i, act_i$Activity == activity_labels$V2[ j])
    tidy_activity[ ij, 1] <- i
    tidy_activity[ ij, 2:80] <- sapply( act_ij[ , 2:80], FUN="mean")
    tidy_activity[ ij, 81] <- j
  }
}

# rename the columns of the tidy dataset and recode the activity labels
colnames( tidy_activity) <- names(activity_means)
tidy_activity$Activity <- factor(tidy_activity$Activity, labels= activity_labels$V2)

# write the tidy dataset to the working directory
write.csv( tidy_activity, file="Tidy_dataset.csv")


### End of code ###