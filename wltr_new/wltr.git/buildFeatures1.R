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
    
    
    df$appGmvSum1Day <- 0.01*(df$item_gmv_sum_1day_app)
    df$appGmvSum3Day <- 0.01*(df$item_gmv_sum_3day_app - df$item_gmv_sum_1day_app)
    df$appGmvSum7Day <- 0.01*(df$item_gmv_sum_7day_app - df$item_gmv_sum_3day_app)
    df$appGmvSum15Day <- 0.01*(df$item_gmv_sum_15day_app - df$item_gmv_sum_7day_app)
    df$appGmvSum30Day <- 0.01*(df$item_gmv_sum_30day_app - df$item_gmv_sum_15day_app)
    
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
    
# df$pcPGmvCTR <- log10(df$pcGmvSum + 1) * df$pcGmvCTR
#   df$appPGmvCTR <- log10(df$appGmvSum + 1) * df$appGmvCTR
    
#   df$pcPDetailCTR <- log10(df$pcDetailPV + 1) * df$pcGmvCTR
#   df$appPDetailCTR <- log10(df$appDetailPV + 1) * df$appGmvCTR
    
#   df$pcPGmvDetailCTR <- df$pcGmvCTR * df$pcDetailCTR
#   df$appPGmvDetailCTR <- df$appGmvCTR * df$appDetailCTR
    
    df$pcPGmvDetail <- log10(df$pcGmvSum+1) * log10(df$pcDetailPV + 1)
    
    df$appPGmvDetail <- log10(df$appGmvSum +1)* log10(df$appDetailPV + 1)
    
    return(df)
    
}

deriveDetailCTR <- function(df) {
    
    df$pcDetailCTR <- df$pcDetailPV / (df$pcBookPV+10000)
    df$pcDetailCTR[df$pcDetailCTR>0.01] <- 0.01
    
    df$appDetailCTR <- df$appDetailPV / (df$appBookPV+1000)
    df$appDetailCTR[df$appDetailCTR>0.03] <- 0.03
    
    return(df)
}

deriveGmvCTR <- function(df) {
    
    df$pcGmvCTR <- df$pcGmvSum / (df$pcBookPV+10000)
 df$pcGmvCTR[df$pcGmvCTR>0.01] <- 0.01
    
    df$appGmvCTR <- df$appGmvSum / (df$appBookPV+1000)
   df$appGmvCTR[df$appGmvCTR>0.01] <- 0.01
    
    return(df)
}

deriveFeatures <- function(df) {
    df <- deriveDetailCTR(df)
    df <- deriveGmvCTR(df)
    df <- crossFeatures(df)
    return(df)
}

catFeatures <- function(df) {
    catData <- ddply(df,.(categoryIds),summarize,
                    pcCatGmvCTR = sum(pcGmvSum) / (sum(pcBookPV) + 10000),
                    pcCatDetailCTR = sum(pcDetailPV) / (sum(pcBookPV) + 10000),
                    pcCatGmvSum = sum(pcGmvSum),
                    pcCatDetailPV = sum(pcDetailPV),
                    pcCatGmvCount = sum(pcGmvCount),
                    
                    appCatGmvCTR = sum(appGmvSum) / (sum(appBookPV) + 1000),
                    appCatDetailCTR = sum(appDetailPV) / (sum(appBookPV) + 1000),
                    appCatGmvSum = sum(appGmvSum),
                    appCatDetailPV = sum(appDetailPV),
                    appCatGmvCount = sum(appGmvCount),
                    
                    .parallel=TRUE)
    
 catData$pcCatGmvCTR[catData$pcCatGmvCTR>0.01] <- 0.01
   catData$pcCatDetailCTR[catData$pcCatDetailCTR>0.01] <- 0.01
    catData$pcCatPGmvCTR <- log10(catData$pcCatGmvSum+1) * catData$pcCatGmvCTR
    catData$pcCatPDetailCTR <- log10(catData$pcCatDetailPV+1) * catData$pcCatDetailCTR
    catData$pcCatPGmvDetailCTR <- catData$pcCatGmvCTR * catData$pcCatDetailCTR
    catData$pcCatPGmvDetail <- log10(catData$pcCatGmvSum +1)* log10(catData$pcCatDetailPV+1)
    
   catData$appCatGmvCTR[catData$appCatGmvCTR>0.01] <- 0.01
   catData$appCatDetailCTR[catData$appCatDetailCTR>0.03] <- 0.03
    catData$appCatPGmvCTR <- log10(catData$appCatGmvSum+1) * catData$appCatGmvCTR
    catData$appCatPDetailCTR <- log10(catData$appCatDetailPV+1) * catData$appCatDetailCTR
    catData$appCatPGmvDetailCTR <- catData$appCatGmvCTR * catData$appCatDetailCTR
    catData$appCatPGmvDetail <- catData$appCatGmvSum * catData$appCatDetailPV
    
    df <- merge(df,catData,by="categoryIds",all.x=TRUE)
    return(df)
}



