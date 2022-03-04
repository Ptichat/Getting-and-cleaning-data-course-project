library(dplyr)
subject_training = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
subject_test = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
features = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
activity_labels = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
training_set = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
training_labels = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
test_set = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
test_labels = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")

colnames(test_set) <- features$V2
colnames(training_set) <- features$V2

# Uses descriptive activity names to name the activities in the data set

test_activity <- merge(test_labels, activity_labels, by="V1", sort = FALSE, all.x = TRUE)
colnames(test_activity) <- c("activity label","activity")
training_activity = merge(training_labels, activity_labels, by="V1", sort = FALSE, all.x = TRUE)
colnames(training_activity) <- c("activity label","activity")
colnames(subject_test) <- "subject"
colnames(subject_training) <- "subject"
test_set <- bind_cols(set = "test", test_set)
training_set <- bind_cols(set = "training", training_set)
test <- bind_cols(subject_test, test_activity, test_set)
training <- bind_cols(subject_training, training_activity, training_set)

# Merges the training and the test sets to create one data set.

data <- bind_rows(test, training)
data$V1 = NULL
data$`activity label` = NULL

# Extracts only the measurements on the mean and standard deviation for each measurement.

selected_data <- select(data, subject:set, contains("mean(")|contains("std("))

# Appropriately labels the data set with descriptive variable names

names(selected_data)<-gsub("Acc", " Accelerometer ", names(selected_data))
names(selected_data)<-gsub("Gyro", " Gyroscope ", names(selected_data))
names(selected_data)<-gsub("BodyBody", " Body ", names(selected_data))
names(selected_data)<-gsub("Mag", " Magnitude ", names(selected_data))
names(selected_data)<-gsub("^t", " Time ", names(selected_data))
names(selected_data)<-gsub("^f", " Frequency ", names(selected_data))
names(selected_data)<-gsub("tBody", " Time Body ", names(selected_data))
names(selected_data)<-gsub("-mean()", " Mean ", names(selected_data), ignore.case = TRUE)
names(selected_data)<-gsub("-std()", " Standard Deviation ", names(selected_data), ignore.case = TRUE)
names(selected_data)<-gsub("-freq()", " Frequency ", names(selected_data), ignore.case = TRUE)
names(selected_data)<-gsub("angle", " Angle ", names(selected_data))
names(selected_data)<-gsub("gravity", " Gravity ", names(selected_data))

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

selected_data$subject <- as.factor(selected_data$subject)
tidy_data <- aggregate(. ~subject + activity + set, selected_data, mean)
tidy_data <- tidy_data[order(tidy_data$subject,tidy_data$activity),]
write.table(tidy_data, file = "Tidy.txt", row.names = FALSE)