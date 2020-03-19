library(plyr)

## Import "features", activity labels, and raw data from source files

features <- read.table("./UCI HAR Dataset/features.txt")

activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

subjectIdTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
activityTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
measurementTest <- read.table("./UCI HAR Dataset/test/X_test.txt")

subjectIdTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
activityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
measurementTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")

## Merge all data into a single data frame 

# Join the data into single data frames for each of the (sets of) variables
subjectId <- rbind(subjectIdTest, subjectIdTrain)
activity <- rbind(activityTest, activityTrain)
measurement <- rbind(measurementTest, measurementTrain)

names(subjectId) <- "subjectId"
names(activity) <- "activity"
names(measurement) <- features[,2]

# True/False vector, with True indicating a measurement column/variable name containing
# "-mean(" or "-std("
subsetInd <- grepl("-mean\\(|-std\\(", names(measurement))
measurement <- measurement[,subsetInd]

data <- cbind(subjectId, activity, measurement)

## Convert numbers to activity names; sort by subjectId and then activity name

nAct <- dim(activityLabels)[1]
data[,"activity"] <- as.factor(data[,"activity"])
for(i in 1:nAct){
      data[,"activity"] <- 
            gsub(activityLabels[i,1], activityLabels[i,2], data[,"activity"])
}

# Memory cleanup
rm(activity, activityLabels, activityTest, activityTrain, features, 
   measurement, measurementTest, measurementTrain, subjectId, subjectIdTest, subjectIdTrain)

data <- arrange(data, subjectId, activity)

## Generate tidy data set containing means (per subject and per activity); save dataset

meanData <- aggregate(data[,-(1:2)], by=list(data$subjectId, data$activity), FUN=mean)
names(meanData)[1:2] <- c("subjectId", "activity")

meanData <- arrange(meanData, subjectId, activity)

#write.csv(meanData, "./mean-data-tidy.csv")
write.table(meanData, file="./mean-data-tidy.txt", row.name=FALSE)