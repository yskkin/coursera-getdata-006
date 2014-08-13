#
# 1. Merges the training and the test sets to create one data set.
#
data_dir <- "UCI HAR Dataset/"

features <- read.table(paste(data_dir, "features.txt", sep = ""), stringsAsFactors=FALSE)[,2]

test.X <- read.table(paste(data_dir, "test/X_test.txt", sep = ""), col.names = features, check.names = FALSE)
test.y <- read.table(paste(data_dir, "test/y_test.txt", sep = ""), col.names = "Activity")
test.subject <- read.table(paste(data_dir, "test/subject_test.txt", sep = ""), col.names = "Subject")
train.X <- read.table(paste(data_dir, "train/X_train.txt", sep = ""), col.names = features, check.names = FALSE)
train.y <- read.table(paste(data_dir, "train/y_train.txt", sep = ""), col.names = "Activity")
train.subject <- read.table(paste(data_dir, "train/subject_train.txt", sep = ""), col.names = "Subject")

test <- cbind(test.X, test.y, test.subject)
train <- cbind(train.X, train.y, train.subject)
data <- rbind(test, train)

#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#
keep <- grep("(mean\\(\\)|std\\(\\)|Activity|Subject)", names(data))
data <- data[,keep]

#
# 3. Uses descriptive activity names to name the activities in the data set
#
activity_labels <- read.table(paste(data_dir, "activity_labels.txt", sep = ""), col.names = c("Activity", "ActivityName"))
data <- merge(data, activity_labels)
data <- data[,(names(data) != "Activity")]
colnames(data)[colnames(data) == 'ActivityName'] <- 'Activity'

# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 