library(plyr)
library(doMC)
registerDoMC(cores=8)


sequenceTime <- function(df) {
    df$pcBookPV1Day <- df$item_book_pv_1day
   df$pcBookPV3Day <- df$item_book_pv_3day - df$item_book_pv_1day
    df$pcBookPV7Day <- df$item_book_pv_7day - df$item_book_pv_3day
    df$pcBookPV15Day <- df$item_book_pv_15day - df$item_book_pv_7day
    df$pcBookPV30Day <- df$item_book_pv_30day - df$item_book_pv_15day
    
    df$pcDetailPV1Day <- df$item_click_pv_1day
    df$pcDetailPV3Day <- df$item_click_pv_3day - df$item_click_pv_1day
    df$pcDetailPV7Day <- df$item_click_pv_7day - df$item_click_pv_3day
   df$pcDetailPV15Day <- df$item_click_pv_15day - df$item_click_pv_7day
    df$pcDetailPV30Day <- df$item_click_pv_30day - df$item_click_pv_15day
    
    

    df$pcGmvSum1Day <- 0.01*(df$item_gmv_sum_1day)
   df$pcGmvSum3Day <- 0.01*(df$item_gmv_sum_3day - df$item_gmv_sum_1day)
    df$pcGmvSum7Day <- 0.01*(df$item_gmv_sum_7day - df$item_gmv_sum_3day)
    df$pcGmvSum15Day <- 0.01*(df$item_gmv_sum_15day - df$item_gmv_sum_7day)
    df$pcGmvSum30Day <- 0.01*(df$item_gmv_sum_30day - df$item_gmv_sum_15day)
    
    df$pcGmvCount1Day <- df$item_gmv_count_1day
    df$pcGmvCount3Day <- df$item_gmv_count_3day - df$item_gmv_count_1day
    df$pcGmvCount7Day <- df$item_gmv_count_7day - df$item_gmv_count_3day
    df$pcGmvCount15Day <- df$item_gmv_count_15day - df$item_gmv_count_7day
    df$pcGmvCount30Day <- df$item_gmv_count_30day - df$item_gmv_count_15day
    
    df$appBookPV1Day <- df$item_book_pv_1day_app
    df$appBookPV3Day <- df$item_book_pv_3day_app - df$item_book_pv_1day_app
    df$appBookPV7Day <- df$item_book_pv_7day_app - df$item_book_pv_3day_app
    df$appBookPV15Day <- df$item_book_pv_15day_app - df$item_book_pv_7day_app
    df$appBookPV30Day <- df$item_book_pv_30day_app - df$item_book_pv_15day_app
    
    df$appDetailPV1Day <- df$item_click_pv_1day_app
    df$appDetailPV3Day <- df$item_click_pv_3day_app - df$item_click_pv_1day_app
    df$appDetailPV7Day <- df$item_click_pv_7day_app - df$item_click_pv_3day_app
    df$appDetailPV15Day <- df$item_click_pv_15day_app - df$item_click_pv_7day_app
    df$appDetailPV30Day <- df$item_click_pv_30day_app - df$item_click_pv_15day_app
    
    
    df$appGmvSum1Day <- 0.01 * (df$item_gmv_sum_1day_app)
    df$appGmvSum3Day <- 0.01 * (df$item_gmv_sum_3day_app - df$item_gmv_sum_1day_app)
    df$appGmvSum7Day <- 0.01 * (df$item_gmv_sum_7day_app - df$item_gmv_sum_3day_app)
    df$appGmvSum15Day <- 0.01 * (df$item_gmv_sum_15day_app - df$item_gmv_sum_7day_app)
    df$appGmvSum30Day <- 0.01 * (df$item_gmv_sum_30day_app - df$item_gmv_sum_15day_app)
    
    df$appGmvCount1Day <- df$item_gmv_count_1day_app
    df$appGmvCount3Day <- df$item_gmv_count_3day_app - df$item_gmv_count_1day_app
    df$appGmvCount7Day <- df$item_gmv_count_7day_app - df$item_gmv_count_3day_app
    df$appGmvCount15Day <- df$item_gmv_count_15day_app - df$item_gmv_count_7day_app
    df$appGmvCount30Day <- df$item_gmv_count_30day_app - df$item_gmv_count_15day_app
    
    return(df)
}



