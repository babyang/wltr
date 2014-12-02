#source("/home/zhiyuan/l2r/R/utils.R")
source("./utils.R")


optimize.gmv.ctr <- function(df,file.target) {
	
df <- subset(df,item_book_pv_1day>0)
	df$ctr <- (df$item_gmv_sum_1day )/ (df$item_book_pv_1day+10000)
	df$y <- 0

	row <- order(df$ctr,decreasing=TRUE)
	df <- df[row,]
	df$y[seq(500)] <- 1

	df <- df[,c("tradeItemId","y")]
	write.table(df,file.target,sep=",",row.names=FALSE)
}

optimize.detail.ctr <- function(df,file.target) {
	
	df <- subset(df,item_book_pv_1day>0)
	df$ctr <- (df$item_click_pv_1day )/ (df$item_book_pv_1day+10000)
	df$y <- 0

	row <- order(df$ctr,decreasing=TRUE)
	df <- df[row,]
	df$y[seq(500)] <- 1

	df <- df[,c("tradeItemId","y")]
	write.table(df,file.target,sep=",",row.names=FALSE)
}

optimize.gmv <- function(df,file.target) {
	df <- subset(df,item_book_pv_1day>0)
	df$ctr <- df$item_gmv_sum_1day / df$item_book_pv_1day
	df$y <- 0

#	data <- subset(df,item_book_pv_1day<100 )
#	data <- subset(data,item_gmv_sum_1day>0)
#	beta  <- sum(data$item_gmv_sum_1day) / sum(data$item_book_pv_1day)
#	row <- df$item_book_pv_1day > 0 & df$item_book_pv_1day < 100 & df$ctr > 2 * beta
#	df$y[row] <- 1

	data <- subset(df,item_book_pv_1day<1000 & item_book_pv_1day>=100)
	data <- subset(data,item_gmv_sum_1day>0)
	beta  <- sum(data$item_gmv_sum_1day) / sum(data$item_book_pv_1day)
	row <- df$item_book_pv >= 100 & df$item_book_pv_1day < 1000 & df$ctr > 2 * beta
	df$y[row] <- 1


	data <- subset(df,item_book_pv_1day>=1000 & item_book_pv_1day < 10000)
	data <- subset(data,item_gmv_sum_1day>0)
	beta  <- sum(data$item_gmv_sum_1day) / sum(data$item_book_pv_1day)
	row <- df$item_book_pv_1day < 10000 & df$item_book_pv_1day >= 1000 & df$ctr > 2 * beta
	df$y[row] <- 1

	data <- subset(df,item_book_pv_1day>=10000 & item_book_pv_1day < 100000)
	data <- subset(data,item_gmv_sum_1day>0)
	beta  <- sum(data$item_gmv_sum_1day) / sum(data$item_book_pv_1day)
	row <- df$item_book_pv_1day < 100000 & df$item_book_pv_1day >= 10000 & df$ctr > 2 * beta
	df$y[row] <- 1

	data <- subset(df,item_book_pv_1day>=100000)
	data <- subset(data,item_gmv_sum_1day>0)
	beta  <- sum(data$item_gmv_sum_1day) / sum(data$item_book_pv_1day)
	row <- df$item_book_pv_1day >= 100000 & df$ctr > 2 * beta
	df$y[row] <- 1

	df <- df[,c("tradeItemId","y")]


	write.table(df,file.target,sep=",",row.names=FALSE)
}

optimize.click <- function(df,file.target) {
	df <- subset(df,item_book_pv_1day>0)
	df$ctr <- df$item_click_pv_1day / df$item_book_pv_1day
	df$y <- 0

#	data <- subset(df,item_book_pv_1day<100)
#	data <- subset(data,item_click_pv_1day>0)
#	beta  <- sum(data$item_click_pv_1day) / sum(data$item_book_pv_1day)
#	row <- df$item_click_pv_1day < 100 & df$ctr > 2*beta
#	df$y[row] <- 1


	data <- subset(df,item_book_pv_1day<1000 & item_book_pv_1day >= 100)
	data <- subset(data,item_click_pv_1day>0)
	beta  <- sum(data$item_click_pv_1day) / sum(data$item_book_pv_1day)
	row <- df$item_click_pv_1day < 1000 & df$ctr > 2*beta & df$item_click_pv_1day >= 100
	df$y[row] <- 1
	print(beta)


	data <- subset(df,item_book_pv_1day>=1000 & item_book_pv_1day < 10000)
	data <- subset(data,item_click_pv_1day>0)
	beta  <- sum(data$item_click_pv_1day) / sum(data$item_book_pv_1day)
	row <- df$item_book_pv_1day < 10000 & df$item_book_pv_1day >= 1000 & df$ctr > 2*beta
	df$y[row] <- 1
	print(beta)

	data <- subset(df,item_book_pv_1day>=10000 & item_book_pv_1day < 100000)
	data <- subset(data,item_click_pv_1day>0)
	beta  <- sum(data$item_click_pv_1day) / sum(data$item_book_pv_1day)
	row <- df$item_book_pv_1day < 100000 & df$item_book_pv_1day >= 10000 & df$ctr > 2*beta
	df$y[row] <- 1
	print(beta)

	data <- subset(df,item_book_pv_1day>=100000)
	data <- subset(data,item_click_pv_1day>0)
	beta  <- sum(data$item_click_pv_1day) / sum(data$item_book_pv_1day)
	row <- df$item_book_pv_1day >= 100000 & df$ctr > 2*beta
	df$y[row] <- 1

	df <- df[,c("tradeItemId","y")]
	write.table(df,file.target,sep=",",row.names=FALSE)
}

optimize.target <- function(args) {
	file.source <- args[1]
	file.gmv.target <- args[2]
	file.click.target <- args[3]

	df.target <- read.table(file.source,
			sep=",",
			header=TRUE,
			stringsAsFactors=FALSE)

	optimize.gmv.ctr(df.target,file.gmv.target)
	optimize.detail.ctr(df.target,file.click.target)
}


args <- commandArgs(TRUE)
optimize.target(args)
