# It is assumed that the Samsung data is extracted to the working directory.
# If the text files are directly saved in the working directory please keep only the,
# text file name in the read.csv  command

# The follwing codes reades in the values of the 561 variables during training and testing
 # and combines it into a single dataframe of 10299 observations of 561 variables

Xtrain <-
  read.csv("./UCI HAR Dataset/train/X_train.txt",
           header = FALSE,
           sep = "")
Xtest <-
  read.csv("./UCI HAR Dataset/test/X_test.txt",
           header = FALSE,
           sep = "")
Xcomb <- rbind(Xtrain, Xtest)

# The following codes reads in the activity code corresponding to each set of values of, 
# the 561 variables during test and training and combines it into a single dataframe of,
# 10299 observations of 1 variable

Ytrain <-
  read.csv("./UCI HAR Dataset/train/Y_train.txt",
           header = FALSE,
           sep = "")
Ytest <-
  read.csv("./UCI HAR Dataset/test/Y_test.txt",
           header = FALSE,
           sep = "")
Ycomb <- rbind(Ytrain, Ytest)

# The  following codes reads in the details of the participant who performed the activity,
# during training and testing and combines it into a single dataframe of 10299 observations,
# of 1 variable.

Subtrain <-
  read.csv("./UCI HAR Dataset/train/subject_train.txt",
           header = FALSE,
           sep = "")
Subtest <-
  read.csv("./UCI HAR Dataset/test/subject_test.txt",
           header = FALSE,
           sep = "")
Subject <- rbind(Subtrain, Subtest)

# The follwing code reads in the variable names from the features file and assignes these,
# as column names of the Xcomb dataframe.

features <-
  read.csv("./UCI HAR Dataset/features.txt",
           header = FALSE,
           sep = "")
names(Xcomb) <- features[, 2]

# Extracting only  the mean and standard deviation for each of  the measurements variables,
# starting with "t".Fourier transformations variables starting with "f" are not direct, 
# measurements and hence ignored.

Xcomb <-
  Xcomb[grepl("mean|std",names(Xcomb))]

# Reading in the description of activity from activity label and replacing activity codes
# in Ycomb dataframe with activity description.

activity <-
  read.csv("./UCI HAR Dataset/activity_labels.txt",
           header = FALSE,
           sep = "")

library(plyr) # for join function

Ycomb <- join(Ycomb, activity)

Activity <- factor(Ycomb$V2,levels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

#combining the activity , participant details and the values of measurement variable, 
# with mean and std to a single dataframe

Dataset1 <- cbind(Activity, Subject, Xcomb)

# Providing appropriate names to the newly added columns

names(Dataset1)[1:2] <- c("Activity", "Subject")

library(dplyr) # for group_by and summarise functions

# creates a second, independent tidy data set with the average of each variable for 
# each activity and each subject.

Dataset2 <-
  Dataset1 %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))

write.table(Dataset2, "tidydata.txt", row.names = FALSE)