# zhiyuan code using his folder name
#source("/home/zhiyuan/Projects/wltr/env_setting.R")

# minxing code using his folder name
#source("/home/minxing/projects/zhiyuan/wltr/env_setting.R")

source("./env_setting.R")


ReadGroupItems <- function(filename="/home/minxing/projects/zhiyuan/wltr/group.txt") {
	
	group.line <- readLines(filename)
	group.list <- unlist(strsplit(group.line[[1]],split=","))
	return(group.list)
}

BuildBusinessLayer <- function(df) {
	# 生成业务层数据标签
	# Args :
	#	df 数据框	
	#	file.business  保存业务层数据
	

	row.relyou <- df$relYou > 0	# 优选

	row.mianjian <- df$relYou2 == -1  #未送检
	row.mianjian <- (df$ismjshop == 1 & row.mianjian)
	
	row.relyou <- row.relyou | row.mianjian

#	row.onsale <- df$onsale_it == 1

	df$type <- ""
	df$type[row.relyou] <- "relYou"
	df$type[!row.relyou] <- "norm"
#	df$type[row.onsale] <- "onSale"

#	group.list <- ReadGroupItems()
#	row <- df$tradeItemId %in% group.list
#	df$type[row] <- "onSale"

	df <- df[ ,c("tradeItemId","type","scale","shopId")]
	return(df)
}
