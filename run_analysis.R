# ==============================================================================

# COURSE PROJECT FOR GETTING AND CLEANING DATA FOR COURSERA
# AUTHOR: PRASHANT ATHAVALE

# To run the code you must have following files in the "same folder" as the code:

# X_test.txt
# y_test.txt
# subject_test.txt

# X_train.txt
# y_train.txt
# subject_train.txt

# features.txt

# These files can be downloaded from:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


# ==============================================================================
rm(list=ls())
cat("\014")

# ==============================================================================
# STEP 1 (a)
# Extracting only the measurements on the mean and standard deviation 
# for each "measurement" from the test data
# ==============================================================================
xtest_raw<-read.table("X_test.txt")
vector_small<-c(1:6, 41:46, 121:126)
xtest<-xtest_raw[vector_small]

# ==============================================================================
# STEP 1(b)
# Joining the measurements with the activity and subject ID using cbind
# ==============================================================================
subject_test<-read.table("subject_test.txt")
activity_test<-read.table("y_test.txt")
test_data<-cbind(subject_test, activity_test, xtest)

# ==============================================================================
# STEP 1 (c)
# Extracting only the measurements on the mean and standard deviation 
# for each "measurement" from the training data
# ==============================================================================
xtrain_raw<-read.table("X_train.txt")
xtrain<-xtrain_raw[vector_small]
# ==============================================================================
# STEP 1(d)
# Joining the measurements with the activity and subject ID using cbind
# ==============================================================================
subject_train<-read.table("subject_train.txt")
activity_train<-read.table("y_train.txt")
train_data<-cbind(subject_train, activity_train, xtrain)
# ==============================================================================
# STEP 2
# ==============================================================================
# Merging the test data and the training data using rbind
merged<-rbind(test_data, train_data)

# ==============================================================================
# STEP 3
# Using descriptive activity names to name the activities in the data set
# ==============================================================================
L<-length(merged[,2])
for (i in 1:L){
      if ((merged[i,2])==1)
            merged[i,2]<-"Walking"
      else if ((merged[i,2])==2)
            merged[i,2]<-"Walking_upstairs"
      else if ((merged[i,2])==3)
            merged[i,2]<-"Walking_downstairs"
      else if ((merged[i,2])==4)
            merged[i,2]<-"Sitting"
      else if ((merged[i,2])==5)
            merged[i,2]<-"Standing"
      else if ((merged[i,2])==6)
            merged[i,2]<-"Laying"
}

# ==============================================================================
# STEP 4:
# Appropriately labeling the data set with descriptive variable names
# ==============================================================================
features_raw<-read.table("features.txt")
names<-features_raw[vector_small, 2]
names<-as.character(names)
names<-c("Subject", "Activity", names)
colnames(merged)<-names
# ==============================================================================
# STEP 5:
# Creating a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
# ==============================================================================
library(dplyr)
tidynew<-group_by(merged, Activity, Subject)
tidydata<-summarise_each(tidynew, funs(mean))
# STEP 5 b: Changing the variale names
tidy_names<-paste("AVERAGE", names, sep="_")
tidy_names[1]<-"Subject"
tidy_names[2]<-"Activity"
colnames(tidydata)<-tidy_names
write.table(tidydata, "tidydata.txt")
write.table(tidy_names, "tidy_features.txt")

# INSTRUCTIONS TO READ THE RESULTS
# To read the result from tidydata.txt use the read.table command as follows
# reading_tidy<-read.table("tidydata.txt",sep = " ")
# ==============================================================================
# Appendix
# vector_long<-c(1:6, 41:46, 81:86, 121:126, 161:166, 201:206, 227:228, 253:254, 
#              266:271, 294:296, 345:350, 373:375, 424:429, 452:454, 503:504, 
#              516:517, 526, 529:530, 539, 542:543, 552, 555:561)
# ==============================================================================