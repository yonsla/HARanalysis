# HARanalysis

The script works in the following steps:

* Read the feature names from the file "features.txt"
* Read the training data from the file "train/X_train.txt", and use the feature names as column names.
* Process the names by removing extra unwanted characters and capitalizing the first letter of each word.
* Read in the subject numbers from the file "train/subject_train.txt", and add these to the table.
* Read in activity numbers from the file "train/y_train.txt", convert them to activity names and add to table.
* Follow similar steps for the test data, and join together the training and test data.
* Restrict the features to only those that contain a mean or standard deviation measurement, using regex.
* Create a table of averages by splitting the above table with respect to each activity and each subject.
* Write the table to a text file
