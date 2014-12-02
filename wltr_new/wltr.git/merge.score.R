


load.score.data <- function(score.file) {
	return(
	read.table(file=score.file,
			header=TRUE,
			sep=",",
			stringsAsFactors=FALSE)
	)
}



merge.score <- function(args) {
	
	gmv.score.file <- args[1]
	click.score.file <- args[2]
	score.file <- args[3]
	gmv.score.data <- load.score.data(gmv.score.file)
	gmv.score.data$gmvScore <- (gmv.score.data$score - min(gmv.score.data$score)) / (max(gmv.score.data$score) - min(gmv.score.data$score))
	

	click.score.data <- load.score.data(click.score.file)
	click.score.data$clickScore <- (click.score.data$score - min(click.score.data$score)) / (max(click.score.data$score) - min(click.score.data$score))

	score.data <- merge(gmv.score.data,click.score.data,by="tradeItemId")

	score.data$score <- 0.5 * score.data$gmvScore + 0.5 * score.data$clickScore
	score.data <- score.data[,c("itemInfoId.x","tradeItemId","score")]
	names(score.data) <- c("itemInfoId","tradeItemId","score")

	write.table(score.data,	file=score.file,sep=",",row.names=FALSE)
}
args <- commandArgs(TRUE)
merge.score(args)
