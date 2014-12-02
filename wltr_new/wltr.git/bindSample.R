

readDataFromCSV <- function(filename) {
	return(read.table(file=filename,
				sep=",",
				header=TRUE))
}

bindSample <- function() {
#files <- c("20141009","20141010","20141011","20141012")
	files <- c("20141011")
	files <- paste(files,"sample.app",sep=".")
	files <- paste("../data",files,sep="/")
	datas <- readDataFromCSV(files[1])
#	for ( i in seq(from=2,to=length(files),by=1)) {
		
#		data <- readDataFromCSV(files[i])
#		datas <- rbind(datas,data)
#	}

	write.table(datas[,c(-1,-2)],file="20141011.sample.apps",sep=",",row.names=FALSE)
}



bindSample()
