features<-read.table("features.txt",header=FALSE,col.names=c("i","feature"))
trainTab <- read.table("train/X_train.txt",header=FALSE,
                        col.names=features$feature)
cap1<-function(s){c(toupper(substr(s,1,1)),substr(s,2,nchar(s)))}
process<-function(name){
	arr<- strsplit(name,"\\.")
	capArr<- sapply(arr[[1]],cap1)
	Reduce(function(x,y){paste(x,y,sep="")},capArr)
}
names(trainTab) <- sapply(names(trainTab),process)
trainSubject <- read.table("train/subject_train.txt",header=FALSE,
                            col.names="subject")
trainTab$subject<-trainSubject$subject
trainActivityNum <- read.table("train/y_train.txt",header=FALSE,
                                col.names="activityNum")
activityNames <-c("Walking","Walking upstairs","Walking downstairs",
                  "Sitting","Standing","Laying")
trainTab$activity <-factor(trainActivityNum$activityNum, labels=activityNames)
testTab <- read.table("test/X_test.txt",header=FALSE,
                        col.names=names(trainTab)[1:561])
rownames(testTab)<- (nrow(trainTab)+1):(nrow(trainTab)+nrow(testTab))
testSubject <- read.table("test/subject_test.txt",header=FALSE,
                            col.names="subject")
testTab$subject <- testSubject$subject
testActivityNum <- read.table("test/y_test.txt",header=FALSE,
                                col.name="activityNum")
testTab$activity <-factor(testActivityNum$activityNum, labels=activityNames)
myTab <- rbind(trainTab,testTab)
ind<-grep("(Mean|Std)([XYZ])?$",names(myTab))
myTab <- myTab[,c(ind,562,563)]
averagesTab <- myTab[NULL,1:72]
for (i in 1:72) {
	averagesTab[1:6,i] <- sapply(split(myTab[,i],myTab$activity),mean)
	averagesTab[7:36,i] <- sapply(split(myTab[,i],myTab$subject),mean)
}
rowNames <- NULL
for (i in 1:6) {rowNames[i]<- paste(activityNames[i],"Average",sep="")}
for (i in 1:30) {rowNames[i+6]<- paste("subject",i,"Average",sep="")}
rownames(averagesTab)<- rowNames
write.table(averagesTab,"averagesData.txt",row.name=FALSE)
