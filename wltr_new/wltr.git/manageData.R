#
#
#
#source("/home/zhiyuan/Projects/wltr/alarm_sms.R")
source("./alarm_sms.R")


waitFileReady <- function(inFile, sleepTime=10){
	date <- args[1]
	str(date)
	srcPath <- paste("/var/data/dataForLTR3",date,sep="/")
	srcFile <- paste(srcPath, inFile, sep="/")
	checkFile = paste(srcFile, 'finish', sep='.')
	str(checkFile)
	isReady <- FALSE
	for(i in 1:30){
		if(file.exists(checkFile)){
			str('file ready')
			isReady <- TRUE
			break
		}
		str('waiting')
		Sys.sleep(sleepTime)
	}

	if(isReady == FALSE){
		str('timeout')
		SendSMS('read 15min data file timeout')
	}
	# add send sms
}

CheckRelYou2 <- function(df) {
	if ( nrow( subset(df,relYou2==-1) ) < 10000 ) {
		stop( "relYou2 invalid ")
	}

	if ( nrow( subset(df,relYou2!=-1) ) < 10000 ) {
		stop( "relYou2 invalid ")
	}
}

CheckCol <- function(col,df) {
	if (length(which(df[,col]<0)) > 0 ) {
		print(col)
		stop("low zero error")
	}
	if (sum(df[,col]) <= 0 ) {
		print(col)
		stop("sum zero error")
	}
}

CheckRaw <-  function(df) {

	check.cols <- c("item_book_pv_0day",
			"item_book_pv_1day",
			"item_book_pv_3day",
			"item_book_pv_7day",
			"item_book_pv_15day",
			"item_book_pv_30day",
			"item_book_pv_0day_app",
			"item_book_pv_1day_app",
			"item_book_pv_3day_app",
			"item_book_pv_7day_app",
			"item_book_pv_15day_app",
			"item_book_pv_30day_app",
			"item_click_pv_0day",
			"item_click_pv_1day",
			"item_click_pv_3day",
			"item_click_pv_7day",
			"item_click_pv_15day",
			"item_click_pv_30day",
			"item_click_pv_0day_app",
			"item_click_pv_1day_app",
			"item_click_pv_3day_app",
			"item_click_pv_7day_app",
			"item_click_pv_15day_app",
			"item_click_pv_30day_app",
			"item_gmv_count_0day",
			"item_gmv_count_1day",
			"item_gmv_count_3day",
			"item_gmv_count_7day",
			"item_gmv_count_15day",
			"item_gmv_count_30day",
			"item_gmv_count_0day_app",
			"item_gmv_count_1day_app",
			"item_gmv_count_3day_app",
			"item_gmv_count_7day_app",
			"item_gmv_count_15day_app",
			"item_gmv_count_30day_app",
			"item_gmv_sum_0day",
			"item_gmv_sum_1day",
			"item_gmv_sum_3day",
			"item_gmv_sum_7day",
			"item_gmv_sum_15day",
			"item_gmv_sum_30day",
			"item_gmv_sum_0day_app",
			"item_gmv_sum_1day_app",
			"item_gmv_sum_3day_app",
			"item_gmv_sum_7day_app",
			"item_gmv_sum_15day_app",
			"item_gmv_sum_30day_app",
			"price"
			)

	
	lapply(cols,CheckCol,df)
	CheckReYou2(df)

	

}

copyDataByDate <- function(srcPath,dstFile,index=1) {
    srcFiles <- sort(dir(srcPath), decreasing=TRUE)
	srcFile <- paste(srcPath,srcFiles[index],sep="/")
	waitFileReady(srcFiles[index])
	if (file.exists(dstFile)) {
		file.remove(dstFile)
	}
    file.copy(srcFile,dstFile)
}

cutDataByTags <- function(df,filename) {
   
    isRelyou <- df$relYou>0 
	isFree <- df$relYou2 == -1 

	if ( length(which(isFree)) > 0 ) { 
		isFree <- df$ismjshop == 1 & isFree
	}

	if ( length(which(isFree)) > 0 ) {
		isRelyou <- isRelyou | isFree
	}

	onSale <-  df$onsale_it==1 

	print(length(isFree))
	print(length(isRelyou))
	print(length(onSale))

    
    #	df$type <- ""
    df$type[isRelyou] <- 'relYou'
    df$type[!isRelyou] <- 'norm'
	df$type[onSale] <- "onSale"
    
    df <- df[,c("tradeItemId","type")]
    write.table(df,file=filename,sep=",",row.names=FALSE)
}



readDataFromText <- function(filename) {
    return(read.table(filename,
                      sep="\t",
					  quote = "",
                      na.strings = "NULL",
                      stringsAsFactors=FALSE,
                      header=TRUE))
}



dropNA <- function(df) {
	df[is.na(df)] <- 0
    return(df)
}