expOfflineSmooth <- function(df) {
    df$pcBookPV <- exp(0)*df$pcBookPV1Day  +
       exp(-2)*df$pcBookPV3Day  +
       exp(-4)*df$pcBookPV7Day  +
       exp(-8)*df$pcBookPV15Day  +
       exp(-16)*df$pcBookPV30Day  
    
    df$pcDetailPV <- exp(0)*df$pcDetailPV1Day  +
       exp(-2)*df$pcDetailPV3Day  +
       exp(-4)*df$pcDetailPV7Day  +
       exp(-8)*df$pcDetailPV15Day  +
       exp(-16)*df$pcDetailPV30Day 
    

    df$pcGmvSum <- exp(0)*df$pcGmvSum1Day  +
        exp(-2)*df$pcGmvSum3Day  +
        exp(-4)*df$pcGmvSum7Day  +
        exp(-8)*df$pcGmvSum15Day  +
        exp(-16)*df$pcGmvSum30Day 
    
    df$pcGmvCount <- exp(0)*df$pcGmvCount1Day  +
        exp(-2)*df$pcGmvCount3Day  +
        exp(-4)*df$pcGmvCount7Day  +
        exp(-8)*df$pcGmvCount15Day  +
        exp(-16)*df$pcGmvCount30Day  
    
    
    df$appBookPV <- exp(0)*df$appBookPV1Day  +
        exp(-2)*df$appBookPV3Day  +
        exp(-4)*df$appBookPV7Day  +
        exp(-8)*df$appBookPV15Day  +
        exp(-16)*df$appBookPV30Day  
    
    df$appDetailPV <- exp(0)*df$appDetailPV1Day  +
        exp(-2)*df$appDetailPV3Day  +
        exp(-4)*df$appDetailPV7Day  +
        exp(-8)*df$appDetailPV15Day  +
        exp(-16)*df$appDetailPV30Day 
    

    df$appGmvSum <- exp(0)*df$appGmvSum1Day  +
        exp(-2)*df$appGmvSum3Day  +
        exp(-4)*df$appGmvSum7Day  +
        exp(-8)*df$appGmvSum15Day  +
        exp(-16)*df$appGmvSum30Day 
    
    df$appGmvCount <- exp(0)*df$appGmvCount1Day  +
        exp(-2)*df$appGmvCount3Day  +
        exp(-4)*df$appGmvCount7Day  +
        exp(-8)*df$appGmvCount15Day  +
        exp(-16)*df$appGmvCount30Day  
    return(df)
}


expOnlineSmooth <- function(df) {
#	T <- unclass(as.POSIXlt(Sys.time()))
#	t <-  T$hour / 12 + T$min / 7200 
#	alpha <- 1.0 / ( 1.0 + exp(t - 1) )
    df$pcBookPV <- df$pcBookPV  + exp(1)*df$item_book_pv_0day
   df$pcDetailPV <- df$pcDetailPV  + exp(1)*df$item_click_pv_0day
    df$pcGmvSum <- df$pcGmvSum  + 0.01*exp(1)*df$item_gmv_sum_0day
    df$pcGmvCount <- df$pcGmvCount  + exp(1)*df$item_gmv_sum_0day / df$price
    
    df$appBookPV <- df$appBookPV  + exp(1)*df$item_book_pv_0day_app
    df$appDetailPV <- df$appDetailPV  + exp(1)*df$item_click_pv_0day_app
    df$appGmvSum <- df$appGmvSum  + 0.01*exp(1)*df$item_gmv_sum_0day_app
    df$appGmvCount <- df$appGmvCount  + exp(1)*df$item_gmv_sum_0day_app / df$price
    return(df)
}


timeOfflineSmooth <- function(df) {
    df <- sequenceTime(df)
    df <- expOfflineSmooth(df)
    return(df)
}


timeOnlineSmooth <- function(df) {
    df <- sequenceTime(df)
    df <- expOfflineSmooth(df)
    df <- expOnlineSmooth(df)
    return(df)
}

crossFeatures <- function(df) {
    
    
   df$pcPGmvDetail <- log10(df$pcGmvSum+1) * log10(df$pcDetailPV + 1)
    
    df$appPGmvDetail <- log10(df$appGmvSum +1)* log10(df$appDetailPV + 1)
    
    return(df)
    
}

deriveDetailCTR <- function(df) {
    
	row <- order(df$pcBookPV,decreasing=TRUE)
	M <- df$pcBookPV[row[1000]] 
	
	
	C = sum(df$pcDetailPV) / sum(df$pcBookPV)

    df$pcDetailCTR <- df$pcDetailPV / (df$pcBookPV+1)
	df$pcDetailCTR <- df$pcBookPV * df$pcDetailCTR / (M + df$pcBookPV)  
	df$pcDetailCTR <- df$pcDetailCTR + C * M / (M + df$pcBookPV)
    
    
	row <- order(df$appBookPV,decreasing=TRUE)
	M <- df$appBookPV[row[1000]] 
	

	C = sum(df$appDetailPV) / sum(df$appBookPV)

    df$appDetailCTR <- df$appDetailPV / (df$appBookPV+1)
	df$appDetailCTR <- df$appBookPV * df$appDetailCTR / (M + df$appBookPV)  
	df$appDetailCTR <- df$appDetailCTR + C * M / (M + df$appBookPV)
    
    return(df)
}

