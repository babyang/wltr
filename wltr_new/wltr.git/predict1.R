# learning to rank ml system
# author zhiyuan@mogujie.com
# create 20140731

library(glmnet)
#source("/home/zhiyuan/Projects/wltr/utils.R")

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





PredictWithLR <- function(args) {

	file.test <- args[1]
	file.model <- args[2]
	file.score <- args[3]

	print(file.model)
	model <- ReadTxtData(file.model)
	print("hello")
	data.test <- ReadTxtData(file.test)
	print("world")
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
