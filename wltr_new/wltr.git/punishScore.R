library(plyr)
#对scale字段小于100的商品score进行惩罚
#输入参数 1.商品信息数据框(包括ItemInfoId，tradeItemId，gmv，pv等) 2.商品的score数据框(包括ItemInfoId,tradeItemId,score)
#输出参数 惩罚后的商品score数据框(包括ItemInfoId,tradeItemId,score)

PunishShop <- function(data.business,
						data.score) {
	data.scores <- merge(data.business,data.score[seq(300), ],by="tradeItemId")
	data.scores <- ddply(data.scores,.(shopId),transform,count=length(rank))

	row <- data.scores$count > 20
	if (length(which(row)) > 0 ) {
		print("作弊卖家商品")
		row.punish <- data.score$tradeItemId %in% data.scores[row, ]$tradeItemId

		data.score$rank[row.punish] <- data.score$rank[row.punish] + 500
		print(data.score$tradeItemId[row.punish])
	}
	
	return(data.score[ ,c("tradeItemId","rank")])

}
PunishItemScore <- function(data.business,score.df) {

	score.df <- merge(score.df,data.business,by="tradeItemId")
# all.score <- merge(df,score.df,by="tradeItemId")
	
#  all.score$item_gmv_sum_0day_app <- log(all.score$item_gmv_sum_0day_app+1)
#  score.min <- min(all.score$score)
  
#  a <- 10
#  b <- mean(all.score$item_gmv_sum_0day_app)
  
#  all.score.punish <- all.score[which(all.score$scale>0),]
#  weight <- 1/(1+exp(a*(b-all.score.punish$item_gmv_sum_0day_app)))
  
#  all.score.punish <- (all.score.punish$score-score.min)*weight+score.min
  
#  all.score[which(all.score$scale>0),]$score <- all.score.punish
  
# final.data <- data.frame(all.score$itemInfoId,all.score$tradeItemId,all.score$score)
#  colnames(final.data) <- c("itemInfoId","tradeItemId","score")

 score.df$rank <- score.df$rank + 100.0 * score.df$scale
  
  return(score.df[ ,c("tradeItemId","rank")])
}


punishPCScore <- function(df,score.df) {
  all.score <- merge(df,score.df,by="tradeItemId")
  all.score$item_gmv_sum_0day <- log(all.score$item_gmv_sum_0day+1)
  score.min <- min(all.score$score)
  
  a <- 10
  b <- mean(all.score$item_gmv_sum_0day)
  
  all.score.punish <- all.score[which(all.score$scale>0),]
  weight <- 1/(1+exp(a*(b-all.score.punish$item_gmv_sum_0day)))
  
  all.score.punish <- (all.score.punish$score-score.min)*weight+score.min
  
  all.score[which(all.score$scale>0),]$score <- all.score.punish
  
  final.data <- data.frame(all.score$itemInfoId,all.score$tradeItemId,all.score$score)
  colnames(final.data) <- c("itemInfoId","tradeItemId","score")
  
  return(final.data)
}
