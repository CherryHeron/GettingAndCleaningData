
This Code Book describes the variables, the data, and the work that I performed to clean up the data

## Data used is downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## STEPS

* download the data, 

* unzip the data,
  find the unzipped data in the directory, it's a file folder called "UCI HAR Dataset".
  
* open the folder, 
  there're another two folders in it, "test" and "train".
  
* read the readme.txt to learnnabout the contents and structures of data.

* The dataset includes the following files:
  - 'README.txt'
  - 'features_info.txt': Shows information about the variables used on the feature vector.
  - 'features.txt': List of all features.
  - 'activity_labels.txt': Links the class labels with their activity name.
  - 'train/X_train.txt': Training set.
  - 'train/y_train.txt': Training labels.
  - 'test/X_test.txt': Test set.
  - 'test/y_test.txt': Test labels.
  for the train and test data, the following descriptions are equivalent:
  -'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
  
* read the data into R
  see the structres

* set them to the variables that will be used.

* merge the same kind of variables first. Then merge the varibles togther.

## Variables

