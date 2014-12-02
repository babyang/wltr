source("env.setting.R")
source("utils.R")
require(ggplot2)


get.tag.data <- function(date) {
	filename <- paste(date,'tag',sep=".")
	filename <- paste('../data',filename,sep="/")
	df <- read.table(file=filename,
			header=TRUE,
			sep=",",
			stringsAsFactors=FALSE)
	return(df)
}

evaluate.type <- function(src.filename,
        predict.filename) {
    df.src <- get.data.from.file(src.filename)
    df.predict <- get.data.from.file(predict.filename,',')
	df.type <- get.tag.data(predict.filename)
	df.type <- df.type[df.type$cat=='yifu' & df.type$type=="relYou",]
    df.src <- df.src[,c("tradeItemId","item_gmv_sum_1day")]
    order.src <- order(df.src$item_gmv_sum_1day,decreasing=TRUE)[seq(500)]
    df.src <- df.src[order.src,]
    df <- merge(df.src,df.type,by="tradeItemId")
    print(df[,c("tradeItemId","type","cat")])
}

evaluate.model <- function(src.filename,
        predict.filename) {
    df.src <- get.data.from.file(src.filename)
    df.predict <- get.data.from.file(predict.filename,',')
    df.src <- df.src[df.src$relYou>0,c("tradeItemId","item_gmv_sum_1day")]
    order.src <- order(df.src$item_gmv_sum_1day,decreasing=TRUE)[seq(1000)]
	df.predict <- df.predict[seq(1000),]
    df.src <- df.src[order.src,]
    df <- merge(df.src,df.predict,by="tradeItemId")
    print(nrow(df[,c("tradeItemId","rank")]))
}

evaluate.style <- function(src.filename,
        predict.filename) {
    df.src <- get.data.from.file(src.filename)
    df.predict <- get.data.from.file(predict.filename,',')
	df.src$style <- "style"

	styles <- style.profile.factors
		test <- df.src[df.src$relYou>0,]

	test$tag <- 0
	for ( col in styles ) {
		row <- test[,col]==1
		test$tag[row] <- 1
	}

	test$tag <- as.factor(test$tag)
	print(summary(test$tag))


    df.src <- df.src[df.src$relYou>0,c("tradeItemId","item_gmv_sum_1day","style")]
    df <- merge(df.src,df.predict,by="tradeItemId")
    df <- df[,c("tradeItemId","style","item_gmv_sum_1day","rank")]
    order.src <- order(df$item_gmv_sum_1day,decreasing=TRUE)
    df <- df[order.src,]
	write.table(df,file="style.dist",sep=",",row.names=FALSE)
}

evaluate.attr <- function(src.filename,
        predict.filename) {
    df.src <- get.data.from.file(src.filename)
    df.predict <- get.data.from.file(predict.filename,',')
    df.src <- df.src[,c("tradeItemId","shopId","categoryIds")]
    df.predict <- df.predict[,c("itemInfoId","tradeItemId","X1")]
    order.predict <- order(df.predict$X1,decreasing=TRUE)[c(1:300)]
    df.predict <- df.predict[order.predict,]
    df <- merge(df.src,df.predict,by="tradeItemId")
    df$shopId <- as.factor(df$shopId)
    df$categoryIds <- as.factor(df$categoryIds)
    p <- ggplot(df, aes(x=shopId, y=..count..,fill=shopId ) ) +
    geom_histogram( binwidth=1 ) +
     horzi_theme
     ggsave("../data/shop.png",p)

    p <- ggplot(df, aes(x=categoryIds, y=..count..,fill=categoryIds ) ) +
    geom_histogram( binwidth=1 ) +
     horzi_theme
     ggsave("../data/cate.png",p)
}

#evaluate.model("2014092618","2014092616.rank")
evaluate.model("20140929","20140928.gmv.rank")
evaluate.model("20140929","20140928.click.rank")
evaluate.model("20140929","20140928.rank")
#evaluate.style("2014092618","2014092616.rank")
#evaluate.type("20140912","20140911")