deriveGmvCTR <- function(df) {
    
	row <- order(df$pcBookPV,decreasing=TRUE)
	M <- df$pcBookPV[row[1000]] 

	C = sum(df$pcGmvSum) / sum(df$pcBookPV)

   df$pcGmvCTR <- df$pcGmvSum / (df$pcBookPV+1)
	df$pcGmvCTR <- df$pcBookPV * df$pcGmvCTR / (M + df$pcBookPV)  
	df$pcGmvCTR <- df$pcGmvCTR + C * M / (M + df$pcBookPV)
    
    
	row <- order(df$appBookPV,decreasing=TRUE)
	M <- df$appBookPV[row[1000]] 
	

	C = sum(df$appGmvSum) / sum(df$appBookPV)

    df$appGmvCTR <- df$appGmvSum / (df$appBookPV+1)
	df$appGmvCTR <- df$appBookPV * df$appGmvCTR / (M + df$appBookPV)  
	df$appGmvCTR <- df$appGmvCTR + C * M / (M + df$appBookPV)
    
    return(df)
}

deriveFeatures <- function(df) {
    df <- deriveDetailCTR(df)
    df <- deriveGmvCTR(df)
    df <- crossFeatures(df)
    return(df)
}


shopFeatures <- function(df) {
    df  <- ddply(df,.(shopId),transform,
                  pcSpGmvSum = sum(pcGmvSum),
                  pcSpDetailPV = sum(pcDetailPV),
                  pcSpGmvCount = sum(pcGmvCount),
				   pcSpBookPV = sum(pcBookPV),
                   
                   appSpGmvSum = sum(appGmvSum),
                   appSpDetailPV = sum(appDetailPV),
                   appSpGmvCount = sum(appGmvCount),
				   appSpBookPV = sum(appBookPV),
                   
                   .parallel=TRUE)

	row <- order(df$pcSpBookPV,decreasing=TRUE)
	M <- df$pcSpBookPV[row[1000]]
	N <- df$pcBookPV

	C <- df$pcGmvSum / (df$pcBookPV + 1)
	A <- sum(df$pcGmvSum) / sum(df$pcBookPV)

	df$pcSpGmvCTR <- A * M / ( N + M ) +   C * N / ( N + M )


	C <- df$pcDetailPV / (df$pcBookPV + 1)
	A <- sum(df$pcDetailPV) / sum(df$pcBookPV)

	df$pcSpDetailCTR <- A * M / ( N + M ) +   C * N / ( N + M )


	row <- order(df$appBookPV,decreasing=TRUE)
	M <- df$appBookPV[row[1000]]
	N <- df$appBookPV
	C <- df$appGmvSum / (df$appBookPV + 1)
	A <- sum(df$appGmvSum) / sum(df$appBookPV)

	df$appSpGmvCTR <- A * M / ( N + M ) +   C * N / ( N + M )

	C <- df$appDetailPV / (df$appBookPV + 1)
	A <- sum(df$appDetailPV) / sum(df$appBookPV)

	df$appSpDetailCTR <- A * M / ( N + M ) +   C * N / ( N + M )
	df$pcSpPGmvDetail <- df$pcSpGmvSum * df$pcSpDetailPV
	df$appSpPGmvDetail <- df$appSpGmvSum * df$appSpDetailPV
    return(df)
}




discretePrice <- function(df) {
    price.range <- c(50,100,150,200,250)
    price.val <- 0.01 * df$price 
    price.val[price.val>250] <- 1000
    
    prev <- -1
    for (col in price.range) {
        col.name <- paste("price",col,sep="_")
        row <- (price.val > prev) &  (price.val <= col)
        df[,col.name] <- 0
        df[row,col.name] <- 1
        prev <- col
    }
    return(df)
}


logFeatures <- function(df) {
   
   cols <- c("pcDetailPV","pcGmvSum","pcGmvCount","pcPGmvDetail")
             
    cols <- c(cols,"appDetailPV","appGmvSum","appGmvCount","appPGmvDetail")

    
    for (col in cols) {
        df[,col] = log10(df[,col]+1)
    }
    return(df)
}


