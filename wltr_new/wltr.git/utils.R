


SaveTxtData <- function(df,
		filename,
		col.names = T
		) {
	write.table(df,
			file=filename,
			sep="\t",
			col.names=col.names,
			row.names=F)
}


ReadTxtData <- function(filename,
		header=T) {
	return(read.table(filename,
				sep="\t",
				header=header,
				na.strings="NULL",
				stringsAsFactors=F))
}
