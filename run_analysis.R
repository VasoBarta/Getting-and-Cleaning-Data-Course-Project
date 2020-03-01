# Download file and Unzip file
if (!file.exists("./UCI HAR Dataset")){
    destFile <- "getdata_projectfiles_UCI HAR Dataset.zip"
    if (!file.exists(destFile)){
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = destFile, mode='wb')
    }
    unzip(destFile)
}
# install and load required packages
if (!require("dplyr", character.only = TRUE)) {
    install.packages("dplyr", dependencies = TRUE)
    library("dplyr", character.only = TRUE)
}
# Set working directory
setwd("./UCI HAR Dataset")

# Prep. step 1. Read all relevant tables ---
xtrain <- read.table("train/X_train.txt") # TRAINING data
ytrain <- read.table("train/y_train.txt") # activity IDs for TRAINING data
subjtrain <- read.table("train/subject_train.txt") # subject IDs for TRAINING data

xtest <- read.table("test/X_test.txt") # TEST data
ytest <- read.table("test/y_test.txt") # activity IDs for TEST data
subjtest <- read.table("test/subject_test.txt") # subject IDs for TEST data

feat <- read.table("features.txt") # variable names
actLabels <- read.table("activity_labels.txt") # list of activities - IDs and labels

# Prep. step 2. For easier orientation, label the column names ---
colnames(xtrain) <- feat[,2]
colnames(ytrain) <- "actID"
colnames(subjtrain) <- "subjID"

colnames(xtest) <- feat[,2]
colnames(ytest) <- "actID"
colnames(subjtest) <- "subjID"

colnames(actLabels) <- c("actID","actType")

# Tasks
# 1. Merge the training and the test sets to create one data set ---
merged_train <- cbind(xtrain,ytrain,subjtrain) # merging TRAINING data (adding
                                               # activity IDs and subject IDs to
                                               # the training dataset)
merged_test <- cbind(xtest,ytest,subjtest) # merging TEST data
mergedAll <- rbind(merged_train,merged_test) # merging training and test data together

# 2. Extract only the measurements on the mean and standard deviation ---
columns <- colnames(mergedAll)
onlyMeansandStd <- mergedAll[,grep("mean\\(\\)|std\\(\\)|actID|subjID",columns,ignore.case = TRUE)]

# 3. Use descriptive activity names to name the activities in the data set ---
onlyMeansandStd_lbl <- merge(onlyMeansandStd,actLabels,by="actID",all.x = TRUE)

# 4. Appropriately label the data set with descriptive variable names ---
    # -> already done within Prep. step 2., when naming the columns based on the 'feat' dataframe

# 5. From the data set in step 4, create a second, independent tidy data set
#    with the average of each variable for each activity and each subject
dataSum <- onlyMeansandStd_lbl %>% group_by(actType,subjID) %>% summarize_all(mean)

# --- Output result to a file ---
write.table(dataSum,"tidy_data.txt",row.names = FALSE)
