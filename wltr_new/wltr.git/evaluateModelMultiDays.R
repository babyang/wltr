source("env.setting.R")
source("utils.R")
require(ggplot2)
#本脚本用于进行统计多日的模型离线效果-包括模型的准确率以及top1000商品gmv占比
#输入：1.模型数据存储的路径，如:/home/zhouge/Projects/wltr/data/ 2.统计结果存储文件
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
                      header=FALSE)

		names(rankData) <-c("tradeItemId","rank")
		return(rankData)
}
#评估模型输出结果top1000商品gmv占比
evaluateModelGmvRate <- function(args) {
	targetFilename <- args[1]
	predictFilename <- args[2]
	targetData <- readDataFromCSV(targetFilename)
	predictData <- readRankFromCSV(predictFilename)
	targetData <- subset(targetData,targetData$relYou>0)
	targetData <- targetData[,c("tradeItemId","item_gmv_sum_1day_app")]
	totalGmv <- sum(targetData$item_gmv_sum_1day_app)

	predictData <- predictData[seq(1000),]
   	predictGmvData <- merge(targetData,predictData,by="tradeItemId")
	predictGmv <- sum(predictGmvData$item_gmv_sum_1day_app)

	print(paste(targetFilename,predictGmv,sep=" "))
	rate <- predictGmv/totalGmv*100

	return(rate)
}

#评估模型输出结果top1000商品与实际top1000商品重合度,即准确度
evaluateModelItemRate <- function(args){
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
    	return(nrow(joinData)/nrow(predictData))
}

args<-commandArgs(TRUE)
stat.date <- c("20141021","20141022","20141023")
stat.num <- c(1:length(stat.date))*0+num
stat.frame <- data.frame(stat.num,stat.date)
for.date <- c("20141020",stat.date)
stat.rate <- c()
i <- length(for.date)
dir <- args[1]
file <- args[0]
while(i > 1){
  targetFilename <- paste(dir,for.date[i],".clean",sep="")
  predictFilename <- paste(dir,for.date[i-1],".app.rank",sep="")
  i <- i-1
  args <- c(targetFilename,predictFilename,num)
  rate <- evaluateAppModel(args)
  stat.rate <- c(rate,stat.rate) 
}
stat.frame <- data.frame(stat.frame,stat.rate)
write.table(stat.frame,file)
