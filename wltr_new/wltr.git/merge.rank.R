

get.score.df <- function(date) {
	
	rank.file <- get.filename("score",date)
	rank.df <- read.table(file=rank.file,
			sep=",",
			header=TRUE,
			stringsAsFactors=FALSE)
	return(rank.df)
}


load.tag.data <- function(tag.file) {
	return(
	read.table(file=tag.file,
			header=TRUE,
			sep=",",
			stringsAsFactors=FALSE)
	)
}


load.score.data <- function(score.file) {
	return(
	read.table(file=score.file,
			header=TRUE,
			sep=",",
			stringsAsFactors=FALSE)
	)
}


merge.norm <- function(tag.file,score.file) {
	tag.df <- load.tag.data(tag.file)
	tag.df <- subset(tag.df,type=="norm")
	score.df <-  load.score.data(score.file)
	score.df <- merge(score.df,tag.df,by="tradeItemId")

	row <- order(score.df$score ,decreasing=TRUE)

	score.df <- score.df[row,c("itemInfoId","tradeItemId")]
	score.df$rank <- seq(nrow(score.df))
	return(score.df[,c("tradeItemId","rank")])
}


merge.onsale <- function(tag.file,score.file) {

	score.df <-  load.score.data(score.file)
	tag.df <- load.tag.data(tag.file)
	tag.df <- subset(tag.df,type=="onSale")


	score.df <- merge(score.df,tag.df,by="tradeItemId")
	row <- order(score.df$score ,decreasing=TRUE)
	score.df <- score.df[row,]
	score.df$rank <- seq(nrow(score.df))
	score.df <- score.df[,c("tradeItemId","rank")]
	return(score.df)
}

merge.relYou <- function(tag.file,score.file) {

	score.df <-  load.score.data(score.file)
	tag.df <- load.tag.data(tag.file)
	tag.df <- subset(tag.df,type=="relYou")


	score.df <- merge(score.df,tag.df,by="tradeItemId")
	row <- order(score.df$score ,decreasing=TRUE)
	score.df <- score.df[row,]
	score.df$rank <- seq(nrow(score.df))
	score.df <- score.df[,c("tradeItemId","rank")]
	return(score.df)
}

merge.rank <- function(args) {
	tag.file <- args[1]
	score.file <- args[2]
	rank.file <- args[3]

	onsale.rank <- merge.onsale(tag.file,score.file)
	relyou.rank <- merge.relYou(tag.file,score.file)
	norm.rank <- merge.norm(tag.file,score.file)

	step <- max(onsale.rank$rank)
	relyou.rank$rank <- relyou.rank$rank + step
	step <- max(relyou.rank$rank)
	norm.rank$rank <- norm.rank$rank + step 
	merge.df <- rbind(onsale.rank,relyou.rank,norm.rank)

	write.table(merge.df,
			file=rank.file,
			sep=",",
			row.names=FALSE,
			col.names=FALSE)
}


args <- commandArgs(TRUE)
merge.rank(args)
