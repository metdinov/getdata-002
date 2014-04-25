## 
## Getting and Cleaning Data
## Peer Assesment Project
## ==========================================
## 
## Download dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## IMPORTANT: The script should be placed in your working directory and the dataset extracted there too.
##

# Load the training and test data sets
trainData <- read.table("UCI HAR Dataset/train/X_train.txt", colClasses = 'numeric')
testData <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses = 'numeric')

# Merge the two data sets
tidyData <- rbind(trainData, testData)

# Remove test and train objects from memory
rm(trainData)
rm(testData)

# Label columns
features <- read.table('UCI HAR Dataset/features.txt', col.names = c('ID', 'Name'), stringsAsFactors = FALSE)
colnames(tidyData) <- features$Name

# Extracting the mean and std of the measurements
meanAndStd <- grepl( "mean|std", features$Name)
tidyData <- subset(tidyData, select = features$Name[meanAndStd])

# Load the activity data sets
activityTrainData <- read.table("UCI HAR Dataset/train/y_train.txt", colClasses = 'numeric')
activityTestData <- read.table("UCI HAR Dataset/test/y_test.txt", colClasses = 'numeric')

# Merge the two data sets
tidyActivityData <- rbind(activityTrainData, activityTestData)
colnames(tidyActivityData) <- 'Activity'

# Remove activity test and train objects from memory
rm(activityTrainData)
rm(activityTestData)

# Replace numbers with activity names
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c('ID', 'Name'), stringsAsFactors = FALSE)
for (id in activities$ID) {
	tidyActivityData[tidyActivityData == id] <- activities$Name[id]
}

# Merge tidyData and activity data set
tidyData <- cbind(tidyActivityData, tidyData)
rm(tidyActivityData)

# Load subject IDs
subjectTrainData <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "ID")
subjectTestData <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "ID")

# Merge the two data sets
tidySubjectData <- rbind(subjectTrainData, subjectTestData)

# Remove subject data sets from memory
rm(subjectTrainData)
rm(subjectTestData)

tidyData <- cbind(tidySubjectData, tidyData)

## Uncomment next line to save a csv file with the tidy data set we just created.
# write.csv(tidyData, file='tidyData.csv')

# Create a new data set with the average of each variable for each activity and each subject. 
require(reshape2)

meltedData <- melt(tidyData, id.vars=c("ID", "Activity"))
tidyData2 <- dcast(meltedData, ID + Activity ~ variable, mean)
colnames(tidyData2)[3] <- 'Average'

## Uncomment next line to save a csv file with the new tidy data set we just created.
# write.csv(tidyData2, file='tidyData2.csv')