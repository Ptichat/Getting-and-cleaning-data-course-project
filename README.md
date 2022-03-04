# Getting-and-cleaning-data-course-project

The data is loaded in R, with the names:
subject_training/test - the subject that are part of the training/test sets.
features - a tidy list of the mesured features for each row.
activity_labels = an correspondance of the activities and their labels.
training/test_set - the measures for the training/test sets.
training/test_labels - a tidy list of the activities done by the subjects.

We put the features names as columns names of the test and training sets of data.
Then, we add a "set" column to the training and test sets, with the redondant word "training" or "test", to know for every row if it is a test or a training data row.
We add to the measures data sets the subject and the activity name of each row.

We merge the training and the test sets to create one data set.

We extract only the columns of the measurements on the mean and standard deviation for each measurement.

We change the columns names for descriptive variable names.

And finally, we creates a second dataframe, that is a tidy data set with the average of each variable for each activity and each subject, and we out it in a .txt file.
