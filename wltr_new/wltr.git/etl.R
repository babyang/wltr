#
#
#
#source("/home/zhiyuan/l2r/R/env.setting.R")
#source("/home/zhiyuan/l2r/R/utils.R")

source("./env.setting.R")
source("./utils.R")


readDataFromText <- function(filename) {
    return(read.table(filename,
                      sep="\t",
                      na.strings = "NA",
                      header=TRUE))
}

check.na <- function(df,stat.na.filename) {
  sink(stat.na.filename)
  cols <- names(df)
  for (col in cols) {
    size.null <- length(which(is.na(df[,col])))
    print(paste(col,size.null,sep=': '))
  }
  sink()
}

dropNA <- function(df) {
    cols <- names(df) 
    for (col in cols) {
        df[is.na(df[,col]),col] = 0
    }
    return(df)
}


dropInvalid <- function(df) {
    
    appGMVCols <- c("item_gmv_sum_30day_app","item_gmv_sum_15day_app",
                    "item_gmv_sum_7day_app","item_gmv_sum_3day_app",
                    "item_gmv_sum_1day_app","item_gmv_sum_0day_app")
    
    pcGMVCols <- c("item_gmv_sum_30day","item_gmv_sum_15day",
                    "item_gmv_sum_7day","item_gmv_sum_3day",
                    "item_gmv_sum_1day","item_gmv_sum_0day")
    
    
    appClickCols <- c("item_click_pv_30day_app","item_gmv_sum_15day_app",
                    "item_gmv_sum_7day_app","item_gmv_sum_3day_app",
                    "item_gmv_sum_1day_app","item_gmv_sum_0day_app")
    
    
    zeroRows <- df$item_book_pv_30day == 0
    for (col in pcGMVCols) {
        df[zeroRows,col] <- 0
    }
    for (col in pcClickCols) {
        df[zeroRows,col] <- 0
    }
    
    zeroRows <- df$item_book_pv_15day == 0
    for (col in pcGMVCols[c(-1)]) {
        df[zeroRows,col] <- 0
    }
    for (col in pcClickCols[c(-1)]) {
        df[zeroRows,col] <- 0
    }
    
    
    zeroRows <- df$item_book_pv_7day == 0
    for (col in pcGMVCols[c(-1,-2)]) {
        df[zeroRows,col] <- 0
    }
    for (col in pcClickCols[c(-1,-2)]) {
        df[zeroRows,col] <- 0
    }
    
    
    zeroRows <- df$item_book_pv_3day == 0
    for (col in pcGMVCols[c(-1,-2,-3)]) {
        df[zeroRows,col] <- 0
    }
    for (col in pcClickCols[c(-1,-2,-3)]) {
        df[zeroRows,col] <- 0
    }
    
    zeroRows <- df$item_book_pv_30day_app == 0
    
    for (col in appGMVCols) {
        df[zeroRows,col] <- 0
    }
    for (col in appClickCols) {
        df[zeroRows,col] <- 0
    }
    
    zeroRows <- df$item_book_pv_15day_app == 0
    for (col in appGMVCols[c(-1)]) {
        df[zeroRows,col] <- 0
    }
    for (col in appClickCols[c(-1)]) {
        df[zeroRows,col] <- 0
    }
    
    zeroRows <- df$item_book_pv_7day_app == 0
    for (col in appGMVCols[c(-1,-2)]) {
        df[zeroRows,col] <- 0
    }
    for (col in appClickCols[c(-1,-2)]) {
        df[zeroRows,col] <- 0
    }
    
    zeroRows <- df$item_book_pv_3day_app == 0
    for (col in appGMVCols[c(-1,-2,-3)]) {
        df[zeroRows,col] <- 0
    }
    for (col in appClickCols[c(-1,-2,-3)]) {
        df[zeroRows,col] <- 0
    }
    
    return (df)
}



cleanData <- function(args) {
    rawFilename <- args[1]
    cleanFilename <- args[2]
    rawData <- readDataFromText(rawFilename)
    rawData <- dropNA(rawData)
    rawData <- dropInvalid(rawData)
    write.table(rawData,cleanFilename,sep=",",row.names = FALSE)
}


args <- commandArgs(TRUE)
ensemble.train(args)

