
#source("/home/zhiyuan/Projects/wltr/utils.R")

source("./utils.R")


readDataFromCSV <- function(filename) {
    return(read.table(filename,
                      sep=",",
                      na.strings = "NULL",
                      stringsAsFactors=FALSE,
                      header=TRUE))
}


readDataFromCSV1 <- function(filename) {
    return(read.table(filename,
                      sep=",",
                      na.strings = "NULL",
                      stringsAsFactors=FALSE,
                      header=FALSE))
}


distTarget <- function(srcFilename,dstFilename) {

	srcData <- ReadTxtData(srcFilename)
	dstData <- ReadTxtData(dstFilename,header=F)
	names(dstData) <- c("tradeItemId","rank")
	srcData <- srcData[,c("tradeItemId","shopId","item_book_pv_1day","item_click_pv_1day","item_gmv_sum_1day")]
#	dstData <- subset(dstData,y>0)
	dstData <- dstData[seq(300), ]
	df <- merge(srcData,dstData,by="tradeItemId")
#	print(df[ ,c("tradeItemId","shopId")])
	df$shopId <- as.factor(df$shopId)
	print(summary(df$shopId))
}

distCat <- function(filename,rankFile) {
	df <- readDataFromCSV(filename)
	ranks <- readDataFromCSV(rankFile)
	row <- order(ranks$score,decreasing=TRUE)
	ranks <- ranks[row,]
	ranks <- ranks[seq(100),c("tradeItemId","score")]
	df <- df[,c("tradeItemId","item_gmv_sum_1day_app","item_click_pv_1day_app",
			"item_book_pv_1day_app","item_book_pv_0day_app","item_click_pv_0day_app",
			"item_gmv_sum_0day_app")]
	df <- merge(df,ranks,by="tradeItemId")
	write.table(df,"a.txt",sep=",",row.names=FALSE)
}

distRankCat <- function(filename,filename1) {
	df <- readDataFromCSV(filename)
	df1 <- readDataFromCSV1(filename1)
	names(df1) <-c("tradeItemId","pcRank","appRank")
	row <- order(df1$appRank)
	df1 <- df1[row[seq(100)],]
	data <- merge(df1,df,by="tradeItemId")
	sink("b.txt")
	print(data[,c("tradeItemId","categoryIds","item_gmv_sum_1day_app")])
	sink()
	
#	cat <- as.factor(odf$categoryIds)
#	print(summary(cat))
}
#df <- distCat("../data/20141029.clean","../data/20141029.app.score")
#df <- distRankCat("../data/20141016.clean","../data/20141016.rank")

distTarget("../data/20141110.clean","../data/20141110.pc.rank")
