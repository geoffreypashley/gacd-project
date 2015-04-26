# Requiremnts:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
library(tidyr)

activitydesc <- read.table("activity_labels.txt",col.names=c("activity","activitydesc"))
datacolnames <- read.table("features.txt",col.names=c("position","name"))

# read test labels and train labels
testlabels <- read.table("./test/y_test.txt",col.names=c("activity"))
trainlabels <- read.table("./train/y_train.txt",col.names=c("activity"))
testsubjects <- read.table("./test/subject_test.txt",col.names=c("subject"))
trainsubjects <- read.table("./train/subject_train.txt",col.names=c("subject"))

# read in the test and train data
testdata <- read.table("./test/X_test.txt")
traindata <- read.table("./train/X_train.txt")
# Requirement 4 - descriptive variable names
names(testdata) <- datacolnames$name
names(traindata) <- datacolnames$name

# cbind the activity columns to the data sets
testdata <- cbind(testdata, testlabels,testsubjects)
traindata <- cbind(traindata, trainlabels,trainsubjects)
# Requirement 1 - merge the test and train data sets
alldata <- rbind(testdata, traindata)

# subset the columns with mean() & std() into new df
# there's a better way to do this with dplyr...
meandata <- alldata[,grep('mean()',datacolnames$name,fixed=TRUE)]
stddata <- alldata[,grep('std()',datacolnames$name,fixed=TRUE)]
actdata <- subset(alldata, select=c("activity","subject"))

# combine the df's along with the activity column
subsetdata <- cbind(meandata, stddata, actdata)
mydata <- merge(activitydesc,subsetdata,all=TRUE)
mydata <- tbl_df(mydata)
#tidy1 <- group_by(mydata,activitydesc,subject)
tidy1 <- mydata %>% 
  group_by(activitydesc,subject) %>% 
  summarise_each(funs(mean))
write.table(tidy1, file="tidy1.txt", row.names=FALSE)
