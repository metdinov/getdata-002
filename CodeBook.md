# Getting and Cleaning Data Project
======================================

## Codebook

The dataset gathers sensor signals (accelerometer and gyroscope) taken from a group of 30 volunteers within an age bracket of 19-48 years.

### Variables

* ID - 30 levels (one for each volunteer)
* Activity - 6 levels
	1. WALKING
	2. WALKING_UPSTAIRS
	3. WALKING_DOWNSTAIRS
	4. SITTING
	5. STANDING
	6. LAYING
* Sensor Signals - 561-feature vector with time and frequency domain variables.

### Processing/Cleaning

The test and training sets (files [X_test.txt] and [X_train.txt] respectively) were loaded and then merged together into one data frame. Then labeled appropriately using the labels in [features.txt].
We then extracted only the measurements on the mean and standard deviation for each measurement.
Next we added the activity data, and labeled it properly using the labels from [activity_labels.txt]. Then we merged the subject train and test data sets (from [subject_train.txt] and [subject_test.txt], and added them to out tidy data set.
Finally, we created a new dataset by reshaping the data set using the reshape2 package, calculating the mean of each variable for each activity and each subject.