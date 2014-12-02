# zhiyuan code using his folder name
#source("/home/zhiyuan/Projects/wltr/env_setting.R")
#source("/home/zhiyuan/Projects/wltr/alarm_sms.R")

#source("/home/minxing/projects/zhiyuan/wltr/env_setting.R")
#source("//home/minxing/projects/zhiyuan/wltr/alarm_sms.R")

source("./env_setting.R")
source("./alarm_sms.R")


CheckCol <- function(col,df) {
	# 检查动态列是否合法，如果有小于0或者全列为0
	# 抛出异常
	# Args:
	#	col 要检查处理的列
	#	df 要检查的数据框
	#	
	sets <- names(df) %in% col
	if (length(which(sets)) == 0 ) {
		msg <- paste(col,"字段不存在!")
		SendSMS(msg)
	}
	if (length(which(df[ ,col]<0)) > 0 ) {
		msg <- paste(col,"有小于0值存在")
		SendSMS(msg)
		stop("low zero error")
	}
	if (sum(as.numeric(df[ ,col])) <= 0 ) {
		msg <- paste(col,"全部为0")
		SendSMS(msg)
		stop("low zero error")
	}
	return(0)
}


CheckCols <- function(df) {
	status <- lapply(check.cols,CheckCol,df)	
	if (sum(unlist(status))==0) {
		print("col staus is ok")
	}
}


CheckRelYou2 <- function(df) {
	# 检查RelYou2是否合法，relyou2代表是否优选审核
	# 小于0表示未审核，检查审核商品个数合理
	# Args:
	#	col 要检查处理的列
	#	df 要检查的数据框
	#	
	if ( nrow( subset(df,relYou2 != -1 ) ) < valid.size ) {
		SendSMS( "relYou2 审核商品太少")
		stop( "relYou2 invalid 2")
	}
	if ( nrow( subset(df,relYou2 == -1 ) ) < valid.size ) {
		SendSMS( "relYou2 未审核商品数太少")
		stop( "relYou2 invalid 2")
	}
}


CheckRelYou <- function(df) {
	# 检查RelYou是否合法，relyou代表优选商品标签
	# 小于0表示未审核，检查优选商品个数合理
	# Args:
	#	col 要检查处理的列
	#	df 要检查的数据框
	#	
	if ( nrow( subset(df,relYou>0) ) < valid.size ) {
		SendSMS( "relYou invalid 1")
		stop( "relYou invalid 1")
	}

	if ( nrow( subset(df,relYou<=0) ) < valid.size ) {
		SendSMS( "relYou invalid 2")
		stop( "relYou invalid 2")
	}
}


CheckScale <- function(df) {
	# 检查scale是否合法，scale代表商品作弊分数
	# 小于0或者大于100都不合理
	# Args:
	#	
	#
	#	
	if ( nrow( subset( df,scale < 0 ) ) > 0) {
		SendSMS( "scale less than 0")
		stop( "scle less than 0" )
	}
	if ( nrow( subset( df,scale > 100 ) ) > 0) {
		SendSMS( "scale larger than 100")
		stop( "scle larger than 100" )
	}
}


CheckMJ <- function(df) {
	# 检查ismjshop是否合法，ismjshop代表商品是否属于免检
	# 免检商品数目是否合理
	# Args:
	#	
	#
	#	
	if ( nrow( subset( df,ismjshop == 1 ) ) <= 0 ) {
		SendSMS( "mj shop invalid")
		stop(" mj shop invalid " )
	}
}

CheckOnSale <- function(df) {
	# 检查onSale是否合法，onSale代表商品是否搞活动商品
	# 搞活动商品的数目是否合理
	# Args:
	#	
	#
	#	
	if ( nrow( subset( df,onsale_it == 1) ) <= 0 ) {
		SendSMS( "sale invalid")
		stop(" sale invalid ")
	}
}


CheckPrice <- function(df) {
	# 检查price是否合法，price代表商品价格
	# 搞活动商品的价格是否合理
	# Args:
	#	
	#
	#	
	if ( nrow( subset( df,price < 0) ) > 0 ) {
		SendSMS( "price invalid")
		stop( "price invalide " )
	}
}


CheckRaw <- function(df) {
	CheckCols(df)
	CheckRelYou2(df)
	CheckRelYou(df)
	CheckScale(df)
	CheckMJ(df)
	#CheckOnSale(df)
	CheckPrice(df)
}

