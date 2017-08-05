# HARanalysis

The script works in the following steps:

i) Read the feature names from the file "features.txt"
ii) Read the training data from the file "train/X_train.txt", and use the feature names as column names.
iii) Process the names by removing extra unwanted characters and capitalizing the first letter of each word.
iv) Read in the subject numbers from the file "train/subject_train.txt", and add these to the table.
v) Read in activity numbers from the file "train/y_train.txt", convert them to activity names and add to table.
vi) Follow similar steps for the test data, and join together the training and test data.
vii) Restrict the features to only those that contain a mean or standard deviation measurement, using regex.
viii) Create a table of averages by splitting the above table with respect to each activity and each subject.
ix) Write the table to a text file