selectFeatures <- function(df) {
    
    cols <- c("itemInfoId","tradeItemId")
    cols <- c(cols,"price_50","price_100","price_150","price_200","price_250")
   cols <- c(cols,"pcGmvSum","pcDetailPV","pcGmvCount","pcGmvCTR","pcDetailCTR")
   cols <- c(cols,"pcPGmvDetail")
    cols <- c(cols,"appGmvSum","appDetailPV","appGmvCount","appGmvCTR","appDetailCTR")
    cols <- c(cols,"appPGmvDetail")
#   cols <- c(cols,"pcSpDetailPV","pcSpDetailCTR","pcSpGmvSum","pcSpGmvCTR","pcSpGmvCount")
#   cols <- c(cols,"pcSpPGmvDetail")
#    cols <- c(cols,"appSpDetailPV","appSpDetailCTR","appSpGmvSum","appSpGmvCTR","appSpGmvCount")
#    cols <- c(cols,"appSpPGmvDetail")
    
	row <- cols %in% names(df)
	print(cols[!row])
    return(df[,cols])
}

selectPcFeatures <- function(df) {
    cols <- c("itemInfoId","tradeItemId")
    cols <- c(cols,"price_50","price_100","price_150","price_200","price_250")
   cols <- c(cols,"pcGmvSum","pcDetailPV","pcGmvCount","pcGmvCTR","pcDetailCTR")
    cols <- c(cols,"pcPGmvDetail")
# cols <- c(cols,"pcSpDetailPV","pcSpDetailCTR","pcSpGmvSum","pcSpGmvCTR")
#   cols <- c(cols,"pcSpPGmvDetail")
    return(df[,cols])
}

selectAppFeatures <- function(df) {
    
    cols <- c("itemInfoId","tradeItemId")
    cols <- c(cols,"price_50","price_100","price_150","price_200","price_250")
    cols <- c(cols,"appGmvSum","appDetailPV","appGmvCount","appGmvCTR","appDetailCTR")
    cols <- c(cols,"appPGmvDetail")
#    cols <- c(cols,"appSpDetailPV","appSpDetailCTR","appSpGmvSum","appSpGmvCTR")
#    cols <- c(cols,"appSpPGmvDetail")
    return(df[,cols])
}

maxminNorm <- function(y) {
    ymax <- max(y)
    ymin <- min(y)
    delta <- ifelse(ymin==ymax,1,ymax-ymin)
    y <- (y-ymin) / delta
    y[y<0.0001] <- 0
    return(y)
}

normFeatures <- function(df) {
   cols <- c("pcGmvSum","pcDetailPV","pcGmvCount","pcGmvCTR","pcDetailCTR")
   cols <- c(cols,"pcPGmvDetail")
    cols <- c(cols,"appGmvSum","appDetailPV","appGmvCount","appGmvCTR","appDetailCTR")
    cols <- c(cols,"appPGmvDetail")
# cols <- c(cols,"pcSpDetailPV","pcSpDetailCTR","pcSpGmvSum","pcSpGmvCTR")
#   cols <- c(cols,"pcSpPGmvDetail")
#    cols <- c(cols,"appSpDetailPV","appSpDetailCTR","appSpGmvSum","appSpGmvCTR")
#    cols <- c(cols,"appSpPGmvDetail")
    
    
    for (col in cols) {
		df[,col] <- maxminNorm(df[,col])
	}
    return(df)
}

readDataFromCSV <- function(filename) {
    return(read.table(filename,
                      sep=",",
                      na.strings = "NULL",
                      stringsAsFactors=FALSE,
                      header=TRUE))
}


buildTrainFeatures <- function(df) {
    df <- timeOfflineSmooth(df)
    df <- deriveFeatures(df)
#	df <- shopFeatures(df)
	df <- logFeatures(df)
    df <- discretePrice(df)
    df <- selectFeatures(df)
    df <- normFeatures(df)
    return(df)
}

buildTestFeatures <- function(df) {
    df <- timeOnlineSmooth(df)
    df <- deriveFeatures(df)
#    df <- shopFeatures(df)
    df <- logFeatures(df)
    df <- discretePrice(df)
    df <- selectFeatures(df)
    df <- normFeatures(df)
    return(df)
}

args <- commandArgs(TRUE)

df <- readDataFromCSV(args[1])


if (args[3] == "train" ) {
		df<-buildTrainFeatures(df)
} else {
		df<-buildTestFeatures(df)
}

if (args[3] == "train" ) {
		filename<-paste(args[2],"train",sep=".")
} else {
		filename<-paste(args[2],"test",sep=".")
}

pcFilename <- paste(filename,"pc",sep=".")
appFilename <- paste(filename,"app",sep=".")
pcData <- selectPcFeatures(df)
appData <- selectAppFeatures(df)

write.table(pcData,file=pcFilename,sep=",",row.names=FALSE)
write.table(appData,file=appFilename,sep=",",row.names=FALSE)
