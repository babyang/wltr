# learning to rank ml system
# author zhiyuan@mogujie.com
# create 20140731

library(glmnet)

#source("/home/zhiyuan/l2r/R/env.setting.R")
#source("/home/zhiyuan/l2r/R/utils.R")

source("./env.setting.R")
source("./utils.R")


load.model <- function(model.file) {
	return(read.table(model.file,
				sep=",",
				header=TRUE,
				stringsAsFactors=FALSE
			)
		  )
}

load.test.data <- function(test.file) {
	return(read.table(test.file,
				sep=",",
				header=TRUE,
				stringsAsFactors=FALSE
			)
		  )
	
}



ridge.predict <- function(args) {

	test.file <- args[1]
	model.file <- args[2]
	score.file <- args[3]

	model <- load.model(model.file)
	test.data <- load.test.data(test.file)
	test <- test.data[,c(-1,-2)]

	alpha <- model$coef[c(-1)]
	beta <- model$coef[c(1)]
	print(ncol(test))
	print(length(alpha))
	score <- apply(alpha*t(test),2,sum) + beta

	score.data <- data.frame(test.data,score=score)
	score.data <- score.data[,c("itemInfoId","tradeItemId","score")]
    row <- order(score.data$score,decreasing=TRUE)
	score.data <- score.data[row,]

    write.table(score.data,sep=",",file=score.file,row.names=FALSE)
}

args <- commandArgs(TRUE)
ridge.predict(args)
