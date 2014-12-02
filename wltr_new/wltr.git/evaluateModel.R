source("env.setting.R")
source("utils.R")
require(ggplot2)

readDataFromCSV <- function(filename) {
    return(read.table(filename,
                      sep=",",
                      na.strings = "NULL",
                      stringsAsFactors=FALSE,
                      header=TRUE))
}

readRankFromCSV <- function(filename) {
		rankData <- read.table(filename,
                      sep=",",
                      na.strings = "NULL",
                      stringsAsFactors=FALSE,
                      header=T)

#	names(rankData) <-c("tradeItemId","score")
		return(rankData)
}

evaluatePCModel <- function(args) {
	targetFilename <- args[1]
	predictFilename <- args[2]
	targetData <- readDataFromCSV(targetFilename)
	predictData <- readRankFromCSV(predictFilename)
	targetData <- subset(targetData,targetData$relYou>0)
	targetData <- targetData[,c("tradeItemId","item_gmv_sum_1day")]

	row <- order(targetData$item_gmv_sum_1day,decreasing=TRUE)
	targetData <- targetData[row[seq(1000)],]
	

	row <- order(predictData$score,decreasing=T)
	predictData <- predictData[row[seq(1000)],]
	

	joinData <- merge(targetData,predictData,by="tradeItemId")
	print(nrow(joinData))
}


evaluateAppModel <- function(args) {
	targetFilename <- args[1]
	predictFilename <- args[2]
	targetData <- readDataFromCSV(targetFilename)
	predictData <- readRankFromCSV(predictFilename)
	targetData <- subset(targetData,targetData$relYou>0)
	targetData <- targetData[,c("tradeItemId","item_gmv_sum_1day_app")]

	row <- order(targetData$item_gmv_sum_1day_app,decreasing=TRUE)
	targetData <- targetData[row[seq(1000)],]
	

	row <- order(predictData$rank,decreasing=FALSE)
	predictData <- predictData[row[seq(1000)],]
	

	joinData <- merge(targetData,predictData,by="tradeItemId")
	print(nrow(joinData))
}


evaluateTest <- function(args) {
	targetFilename <- args[1]
	predictFilename <- args[2]
	targetData <- readDataFromCSV(targetFilename)
	predictData <- readDataFromCSV(predictFilename)
	targetData <- subset(targetData,targetData$relYou>0)
	targetData <- targetData[,c("tradeItemId","item_gmv_sum_1day","item_click_pv_1day","item_book_pv_1day")]

	

	predictData <- subset(predictData,predictData$relYou>0)
	predictData <- predictData[,c("tradeItemId","item_gmv_sum_1day","item_click_pv_1day","item_book_pv_1day")]

	row1 <- order(targetData$item_gmv_sum_1day,decreasing=TRUE)[seq(1000)]
	row2 <- order(predictData$item_gmv_sum_1day,decreasing=TRUE)[seq(1000)]

	targetData <- targetData[row1,]

	predictData <- predictData[row2,]

	row <- targetData$tradeItemId %in% predictData$tradeItemId
	row <- !row

	
	sink("a.txt")
	print(summary(targetData[row,]))
	sink()

	row <- predictData$tradeItemId %in% targetData$tradeItemId
	row <- !row
	print(row)
	sink("b.txt")
	print(summary(predictData[row,]))
	sink()
}



args <- c("../data/20141105.clean","../data/20141104.pc.score")
#evaluateAppModel(args)
evaluatePCModel(args)
#evaluateTest(args)
