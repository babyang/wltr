
read.txt <- function(filepath) {
    files <- sort(dir(filepath), decreasing=TRUE)
	files <- paste(filepath,files,sep="/")
	for (filename in files) {
	print(filename)
	conn <- file(filename,"rb")
	txt <- readLines(conn)
	for ( line in txt ) {
		field <- unlist(strsplit(line,split='\t'))
		if (length(field)!=111) {
			print(line)
		}
	}
	}
}




#read.txt("/var/data/dataForLTR/20141104")
