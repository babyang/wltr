
read.txt <- function(filepath) {
    files <- sort(dir(filepath), decreasing=TRUE)
	files <- paste(filepath,files,sep="/")
	for (filename in files) {
		print(filename)
		read.table(filename,
				sep="\t",
				header=TRUE,
				stringsAsFactors=FALSE)
	}
}




#read.txt("/var/data/dataForLTR/20141104")
