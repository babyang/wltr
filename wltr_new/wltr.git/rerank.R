# zhiyuan code using absolute folder name
# source("/home/zhiyuan/Projects/wltr/utils.R")
# source("/home/zhiyuan/Projects/wltr/punishScore.R")

# minxing code using relative folder name
#source("/home/minxing/projects/zhiyuan/wltr/utils.R")
#source("/home/minxing/projects/zhiyuan/wltr/punishScore.R")

source("./utils.R")
source("./punishScore.R")


RerankWithBusiness <- function(data.score,
		data.business,
		flag.business) {
	
	row.business <- data.business$type == flag.business
	id.business <- data.business$tradeItemId[row.business]

	row.business <- data.score$tradeItemId %in% id.business
	data.score <- data.score[row.business, ]

	row <- order(data.score$score,decreasing=T)
	data.score <- data.score[row,c("itemInfoId","tradeItemId")]

	data.score$rank <- seq(nrow(data.score))

	return(data.score[ ,c("tradeItemId","rank")])
}


PlaceRank <- function(data.score,
		data.business) {

	df <- merge(data.score,data.business,by="tradeItemId")
	
	row <- df$is1111 == 1 & df$rank < 100
	if (length(which(row))>0) {
	x <- df[row, ]$rank
	df[row, ]$rank <- ceiling((x - 1) * (80 - 1) / (100 - 1) + 1)
	}

	row <- df$is1111 == 1 & df$rank >= 100 & df$rank < 500
	if (length(which(row))>0) {
	x <- df[row, ]$rank
	df[row, ]$rank <- ceiling((x - 100) * (300 - 80) / (500 - 100) + 80)
	}


	row <- df$is1111 == 1 & df$rank < 1000 & df$rank >= 500
	if (length(which(row))>0) {
	x <- df[row, ]$rank
	df[row, ]$rank <- ceiling((x - 500) * (600 - 300) / (1000 - 500) + 300)
	}

	row <- df$is1111 == 1 & df$rank < 5000 & df$rank >= 1000
	if (length(which(row))>0) {
	x <- df[row, ]$rank
	df[row, ]$rank <- ceiling((x - 1000) * (2000 - 600) / (5000 - 1000) + 600)
	}

	row <- df$is1111 == 1 & df$rank < 10000 & df$rank >= 5000
	if (length(which(row))>0) {
	x <- df[row, ]$rank
	df[row, ]$rank <- ceiling((x - 5000) * (3000 - 2000) / (10000 - 5000) + 2000)
	}

	row <- df$is1111 == 1 & df$rank < 40000 & df$rank >= 10000
	if (length(which(row))>0) {
	x <- df[row, ]$rank
	df[row, ]$rank <- ceiling((x - 10000) * (5000 - 3000) / (50000 - 10000) + 3000)
	}

	row <- df$is1111 == 1 & df$rank >= 40000
	if (length(which(row))>0) {
	df[row, ]$rank <- 6000
	}
	return(df[ ,c("tradeItemId","rank")])
}

Rerank <- function(args) {

	file.score <- args[1]
	file.business <- args[2]
	file.rank <- args[3]
	pc.flag <- args[4]



	data.score <- ReadTxtData(file.score)

	data.business <- ReadTxtData(file.business)



#	score.onsale <- RerankWithBusiness(data.score,
#			data.business,
#			"onSale")

	score.relyou <- RerankWithBusiness(data.score,
			data.business,
			"relYou")

	score.norm <- RerankWithBusiness(data.score,
			data.business,
			"norm")
#	score.relyou$rank <- score.relyou$rank + max(score.onsale$rank)
	score.norm$rank <- score.norm$rank + max(score.relyou$rank)
#	data.rank <- rbind(score.onsale,score.relyou,score.norm)
	data.rank <- rbind(score.relyou,score.norm)
#	data.rank <- PlaceRank(data.rank,data.business)
	data.rank <- PunishShop(data.business,data.rank)
	data.rank <- PunishItemScore(data.business,data.rank)
	row <- order(data.rank$rank,decreasing=F)
	data.rank <- data.rank[row, ]
	SaveTxtData(data.rank,file.rank,col.names=F)
}


args <- commandArgs(TRUE)
Rerank(args)
