#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean 
#and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set
#with the average of each variable for each activity and each subject.

getwd()
setwd("./datasciencecoursera")
#Read in the data

#features and its names
features <- read.table(
    "datasets/UCI/features.txt",
    col.names = c("feature_number", "feature_name")
)
#activities and its names
activities <- read.table(
    "datasets/UCI/activity_labels.txt",
    col.names = c("activity_code", "activity")
)

#21 subjects in train set
#9 in test set
#561 features in features set
#6 activities in activities set

# y is for activity labels for test and train sets
# x is for features
# subject is for subject numbers, test and train


#read in subject numbers from test set
subject_test <- read.table(
    "datasets/UCI/test/subject_test.txt",
    col.names = "subject"
)

#read in subject numbers from train set
subject_train <- read.table(
    "datasets/UCI/train/subject_train.txt",
    col.names = "subject"
)

#read in test set and label each column with feature names
x_test <- read.table(
    "datasets/UCI/test/X_test.txt",
    col.names = features$feature_name
)

#read in train set and label each column with feature names
x_train <- read.table(
    "datasets/UCI/train/X_train.txt",
    col.names = features$feature_name
)


#read in activity numbers
y_test <- read.table(
    "datasets/UCI/test/y_test.txt",
    col.names = "activity_code"
)

#read in the labels for the train set
y_train <- read.table(
    "datasets/UCI/train/y_train.txt",
    col.names = "activity_code"
)

#merge the activity numbers with the activity names
y_test1 <- merge(y_test, activities, by = "activity_code", sort = FALSE)
y_train1 <- merge(y_train, activities, by = "activity_code", sort = FALSE)

#for test set, add subject numbers
x_test <- cbind(subject_test, x_test)
#for train set, add subject numbers
x_train <- cbind(subject_train, x_train)

#now add the activity names to the data
x_test2 <- cbind(y_test1, x_test)
x_train2 <- cbind(y_train1, x_train)

#merge the train and test sets
allsubjects <- rbind(x_train2, x_test2)
write.csv(allsubjects, "datasets/UCI/allsubjects.csv", row.names = FALSE)

#write a regex to select only the mean and standard deviation
#features
mean_std_features <- grep("mean|std", features$feature_name, value = FALSE)
#mean_std_features+3

#select only the mean and standard deviation features
mean_std_data <- allsubjects[, c(1, 2, 3, (mean_std_features+3))]
#mean_std_data

#create second tidy dataset

tidy_data1 <- mean_std_data  %>% 
    group_by(subject, activity) %>%
    summarise_at( .vars = names(.)[4:ncol(mean_std_data)], .funs = mean)

View(tidy_data1)
write.csv(tidy_data1, "datasets/UCI/tidy_data.csv", row.names = FALSE)
