

library(dplyr)

####PROJECT 
setwd("C:\\Users\\danie\\Documents\\data_science_spe\\GettingData")

filename <- "Coursera_DS3_Final.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

unzip(zipfile="Coursera_DS3_Final.zip")


## Reading all individual files to be used in the analysis

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "act"))

testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

Xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

Ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

Ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


XAll <- rbind(Xtrain, Xtest)
YAll <- rbind(Ytrain, Ytest)

Allsubjects <- rbind(trainSubjects, testSubjects)
Alldata <- cbind(Allsubjects, YAll, XAll)

### Cmaiar los codigospor los nmbers de la actividad
Alldata$code <- activities[Alldata$code, 2]

data_mean_std <- Alldata %>% select(subject, code, contains("mean"), contains("std"))

names(data_mean_std)[2] = "activity"
names(data_mean_std)<-gsub("Acc", "Accelerometer", names(data_mean_std))
names(data_mean_std)<-gsub("Gyro", "Gyroscope", names(data_mean_std))
names(data_mean_std)<-gsub("BodyBody", "Body", names(data_mean_std))
names(data_mean_std)<-gsub("Mag", "Magnitude", names(data_mean_std))
names(data_mean_std)<-gsub("^t", "Time", names(data_mean_std))
names(data_mean_std)<-gsub("^f", "Frequency", names(data_mean_std))
names(data_mean_std)<-gsub("-freq()", "Frequency", names(data_mean_std), ignore.case = TRUE)
names(data_mean_std)<-gsub("tBody", "TimeBody", names(data_mean_std))
names(data_mean_std)<-gsub("-mean()", "Mean", names(data_mean_std), ignore.case = TRUE)
names(data_mean_std)<-gsub("-std()", "StandardDev", names(data_mean_std), ignore.case = TRUE)
names(data_mean_std)<-gsub("angle", "Angle", names(data_mean_std))
names(data_mean_std)<-gsub("gravity", "Gravity", names(data_mean_std))



newData <- data_mean_std %>% group_by(subject, activity) %>% summarise_all(funs(mean))


write.table(newData, file = "OrderedData.txt",row.name=FALSE)
