

get.type <- function(date) {
	type.file <- paste(date,"tag",sep=".")
	type.file <- paste("../data",type.file,sep="/")
	df <- read.table(type.file,sep=",",header=TRUE)
	return(df)
}


get.rank <- function(date) {
	type.file <- paste(date,"rank",sep=".")
	type.file <- paste("../data",type.file,sep="/")
	df <- read.table(type.file,sep=",",header=TRUE)
	return(df)
}


get.data <- function(date) {
	type.file <- paste(date,"clean",sep=".")
	type.file <- paste("../data",type.file,sep="/")
	df <- read.table(type.file,sep=",",header=TRUE,stringsAsFactors=FALSE)
	return(df)
}

get.feature <- function(date) {
	type.file <- paste(date,"feature",sep=".")
	type.file <- paste("../data",type.file,sep="/")
	df <- read.table(type.file,sep=",",header=TRUE,stringsAsFactors=FALSE)
	return(df)
}


combine.col <- function(date) {
	type.dat <- get.type(date)
	rank.dat <- get.rank(date)
	col.dat <- get.data(date)
	feature.dat <- get.feature(date)
	type.dat <- type.dat[type.dat$type=="relYou",]
	col.dat <- merge(type.dat,col.dat,by="tradeItemId")
	df <- merge(col.dat,rank.dat,by="tradeItemId")
	row <- order(df$rank)
	df <- df[row,c("tradeItemId","item_book_pv_0day","item_click_pv_0day","item_gmv_sum_0day","cat","rank")]
	write.table(df,file="data.check",sep=",",row.names=FALSE)
}


gmv.check <- function(date) {
	type.dat <- get.type(date)
	rank.dat <- get.rank(date)
	col.dat <- get.data(date)
	feature.dat <- get.feature(date)
	feature.dat <- feature.dat[,c("tradeItemId","book.pv","detail.pv","gmv.sum","gmv.count")]
	relyou.dat <- type.dat[type.dat$type=="relYou",]
	relyou.dat <- merge(relyou.dat,col.dat,by="tradeItemId")
	df <- merge(relyou.dat,rank.dat,by="tradeItemId")
	df <- merge(df,feature.dat,by="tradeItemId")
	print(names(df))
	row <- order(df$item_gmv_sum_0day,decreasing=TRUE)
	df <- df[row,c("tradeItemId","item_book_pv_0day","item_click_pv_0day","item_gmv_sum_0day","gmv.sum","book.pv","detail.pv",
			"gmv.sum","gmv.count","cat","rank")]
	write.table(df,file="relyou.check",sep=",",row.names=FALSE)
	jing.dat <- type.dat[type.dat$type=="jing",]
	jing.dat <- merge(jing.dat,col.dat,by="tradeItemId")
	df <- merge(jing.dat,rank.dat,by="tradeItemId")
	df <- merge(df,feature.dat,by="tradeItemId")
	row <- order(df$item_gmv_sum_0day,decreasing=TRUE)
	df <- df[row,c("tradeItemId","item_book_pv_0day","item_click_pv_0day","item_gmv_sum_0day","gmv.sum","book.pv","detail.pv",
			"gmv.sum","gmv.count","cat","rank")]
	write.table(df,file="jing.check",sep=",",row.names=FALSE)
	norm.dat <- type.dat[type.dat$type=="norm",]
	norm.dat <- merge(norm.dat,col.dat,by="tradeItemId")
	df <- merge(norm.dat,rank.dat,by="tradeItemId")
	df <- merge(df,feature.dat,by="tradeItemId")
	row <- order(df$item_gmv_sum_0day,decreasing=TRUE)
	df <- df[row,c("tradeItemId","item_book_pv_0day","item_click_pv_0day","item_gmv_sum_0day","gmv.sum","book.pv","detail.pv",
			"gmv.sum","gmv.count","cat","rank")]
	write.table(df,file="norm.check",sep=",",row.names=FALSE)
}
gmv.check("20140926")

