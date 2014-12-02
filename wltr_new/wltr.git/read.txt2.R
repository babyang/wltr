
read.txt <- function(filename) {
		read.table(filename,
				sep="\t",
				header=TRUE,
				na.strings="NULL",
				stringsAsFactors=FALSE)
}




#read.txt("/var/data/dataForLTR/20141104/1415031215019")
