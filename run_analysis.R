#download the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Data.zip", mode = "wb")
#unzip the data
unzip(zipfile="./data/Data.zip", exdir="./data")
#find the unzipped data in the directory, it's a file folder called "UCI HAR Dataset"
#read the README.txt, from X_train.txt and X_test.txt I'll have the traing and test result of each observation.
#subject_train.txt and subject_test.txt have infomation about the subjects being traning and tested.
#and the labels related to activities are activity_labels.txt. 
#In order to merge taining and test data into one data set. 
#I would have to merge the same kind of variables first.
#Then merge the varibles togther.
#But firstly, read these related txt files into R to see what they are like.
TrainSet <- read.table(file.path("./data/UCI HAR Dataset/train", "X_train.txt"))
TestSet <- read.table(file.path("./data/UCI HAR Dataset/test", "X_test.txt"))
TrainLabels <- read.table(file.path("./data/UCI HAR Dataset/train", "y_train.txt"))
TestLabels <- read.table(file.path("./data/UCI HAR Dataset/test", "y_test.txt"))
SubjectTrain <- read.table(file.path("./data/UCI HAR Dataset/train", "subject_train.txt"))
SubjectTest <- read.table(file.path("./data/UCI HAR Dataset/test", "subject_test.txt"))
Features <- read.table(file.path("./data/UCI HAR Dataset", "features.txt"))
ActivityLabels <- read.table(file.path("./data/UCI HAR Dataset", "activity_labels.txt"))
#see the structures of the data sets.
str(TrainSet)
str(TestSet)
str(TrainLabels)
str(TestLabels)
str(SubjectTrain)
str(SubjectTest)
str(Features)
str(ActivityLabels)
#Merge the data tables to create one data set.
DataSet <- rbind(
       cbind(SubjectTrain, TrainSet, TrainLabels),
       cbind(SubjectTest, TestSet, TestLabels)
    )
head(DataSet)
#change column names to be more accecible.
featuresname <- as.character(Features$V2)
colnames(DataSet) <- c("subject", "activity", featuresname)
#Extracts only the measurements on the mean and standard deviation for each measurement.
#That is to find column names which is features that have names including mean and std.
featureswanted <- Features$V2[grep("mean\\(\\)|std\\(\\)", Features$V2)]
featureswantednames <- as.character(featureswanted)
# And subset the data set with these columns only
SubData <- subset(DataSet, select = c("subject", "activity", featureswantednames))
str(SubData)
#Use descriptive activity names to name the activities in the data set
SubData$activity <- factor(SubData$activity, 
                       levels = ActivityLabels[, 1], labels = ActivityLabels[, 2])
head(SubData$activity,10)
#Appropriately label the data set with descriptive variable names
#prefix t is replaced by time
#Acc is replaced by Accelerometer
#Gyro is replaced by Gyroscope
#prefix f is replaced by frequency
#Mag is replaced by Magnitude
#BodyBody is replaced by Body
names(SubData)<-gsub("^t", "time", names(SubData))
names(SubData)<-gsub("^f", "frequency", names(SubData))
names(SubData)<-gsub("Acc", "Accelerometer", names(SubData))
names(SubData)<-gsub("Gyro", "Gyroscope", names(SubData))
names(SubData)<-gsub("Mag", "Magnitude", names(SubData))
names(SubData)<-gsub("BodyBody", "Body", names(SubData))
str(SubData)
# creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
meltSubData <- melt(SubData, id = c("subject", "activity"))
Data2 <- dcast(meltSubData, subject + activity ~ variable, mean) 
str(Data2)
write.table(Data2, file = "tidydata.txt", row.name=FALSE)
