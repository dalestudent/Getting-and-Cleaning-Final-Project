## This project must complete the following tasks
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

# When reading in the features, leave out the sep argument so that it treats one or more whitespace characters
#  as a single delimiter. This is required because some of the features have double spaces between them.

# Read in activity and feature labels
activity.labels <- read.table("activity_labels.txt", col.names = c("activityid", "activity"))
dataset.names <- read.table("features.txt", col.names = c("featureid", "feature"))

# Read in training data
train.subject <- read.table("train/subject_train.txt", col.names = "subjectid")
train.activity <- read.table("train/y_train.txt", sep = " ", col.names = "activityid")

# To satisfy item 3 from above, merge the activity labels into the observations
# Merge the activity labels in
train.activity <- merge(train.activity, activity.labels, sort = FALSE)
# To satisfy item 4 from above, feed in the feature names to the col.names parameter
train.data <- read.table("train/x_train.txt", col.names = dataset.names$feature)

# To satisfy item 2 from above
# Filter the train.data features to only those that have std() or mean()
train.data.filtered <- train.data[, grepl("std()|mean()", names(train.data))]

# Merge the columns from the 3 training sets together
train.data.set <- cbind(train.subject, train.activity, train.data.filtered)

# Read in test data
test.subject <- read.table("test/subject_test.txt", sep = " ", col.names = "subjectid")
test.activity <- read.table("test/y_test.txt", sep = " ", col.names = "activityid")

# To satisfy item 3 from above, merge the activity labels into the observations
# Merge the activity labels in
test.activity <- merge(test.activity, activity.labels, sort = FALSE)

# To satisfy item 4 from above, feed in the feature names to the col.names parameter
test.data <- read.table("test/x_test.txt", col.names = dataset.names$feature)

# To satisfy item 2 from above
# Filter the train.data features to only those that have std() or mean()
test.data.filtered <- test.data[, grepl("std()|mean()", names(test.data))]

# Merge the columns from the 3 training sets together
test.data.set <- cbind(test.subject, test.activity, test.data.filtered)

# To satisfy item 1 from above
# Merge the test and training data sets together
full.data.set <- rbind(train.data.set, test.data.set)

# To satisfy item 5 from above, use dplyr to summarize the data
# Finally, return another tidy dataset that provides the averages for each variable by subjectid and activity
summary.data.set <- full.data.set %>% group_by(subjectid, activity) %>% summarize_each(funs(mean))

# Output the summary data set to a text file
write.table(summary.data.set, row.names = FALSE, file = "summary_data_set.txt")