shopFeatures <- function(df) {
    spData <- ddply(df,.(shopId),summarize,
                   pcSpGmvCTR = sum(pcGmvSum) / (sum(pcBookPV) + 10000),
                   pcSpDetailCTR = sum(pcDetailPV) / (sum(pcBookPV) + 10000),
                   pcSpGmvSum = sum(pcGmvSum),
                   pcSpDetailPV = sum(pcDetailPV),
                   pcSpGmvCount = sum(pcGmvCount),
                   
                   appSpGmvCTR = sum(appGmvSum) / (sum(appBookPV) + 1000),
                   appSpDetailCTR = sum(appDetailPV) / (sum(appBookPV) + 1000),
                   appSpGmvSum = sum(appGmvSum),
                   appSpDetailPV = sum(appDetailPV),
                   appSpGmvCount = sum(appGmvCount),
                   
                   .parallel=TRUE)
    
spData$pcSpGmvCTR[spData$pcSpGmvCTR>0.01] <- 0.01
   spData$pcSpDetailCTR[spData$pcSpDetailCTR>0.01] <- 0.01
#    spData$pcSpPGmvCTR <- log10(spData$pcSpGmvSum+1) * spData$pcSpGmvCTR
#    spData$pcSpPDetailCTR <- log10(spData$pcSpDetailPV+1) * spData$pcSpDetailCTR
#    spData$pcSpPGmvDetailCTR <- spData$pcSpGmvCTR * spData$pcSpDetailCTR
    spData$pcSpPGmvDetail <- log10(spData$pcSpGmvSum +1)* log10(spData$pcSpDetailPV+1)
    
   spData$appSpGmvCTR[spData$appSpGmvCTR>0.01] <- 0.01
   spData$appSpDetailCTR[spData$appSpDetailCTR>0.03] <- 0.03
#    spData$appSpPGmvCTR <- log10(spData$appSpGmvSum+1) * spData$appSpGmvCTR
#    spData$appSpPDetailCTR <- log10(spData$appSpDetailPV+1) * spData$appSpDetailCTR
#    spData$appSpPGmvDetailCTR <- spData$appSpGmvCTR * spData$appSpDetailCTR
    spData$appSpPGmvDetail <- spData$appSpGmvSum * spData$appSpDetailPV
    
    df <- merge(df,spData,by="shopId",all.x=TRUE)
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
   
    cols <- c("pcDetailPV","pcGmvSum","pcGmvCount",
              "pcSpGmvSum","pcSpDetailPV")
             
    cols <- c(cols,"appDetailPV","appGmvSum","appGmvCount","appSpGmvSum",
              "appSpDetailPV")
    
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
    cols <- c(cols,"pcSpDetailPV","pcSpDetailCTR","pcSpGmvSum","pcSpGmvCTR")
    cols <- c(cols,"pcSpPGmvDetail")
   cols <- c(cols,"appSpDetailPV","appSpDetailCTR","appSpGmvSum","appSpGmvCTR")
    cols <- c(cols,"appSpPGmvDetail")
    
#   cols <- c(cols,"pcCatDetailPV","pcCatDetailCTR","pcCatGmvSum","pcCatGmvCTR")
#   cols <- c(cols,"pcCatPGmvDetail","pcCatPGmvCTR","pcCatPDetailCTR","pcCatPGmvDetailCTR")
#  cols <- c(cols,"appCatDetailPV","appCatDetailCTR","appCatGmvSum","appCatGmvCTR")
#  cols <- c(cols,"appCatPGmvDetail","appCatPGmvCTR","appCatPDetailCTR","appCatPGmvDetailCTR")
    return(df[,cols])
}

