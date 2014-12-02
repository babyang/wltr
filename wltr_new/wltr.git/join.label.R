
readAddSample <- function(filename,beta=0.1) {
	df <- read.table(filename,
				sep=" ",
				header=FALSE,
				stringsAsFactors=FALSE)
	names(df) <- c("tradeItemId","dist")
	df <- subset(df,dist<0.5)
	df$y <- 1
	df <- df[,c("tradeItemId","y")]
	return(df)
}


addSample <- function(labelSample,addSample) {
	row <- labelSample$tradeItemId %in% addSample$tradeItemId
	labelSample$y[row] <- 1
	print(nrow(subset(labelSample,y>0)))
	return(labelSample)
}



readDataFromCSV <- function(filename) {
	return(read.table(filename,
				sep=",",
				header=TRUE,
				stringsAsFactors=FALSE))
}

writeDataToCSV <- function(df,filename) {
	write.table(df,
			file=filename,
			sep=",",
			row.names=FALSE)
}



joinLabelSample <- function(args) {
	addFilename <- args[1]
	labelFilename <- args[2]
	outFilename <- args[3]
	beta <- 0.1
	addSample <- readAddSample(addFilename,beta)
	labelSample <- readDataFromCSV(labelFilename)
	labelSample <- addSample(labelSample,addSample)
	writeDataToCSV(labelSample,outFilename)
}

args <- commandArgs(TRUE)
joinLabelSample(args)

