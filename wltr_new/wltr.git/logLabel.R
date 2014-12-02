#!/usr/bin/env Rscript 
library(parallel)

repSample <- function(x) {
	times <- x[[2]]
	plus <- x[[3]]
	tradeItemId <- x[[1]]
	ids <- rep(tradeItemId,times)
	val <- rep(0,times)
	data <- cbind(ids,val)
	data[seq(plus),2] <- 1
	data <- as.data.frame(data)
	return(data)
}


bindSample <- function(x,data) {
	data <- rbind(x,data)
	return(data)
}

labelSample <- function(df) {
	df <- subset(df,item_book_pv_1day>0)
	allSize <- df$item_book_pv_1day
	plusSize <- df$item_gmv_count_1day
	tradeItemId <- df$tradeItemId
	m <- as.matrix(cbind(tradeItemId,allSize,plusSize))
	data <- apply(m,1,repSample)	

	sample <- data.frame()
	for ( i in seq(length(data)) ) {
		sample <- rbind(sample,data[[i]])
	}
	write.table(sample,"20141026.lable",sep=",",row.names=FALSE)
}


readDataFromCSV <- function(filename) {
    return(read.table(filename,
                      sep=",",
                      stringsAsFactors=FALSE,
                      header=TRUE))
}


df <- readDataFromCSV("20141026.clean")
labelSample(df)

