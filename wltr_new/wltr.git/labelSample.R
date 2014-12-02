library(plyr)

maxminNorm <- function(y) {
    ymax <- max(y)
    ymin <- min(y)
    delta <- ifelse(ymin==ymax,1,ymax-ymin)
    y <- (y-ymin) / delta
    y[y<0.0001] <- 0
    return(y)
}

labelPCSampleByGmv <- function(df) {
    df <- subset(df,item_book_pv_1day>0)
	
	C <- sum(df$item_click_pv_1day) / sum(df$item_book_pv_1day)

	row <- order(df$item_book_pv_1day,decreasing=TRUE)
	M <- df$item_book_pv_1day[row[1000]]
	df$ctr <- df$item_click_pv_1day / df$item_book_pv_1day
	df$ctr <- df$item_book_pv_1day * df$ctr / (df$item_book_pv_1day + M) 
	df$ctr <- df$ctr + M * C / (df$item_book_pv_1day + M) 

    
    row <- order(df$ctr * df$item_gmv_sum_1day ,decreasing=TRUE)
    df <- df[row,]
	df$y <- 0
    df$y[seq(500)] <- 1
    
    df <- df[,c("tradeItemId","y")]
    return(df)
}




labelAPPSampleByGmv <- function(df) {
    df <- subset(df,item_book_pv_1day_app>0)

	C <- sum(df$item_gmv_sum_1day_app) / sum(df$item_book_pv_1day_app)

	row <- order(df$item_book_pv_1day_app,decreasing=TRUE)
	M <- df$item_book_pv_1day_app[row[1000]]

	df$ctr <- df$item_gmv_sum_1day_app / df$item_book_pv_1day_app
	df$ctr <- df$item_book_pv_1day_app * df$ctr / (df$item_book_pv_1day_app + M) 
	df$ctr <- df$ctr + M * C / (df$item_book_pv_1day_app + M) 

    
    row <- order(df$ctr  ,decreasing=TRUE)
    df <- df[row,]
	df$y <- 0
    df$y[seq(500)] <- 1
    
    
    df <- df[,c("tradeItemId","y")]
    return(df)
}

readDataFromCSV <- function(filename) {
    return(read.table(filename,
                      sep=",",
                      na.strings = "NULL",
                      stringsAsFactors=FALSE,
                      header=TRUE))
}

writeDataToCSV <- function(df,filename) {
    write.table(df,
                file=filename,
                sep=",",
                row.names=FALSE)
}

labelSample <- function(args) {
    
    srcFilename <- paste(args[1],"clean",sep=".")
    pcGmvFilename <- paste(args[1],"pc.label",sep=".")
    appGmvFilename <- paste(args[1],"app.label",sep=".")
    
    df <- readDataFromCSV(srcFilename)
    pcGmvSample <- labelPCSampleByGmv(df)
    writeDataToCSV(pcGmvSample,pcGmvFilename)
  
    
    appGmvSample <- labelAPPSampleByGmv(df)
    writeDataToCSV(appGmvSample,appGmvFilename)
    
}

args <- c("../data/20141010.clean",
          "../data/20141010.pc.label",
          "../data/20141010.app.label")

args <- commandArgs(TRUE)
labelSample(args)
