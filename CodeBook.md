


The script *run_analysis.R* performs all the steps required to prepare the data, following the intructions given. 

## 1. Download and decompress
Original file: Coursera_DS3_Final.zip
Decompressed folder: UCI HAR Dataset

## 2. Reading individual files 
-features.txt (features) : 561 rows, 2 columns (n, function)
All the variables from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

- activity_labels.txt (activities) : 6 rows, 2 columns (code, activity).
Labels for the respective code. 

- test/subject_test.txt (testSubjects) : 2947 rows, 1 columns. 
9/30 volunteer test subjects being observed

- subject_train (trainSubjects) : 7352 rows, 1 column
21/30 volunteer subjects being observed

- test/X_test.txt (Xtest) : 2947 rows, 561 columns
30% of data recorded

- test/y_test.txt (Ytest) : 2947 rows, 1 columns
activities'code labels for the test data

- test/X_train.txt (Ytest): 7352 rows, 561 columns
70% of data recorded

y_train <- test/y_train.txt : 7352 rows, 1 columns
activities'code labels for the training data

## 3. Merging test and training data

Data was merged using the rbind() function. 

XAll = Xtrain + Xtest (10299 rows, 561 columns) 

YAll = Ytrain + Ytest (10299 rows, 1 column)

Allsubjects = trainSubjects + testSubjects (10299 rows, 1 column)

Finally, the dataframes are put together by applying cbind(): 

Alldata = Allsubjects + YAll + XAll (10299 rows, 563 column)

## 4. Extracts only the measurements on the mean and standard deviation for each measurement

The variables that had the words "mean" or "std" on them were selected to create *data_mean_std* dataframe, as well as the subject and the code.  (10299 rows, 88 columns)

## 5. Descriptive names
Some variables are renamed to be more informative. 
The column with the code is changed to have the activity name instead. 

## 6. Tidy data set with the average of each variable for each activity and each subject
 
*newData* is created by sumarizing *data_mean_std* taking the means of each variable for each activity and each subject (180 rows, 88 columns).

Output:  "OrderedData.txt"




