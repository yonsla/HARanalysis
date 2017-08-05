#get features
features<-read.table("features.txt",header=FALSE,col.names=c("i","feature"))

#get training data
trainTab <- read.table("train/X_train.txt",header=FALSE,
                        col.names=features$feature)

#function to capitalize first letter
cap1<-function(s){c(toupper(substr(s,1,1)),substr(s,2,nchar(s)))}

#function to capitalize first letter of every word and paste them together
process<-function(name){
	arr<- strsplit(name,"\\.")
	capArr<- sapply(arr[[1]],cap1)
	Reduce(function(x,y){paste(x,y,sep="")},capArr)
}

#process the names of the features
names(trainTab) <- sapply(names(trainTab),process)

#read in the subject number for training data
trainSubject <- read.table("train/subject_train.txt",header=FALSE,
                            col.names="subject")
trainTab$subject<-trainSubject$subject

#read in the activity
trainActivityNum <- read.table("train/y_train.txt",header=FALSE,
                                col.names="activityNum")
activityNames <-c("Walking","Walking upstairs","Walking downstairs",
                  "Sitting","Standing","Laying")
trainTab$activity <-factor(trainActivityNum$activityNum, labels=activityNames)

#read in the test data
testTab <- read.table("test/X_test.txt",header=FALSE,
                        col.names=names(trainTab)[1:561])
rownames(testTab)<- (nrow(trainTab)+1):(nrow(trainTab)+nrow(testTab))
testSubject <- read.table("test/subject_test.txt",header=FALSE,
                            col.names="subject")
testTab$subject <- testSubject$subject
testActivityNum <- read.table("test/y_test.txt",header=FALSE,
                                col.name="activityNum")
testTab$activity <-factor(testActivityNum$activityNum, labels=activityNames)

#join the train and test data
myTab <- rbind(trainTab,testTab)

#extract features which are mean or standard deviation, and restrict to these
ind<-grep("(Mean|Std)([XYZ])?$",names(myTab))
myTab <- myTab[,c(ind,562,563)]

#create table of averages
averagesTab <- myTab[NULL,1:72]
for (i in 1:72) {
	averagesTab[1:6,i] <- sapply(split(myTab[,i],myTab$activity),mean)
	averagesTab[7:36,i] <- sapply(split(myTab[,i],myTab$subject),mean)
}
rowNames <- NULL
for (i in 1:6) {rowNames[i]<- paste(activityNames[i],"Average",sep="")}
for (i in 1:30) {rowNames[i+6]<- paste("subject",i,"Average",sep="")}
rownames(averagesTab)<- rowNames

#write table
write.table(averagesTab,"averagesData.txt",row.name=FALSE)
