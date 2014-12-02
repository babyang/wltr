source("utils.R")
require(ggplot2)


EvaluatePCModel <- function(args) {

	file.clean <- args[1]
	file.score <- args[2]
	file.business <- args[3]

	data.score <- ReadTxtData(file.score,header=F)
	names(data.score) <- c("tradeItemId","rank")
	data.business <- ReadTxtData(file.business)
	data.clean <- ReadTxtData(file.clean)

	data.business <- subset(data.business,type!="norm")
	id.business <- data.score$tradeItemId %in% data.business$tradeItemId 

	data.score <- data.score[id.business, ]
	row <- order(data.score$rank,decreasing=F)
	data.score <- data.score[row[seq(1000)], ]

	id.business <- data.clean$tradeItemId %in% data.business$tradeItemId 
	data.clean <- data.clean[id.business, ]
	row <- order(data.clean$item_gmv_sum_1day,decreasing=T)
	data.clean <- data.clean[row[seq(1000)], ]


	data.join <- merge(data.clean,data.score,by="tradeItemId")
	print(nrow(data.join))
}



EvaluateAppModel <- function(args) {

	file.clean <- args[1]
	file.score <- args[2]
	file.business <- args[3]

	data.score <- ReadTxtData(file.score,header=F)
	names(data.score) <- c("tradeItemId","rank")
	data.business <- ReadTxtData(file.business)
	data.clean <- ReadTxtData(file.clean)

	data.business <- subset(data.business,type!="norm")
	id.business <- data.score$tradeItemId %in% data.business$tradeItemId 

	data.score <- data.score[id.business, ]
	row <- order(data.score$rank,decreasing=F)
	data.score <- data.score[row[seq(1000)], ]

	id.business <- data.clean$tradeItemId %in% data.business$tradeItemId 
	data.clean <- data.clean[id.business, ]
	row <- order(data.clean$item_gmv_sum_1day_app,decreasing=T)
	data.clean <- data.clean[row[seq(1000)], ]


	data.join <- merge(data.clean,data.score,by="tradeItemId")
	print(nrow(data.join))
}


args <- c("../data/20141115.clean","../data/20141114.app.rank","../data/20141114.buss")
EvaluateAppModel(args)
#args <- c("../data/20141107.clean","../data/20141106.pc.rank","../data/20141106.buss")
#EvaluatePCModel(args)
#evaluateTest(args)
