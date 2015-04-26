Specific project requirements:

You should create one R script called run_analysis.R that does the following.   
1.  Merges the training and the test sets to create one data set.  
2.  Extracts only the measurements on the mean and standard deviation for each measurement.   
3.  Uses descriptive activity names to name the activities in the data set  
4.  Appropriately labels the data set with descriptive variable names.   
5.  From the data set in step 4, creates a second, independent tidy data set with  
the average of each variable for each activity and each subject.  

Raw data was gathered from the UCI data set.  

The overall flow of the script is:  
	* read in the neeeded text files into data frames  
		+ activitydesc - conatins the activity ID's and descriptions  
		+ datacolnames - contains the column names from features.txt  
		+ testlabels / trainlabels - activities for data set  
		+ testsubjects / trainsubjects - subjects for data set  
		+ testdata / traindata - raw data  
	* set the column names using datacolnames df (REQUIREMENT #4)  
	* Combine the labels & subject with the data  
	* merge the test and train data using rbind (REQUIREMENT #1)  
	* subset the columns with mean() & std() into new dataframe and include the activity and subject columns (REQUIREMENT #2)  
	* use merge function to get the activity names into the data set (REQUIREMENT #3)  
	* use the dplyr group_by and summarize_each functions to produce the tidy data set (REQUIREMENT #5)  
  
The pertinent dataframes that are created during the process are:  
	* alldata - the combination of the train and test data with appropriate column names  
	* subsetdata - only the columns that contain mean() or std(), along with the subject and activity  
	* mydata - grouped data on activity and subject  
	* tidy1 - final result with means of all included variables  
