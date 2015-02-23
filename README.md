---
title: "README"
author: "Prashant Athavale"
date: "February 22, 2015"
output: html_document
---
==============================================================================
Coursera project for the course: Getting and Cleaning Data
==============================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities  (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. "Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured."


The project statement requires that the run_analysis.R code should:
1) Merge the training and the test sets to create one data set.
2) Extract only the measurements on the mean and standard deviation for each measurement. 
3) Use descriptive activity names to name the activities in the data set
4) Appropriately label the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

==============================================================================
Methodology for each of the above steps
==============================================================================

STEP 1 and 2: EXTRACTING AND MERGING DATASETS
===============================================
Instead of merging the test set and the training set, and then extracting the mean and the standard deviations, I first extracted required variables using the following commands:

xtest_raw<-read.table("X_test.txt")
vector_small<-c(1:6, 41:46, 121:126)
xtest<-xtest_raw[vector_small]

IMPORTANT: The project clearly asks to "extract only the measurements on the mean and standard deviation for each MEASUREMENT". There are 561 measurements, and the question as to which were measured, as opposed to which were derived from the measured data is upto some interpretation. By carefully reading the features_info.txt, I realized that the only variables which were"MEASURED" were tBodyAcc, tGravityAcc, tBodyGyro. Thus, only the mean, and standard deviations for these variables, in the X, Y, and Z directions were extracted. Thus, there should be 18 measurement variables in the final tidy data. These were extracted using vector_small<-c(1:6, 41:46, 121:126) followed by xtest<-xtest_raw[vector_small]. 

(For a broad interpretation, one can use all the mean, and standard deviations in the original dataset
by replacing vector_small, by vector_long. See the Appendix of the run_analysis.R code.

vector_long<-c(1:6, 41:46, 81:86, 121:126, 161:166, 201:206, 227:228, 253:254, 
              266:271, 294:296, 345:350, 373:375, 424:429, 452:454, 503:504, 
              516:517, 526, 529:530, 539, 542:543, 552, 555:561)
)

Similarly the required variables were extracted from the training set. 

The subject, and activity variables were extracted and combing with the other variables with the cbind command.


The extracted data was merged together using rbind command as follows

merged<-rbind(test_data, train_data)

STEP 3: USING DESCRIPTIVE ACTIVITY NAMES
========================================
In the original dataset the activities were given numbers as follows:
1: Walking
2: Walking_upstairs
3: Walking_downstairs
4: Sitting
5: Standing
6: Laying

The numbers were replaced by the character variables using the if else if loop. 



STEP 4: LABELLING THE VARIABLES:
===============================
The labels names were extracted from the file "features.txt" and the appropriate variable names were extracted using the vector_small vector (or vector_long for the broad interpretation) for subsetting the feature names.


STEP 5: CREATING THE TIDY DATASET OF AVERAGES OF EACH VARIABLE
===============================================================
This could be done by looping over the meager data set. But I used dplyr library to do this using the functions group_by, followed with 
summarise_each(.. , funs(mean))
The result was stored in the variable tidydata, and it was written in tidydata.txt file using 
write.table(tidydata, "tidydata.txt")

INSTRUCTIONS TO READ THE RESULT
=================================
To read the result from tidydata.txt use the read.table command as follows
reading_tidy<-read.table("tidydata.txt",sep = " ")

==============================================================================
The dataset includes the following files:
==============================================================================

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'X_train.txt': Training set.
- y_train.txt': Training labels.
- 'X_test.txt': Test set.
- 'y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


==============================================================================
Reference:
==============================================================================

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

