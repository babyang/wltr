# learning to rank ml system
# author zhiyuan@mogujie.com
# create 20140731

library(glmnet)
# zhiyuan code using absolute folder name
#source("/home/zhiyuan/Projects/wltr/utils.R")

# minxing code using his folder name
#source("/home/minxing/projects/zhiyuan/wltr/utils.R")

source("./utils.R")



LoadLRModel <- function(model.file) {
	model <- read.table(model.file,
				sep=":",
				header=FALSE,
				stringsAsFactors=FALSE
			)
		  
	names(model) <- c("feature","coef")
	return(model)
}

readDataFromCSV <- function(filename) {
    return(read.table(filename,
                      sep=",",
                      na.strings = "NULL",
                      stringsAsFactors=FALSE,
                      header=TRUE))
}




PredictWithLR <- function(args) {

	file.test <- args[1]
	file.model <- args[2]
	file.score <- args[3]

	model <- ReadTxtData(file.model)
	data.test <- ReadTxtData(file.test)
	X <- data.test[ ,c(-1,-2)]

	w <- model$coef[c(-1)]
	b <- model$coef[c(1)]


	score <- apply(w * t(X),2,sum) + b

	data.score <- data.frame(data.test,score=score)
	data.score <- data.score[ ,c("itemInfoId","tradeItemId","score")]
    row <- order(data.score$score,decreasing=T)
	data.score <- data.score[row,]
	SaveTxtData(data.score,file.score)
}

args <- commandArgs(TRUE)
PredictWithLR(args)
