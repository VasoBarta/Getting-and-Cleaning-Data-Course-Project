This Code Book describes the variables, the data, and any transformations or work that I performed to clean up the data in line with the assignment instructions.

The dataset which is subject of this assignment contains accelerometer and gyroscope data from smartphones weared by 30 persons (subjects) while performing six various activities.
There are two datasets: training data and test data. These were obtained by random partitioning of the subjects - 70% of the volunteers was selected for generating the training data and 30% the test data.

Information on the dataset can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source file is located here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It contains number of files.
Both, test and training data have the same file structure. For training data, the relevant files are:<br/>
<strong>X_train.txt</strong> - contains the accelerometer and gyroscope data - 561 variables (columns), each row representing a record of measurements for a combination of a subject and an activity. There are 7352 observations (rows).
However, the file does not contain the identification of subjects and activities.<br/>
<strong>y_train.txt</strong> - contains only one variable - <strong>activity ID</strong> for each observation in X_train.txt, thus there are 7352 rows in this file as well.<br/>
<strong>subject_train.txt</strong> - contains only one variable - <strong>subject ID</strong> for each observation in X_train.txt, thus there are 7352 rows in this file as well.

For test data, there are X_test.txt, y_test.txt, and subject_test.txt files with the same logic.

Then there are two files that are common for the training and test data:<br/>
<strong>feature.txt</strong> - contains descriptive labels of the variables which are in X_train / X_test files. feature.txt thus contains 561 rows and two variables - feature (measurement) ID and its descriptive name.<br/>
<strong>activity_labels.txt</strong> - contains descriptive lables of the activities performed by subjects (6 rows and 2 variables).

Steps as performed by the script:

1. First part of the script downloads the data, unpacks it, and installs and loads all necessary packages.

2. Then all relevant files, as described above, are read into dataframes for further work.

3. Variables in all dataframes are given descriptive names, for better orientation and referencing.
