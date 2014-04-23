
run_analysis <- function (){
  library(reshape2)
  
  if(!file.exists("./data")){dir.create("./data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="./data/datafile.zip", method="curl")
  
  unzip("./data/datafile.zip")
  
  ##License:
  ##  ========
  ##  Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
  ##
  ##[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
  ##This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
  ##Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
  ##http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
  activity_name <- read.table("UCI HAR Dataset/activity_labels.txt")
  feature_name <- read.table("UCI HAR Dataset/features.txt")
  
  #Subject Data
  train_names <- read.table("UCI HAR Dataset/train/subject_train.txt")
  test_names <- read.table("UCI HAR Dataset/test/subject_test.txt")
  data_names <- rbind(train_names, test_names)
  names(data_names) <- "SubjectNumber"
  
  #Activity Data
  train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
  test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
  data_y <- rbind(train_y,test_y)
  ##Uses descriptive activity names to name the activities in the data set
  ##Appropriately labels the data set with descriptive activity names.
  ##(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
  data_y <-activity_name[data_y[,1],2]
  
  #Data X
  train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
  test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
  data_x <- rbind(train_x, test_x)
  names(data_x) <- feature_name[,2]
  
  ##Merges the training and the test sets to create one data set.
  
  df1 <- cbind(data_names, activity_name = data_y, data_x)
  
  ##Extracts only the measurements on the mean and standard deviation for each measurement. 
  ## (1-3) tBodyAcc-XYZ, (4-6) tGravityAcc-XYZ, (7-9)tBodyAccJerk-XYZ,
  ## (10-12) tBodyGyro-XYZ, (13-15) tBodyGyroJerk-XYZ, (16) tBodyAccMag, 
  ## (17) tGravityAccMag, (18) tBodyAccJerkMag, (19) tBodyGyroMag, 
  ## (20) tBodyGyroJerkMag, (21-23) fBodyAcc-XYZ, (24-26) fBodyAccJerk-XYZ
  ## (27-29) fBodyGyro-XYZ, (30) fBodyAccMag, (31) fBodyAccJerkMag
  ## (32) fBodyGyroMag, (33) fBodyGyroJerkMag
  
  featureNameMean<-grep("mean()", names(df1), fixed = TRUE)
  featureNameStd<-grep("std()", names(df1), fixed = TRUE)
  data_trimmed<- cbind(data_names, activity_name = data_y, 
                       df1[,featureNameMean],  df1[,featureNameStd])
  
  ##Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
  
  test<- melt(data_trimmed, id = c("SubjectNumber", "activity_name"), 
              measure.vars = names(data_trimmed[3:68]) )
  test2 <-dcast(test, SubjectNumber + activity_name ~ variable, mean)
  write.table(test2, file = "./data/tidydata.txt")
}