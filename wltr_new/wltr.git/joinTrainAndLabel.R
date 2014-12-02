

readDataFromCSV <- function(filename) {
	return(read.table(file=filename,
				sep=",",
				header=TRUE))
}



joinTrainAndLabel <- function(args) {
	trainFilename <- args[1]
	labelFilename <- args[2]
	sampleFilename <- args[3]

	trainData <- readDataFromCSV(trainFilename)
	labelData <- readDataFromCSV(labelFilename)

	sample <- merge(trainData,labelData,by="tradeItemId")
	write.table(sample,sampleFilename,sep=",",row.names=FALSE)
}
args <- commandArgs(TRUE)
joinTrainAndLabel(args)
