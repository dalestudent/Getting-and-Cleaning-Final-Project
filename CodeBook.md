# CodeBook
This project has shared source files in the root of the repo.
Training data is in a folder called train and test data is in a folder called test.

Initially, the activity lookup data and feature names are read into dataframes with column names specified.
Then, for the train and test data, the activity, subject, and feature data are read in to separate dataframes.
Since these are text files with whitespace as their separator, read.table is used.
The features dataframe is used to provide descriptive column names for the main data dataframe.

To sync up the activity labels with the observations, the merge function is used, making sure to not sort the data.

After the main data is read in, the grepl function is used to limit the columns to just those that have either std or mean in their names.

Then the training activity, subject, and filtered data columns are merged with cbind. The same is done with the test data.

Next, the training and test dataframes are merged.

Finally, the dplyr library is used to group by observations by subject and activity and return the mean of each feature. This dataframe is written out to the text file summary_data_set.txt

# Variables
Shared Data
activity.labels <- The activity ID and description for each activity
dataset.names <- The feature names for the main datasets

Separate Data
train.subject, test.subject <- The subject associated with each observation
train.activity, test.activity <- The activity associated with each observation
train.data, test.data <- The values for each observation
train.data.filtered, test.data.filtered <- The values for each observation that have either std or mean in them
train.data.set, test.data.set <- All of the values for each observation in a single dataframe

Joined Data
full.data.set <- The train and test data combined into a single dataframe
summary.data.set <- Summarized data by subject and activity
