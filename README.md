The following was done as part of the Coursera.org course "Getting and Cleaning Data"

Data
==================================================================
Data was obtained from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


Adapted from the 
Human Activity Recognition Using Smartphones Dataset
Version 1.0


Original Data Collectors
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

Procedure
==================================================================

The analysis was done using the 'run_analysis.R' script. 

1. 'run_analysis.R' downloads the zip file from the url to ('./data/datafile.zip'), 
2. Unzips the file into ('./UCI HAR Dataset/'). 
3. The test and training data were merged first ('X_train' and 'X_test', 'y_train' and 'y_test', 'subject_train.txt' and 'subject_test.txt')
4. The activities were labled using the provided descriptions from 'activity_labels.txt'. 
5. The features were labled using the provided descriptions from 'features.txt'
6. Then the labled datasets were merged to combine the 'SubjectNumber' ('subject_'), 'activity_name' ('y_'), measured data ('X_') in the variable 'df1'.
7. This data was then reduced to only contain those values from the feature vector that describe the mean ('mean()') and standard deviation('std()') of the following 33 measurements from the original analysis (66 total and 2 labeling SubjectNumber and activity_name). 
  ## (1-3) tBodyAcc-XYZ, (4-6) tGravityAcc-XYZ, (7-9)tBodyAccJerk-XYZ,
  ## (10-12) tBodyGyro-XYZ, (13-15) tBodyGyroJerk-XYZ, (16) tBodyAccMag, 
  ## (17) tGravityAccMag, (18) tBodyAccJerkMag, (19) tBodyGyroMag, 
  ## (20) tBodyGyroJerkMag, (21-23) fBodyAcc-XYZ, (24-26) fBodyAccJerk-XYZ
  ## (27-29) fBodyGyro-XYZ, (30) fBodyAccMag, (31) fBodyAccJerkMag
  ## (32) fBodyGyroMag, (33) fBodyGyroJerkMag
8. The reduced dataset was then further reduced to a dataset of the averages of the mean() and std() of each of these values for each activity(6) and each subject (30) - resulting in a tidydata set (180 rows (6 activities x 30 subjects), 68 columns).
9. The tidy dataset is then stored in './data/tinydata.txt' 