dropInvalid <- function(df) {
    
    appGMVCols <- c("item_gmv_sum_30day_app","item_gmv_sum_15day_app",
                    "item_gmv_sum_7day_app","item_gmv_sum_3day_app",
                    "item_gmv_sum_1day_app","item_gmv_sum_0day_app")
    
    pcGMVCols <- c("item_gmv_sum_30day","item_gmv_sum_15day",
                    "item_gmv_sum_7day","item_gmv_sum_3day",
                    "item_gmv_sum_1day","item_gmv_sum_0day")
    
    
    appClickCols <- c("item_click_pv_30day_app","item_click_pv_15day_app",
                    "item_click_pv_7day_app","item_click_pv_3day_app",
                    "item_click_pv_1day_app","item_click_pv_0day_app")
    
    pcClickCols <- c("item_click_pv_30day","item_click_pv_15day",
                      "item_click_pv_7day","item_click_pv_3day",
                      "item_click_pv_1day","item_click_pv_0day")
    
    zeroRows <- df$item_book_pv_30day == 0 | 
	df$item_book_pv_30day < df$item_click_pv_30day | 
	df$item_click_pv_30day == 0 & df$item_gmv_sum_30day > 0 

    for (col in pcGMVCols) {
        df[zeroRows,col] <- 0
    }
    for (col in pcClickCols) {
        df[zeroRows,col] <- 0
    }
    
    zeroRows <- df$item_book_pv_15day == 0 |
	df$item_book_pv_15day < df$item_click_pv_15day | 
	df$item_click_pv_15day == 0 & df$item_gmv_sum_15day > 0 
    for (col in pcGMVCols[c(-1)]) {
        df[zeroRows,col] <- 0
    }
    for (col in pcClickCols[c(-1)]) {
        df[zeroRows,col] <- 0
    }
    
    
    zeroRows <- df$item_book_pv_7day == 0 | 
	df$item_book_pv_7day < df$item_click_pv_7day | 
	df$item_click_pv_7day == 0 & df$item_gmv_sum_7day > 0 
    for (col in pcGMVCols[c(-1,-2)]) {
        df[zeroRows,col] <- 0
    }
    for (col in pcClickCols[c(-1,-2)]) {
        df[zeroRows,col] <- 0
    }
    
    
    zeroRows <- df$item_book_pv_3day == 0 |
	df$item_book_pv_3day < df$item_click_pv_3day | 
	df$item_click_pv_3day == 0 & df$item_gmv_sum_3day > 0 

    for (col in pcGMVCols[c(-1,-2,-3)]) {
        df[zeroRows,col] <- 0
    }
    for (col in pcClickCols[c(-1,-2,-3)]) {
        df[zeroRows,col] <- 0
    }
    
    zeroRows <- df$item_book_pv_1day == 0 |
	df$item_book_pv_1day < df$item_click_pv_1day | 
	df$item_click_pv_1day == 0 & df$item_gmv_sum_1day > 0 

    for (col in pcGMVCols[c(-1,-2,-3,-4)]) {
        df[zeroRows,col] <- 0
    }
    for (col in pcClickCols[c(-1,-2,-3,-4)]) {
        df[zeroRows,col] <- 0
    }


    zeroRows <- df$item_book_pv_30day_app == 0 |
	df$item_book_pv_30day_app < df$item_click_pv_30day_app | 
	df$item_click_pv_30day_app == 0 & df$item_gmv_sum_30day_app > 0 
    
    for (col in appGMVCols) {
        df[zeroRows,col] <- 0
    }
    for (col in appClickCols) {
        df[zeroRows,col] <- 0
    }
    
    zeroRows <- df$item_book_pv_15day_app == 0 |
	df$item_book_pv_15day_app < df$item_click_pv_15day_app | 
	df$item_click_pv_15day_app == 0 & df$item_gmv_sum_15day_app > 0 

    for (col in appGMVCols[c(-1)]) {
        df[zeroRows,col] <- 0
    }
    for (col in appClickCols[c(-1)]) {
        df[zeroRows,col] <- 0
    }
    
    zeroRows <- df$item_book_pv_7day_app == 0 |
	df$item_book_pv_7day_app < df$item_click_pv_7day_app | 
	df$item_click_pv_7day_app == 0 & df$item_gmv_sum_7day_app > 0 
    for (col in appGMVCols[c(-1,-2)]) {
        df[zeroRows,col] <- 0
    }
    for (col in appClickCols[c(-1,-2)]) {
        df[zeroRows,col] <- 0
    }
    
    zeroRows <- df$item_book_pv_3day_app == 0 |
	df$item_book_pv_3day_app < df$item_click_pv_3day_app | 
	df$item_click_pv_3day_app == 0 & df$item_gmv_sum_3day_app > 0 
    for (col in appGMVCols[c(-1,-2,-3)]) {
        df[zeroRows,col] <- 0
    }
    for (col in appClickCols[c(-1,-2,-3)]) {
        df[zeroRows,col] <- 0
    }
    
    zeroRows <- df$item_book_pv_1day_app == 0 |
	df$item_book_pv_1day_app < df$item_click_pv_1day_app | 
	df$item_click_pv_1day_app == 0 & df$item_gmv_sum_1day_app > 0 
    for (col in appGMVCols[c(-1,-2,-3,-4)]) {
        df[zeroRows,col] <- 0
    }
    for (col in appClickCols[c(-1,-2,-3,-4)]) {
        df[zeroRows,col] <- 0
	}
    return (df)
}



cleanData <- function(rawFilename,cleanFilename,cutFilename) {
    rawData <- readDataFromText(rawFilename)
    rawData <- dropNA(rawData)
    rawData <- dropInvalid(rawData)
	row <- grepl("X",names(rawData))|grepl("cart",names(rawData))
	rawData <- rawData[,names(rawData)[!row]]
    write.table(rawData,cleanFilename,sep=",",row.names = FALSE)
	cutDataByTags(rawData,cutFilename)


}

manageData <- function(args) {
    date <- args[1]
    rawFilename <- args[2]
    cleanFilename <- args[3]
	srcPath <- paste("/var/data/dataForLTR",date,sep="/")
	cutFilename <- paste(rawFilename,"tag",sep=".")
    copyDataByDate(srcPath,rawFilename)
    cleanData(rawFilename,cleanFilename,cutFilename)
}
args <- commandArgs(TRUE)
manageData(args)