selectPcFeatures <- function(df) {
    cols <- c("itemInfoId","tradeItemId")
    cols <- c(cols,"price_50","price_100","price_150","price_200","price_250")
    cols <- c(cols,"pcGmvSum","pcDetailPV","pcGmvCount","pcGmvCTR","pcDetailCTR")
    cols <- c(cols,"pcPGmvDetail")
    cols <- c(cols,"pcSpDetailPV","pcSpDetailCTR","pcSpGmvSum","pcSpGmvCTR")
    cols <- c(cols,"pcSpPGmvDetail")
#   cols <- c(cols,"pcCatDetailPV","pcCatDetailCTR","pcCatGmvSum","pcCatGmvCTR")
#   cols <- c(cols,"pcCatPGmvDetail","pcCatPGmvCTR","pcCatPDetailCTR","pcCatPGmvDetailCTR")
    return(df[,cols])
}

selectAppFeatures <- function(df) {
    
    cols <- c("itemInfoId","tradeItemId")
    cols <- c(cols,"price_50","price_100","price_150","price_200","price_250")
    cols <- c(cols,"appGmvSum","appDetailPV","appGmvCount","appGmvCTR","appDetailCTR")
   cols <- c(cols,"appPGmvDetail")
   cols <- c(cols,"appSpDetailPV","appSpDetailCTR","appSpGmvSum","appSpGmvCTR")
    cols <- c(cols,"appSpPGmvDetail")
#  cols <- c(cols,"appCatDetailPV","appCatDetailCTR","appCatGmvSum","appCatGmvCTR")
#  cols <- c(cols,"appCatPGmvDetail","appCatPGmvCTR","appCatPDetailCTR","appCatPGmvDetailCTR")
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
    cols <- c(cols,"pcSpDetailPV","pcSpDetailCTR","pcSpGmvSum","pcSpGmvCTR")
    cols <- c(cols,"pcSpPGmvDetail")
    cols <- c(cols,"appSpDetailPV","appSpDetailCTR","appSpGmvSum","appSpGmvCTR")
    cols <- c(cols,"appSpPGmvDetail")
    
#   cols <- c(cols,"pcCatDetailPV","pcCatDetailCTR","pcCatGmvSum","pcCatGmvCTR")
#   cols <- c(cols,"pcCatPGmvDetail","pcCatPGmvCTR","pcCatPDetailCTR","pcCatPGmvDetailCTR")
#   cols <- c(cols,"appCatDetailPV","appCatDetailCTR","appCatGmvSum","appCatGmvCTR")
#   cols <- c(cols,"appCatPGmvDetail","appCatPGmvCTR","appCatPDetailCTR","appCatPGmvDetailCTR")
    
    for (col in cols ) {
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
# df <- catFeatures(df)
    df <- shopFeatures(df)
    df <- logFeatures(df)
    df <- discretePrice(df)
    df <- selectFeatures(df)
    df <- normFeatures(df)
    return(df)
}

buildTestFeatures <- function(df) {
    df <- timeOnlineSmooth(df)
    df <- deriveFeatures(df)
#   df <- catFeatures(df)
    df <- shopFeatures(df)
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

print(args)
pcFilename <- paste(filename,"pc",sep=".")
print(pcFilename)
appFilename <- paste(filename,"app",sep=".")
pcData <- selectPcFeatures(df)
appData <- selectAppFeatures(df)

write.table(pcData,file=pcFilename,sep=",",row.names=FALSE)
write.table(appData,file=appFilename,sep=",",row.names=FALSE)
