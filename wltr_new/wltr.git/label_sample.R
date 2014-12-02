# zhiyuan code using absolute code
# source("/home/zhiyuan/Projects/wltr/utils.R")

# minxing code using his code
source("./utils.R")


LabelPCSample <- function(df) {
    df <- subset(df,item_book_pv_1day>0)
	print(nrow(df))
#	df$item_click_pv_1day <- as.numeric(df$item_click_pv_1day)
#	df$item_book_pv_1day <- as.numeric(df$item_book_pv_1day)
#	df$item_gmv_sum_1day <- as.numeric(df$item_gmv_sum_1day)

	C <- sum(df$item_click_pv_1day) / sum(df$item_book_pv_1day)

	row <- order(df$item_book_pv_1day,decreasing=T)
	M <- df$item_book_pv_1day[row[1000]]
	df$ctr <- df$item_click_pv_1day / df$item_book_pv_1day
	df$ctr <- df$item_book_pv_1day * df$ctr / (df$item_book_pv_1day + M) 
	df$ctr <- df$ctr + M * C / (df$item_book_pv_1day + M) 

    
    row <- order(df$ctr * df$item_gmv_sum_1day ,decreasing=TRUE)
    df <- df[row,]
	df$y[seq(nrow(df))] <- 0
    df$y[seq(500)] <- 1
    
    df <- df[,c("tradeItemId","y")]
    return(df)
}




LabelAPPSample <- function(df) {
    df <- subset(df,item_book_pv_1day_app>0)
#	df$item_click_pv_1day_app <- as.numeric(df$item_click_pv_1day_app)
#	df$item_book_pv_1day_app <- as.numeric(df$item_book_pv_1day_app)
#	df$item_gmv_sum_1day_app <- as.numeric(df$item_gmv_sum_1day_app)

	C <- sum(df$item_click_pv_1day_app) / sum(df$item_book_pv_1day_app)

	row <- order(df$item_book_pv_1day_app,decreasing=TRUE)
	M <- df$item_book_pv_1day_app[row[1000]]

	df$ctr <- df$item_click_pv_1day_app / df$item_book_pv_1day_app
	df$ctr <- df$item_book_pv_1day_app * df$ctr / (df$item_book_pv_1day_app + M) 
	df$ctr <- df$ctr + M * C / (df$item_book_pv_1day_app + M) 

    
    row <- order(df$ctr * df$item_gmv_sum_1day_app ,decreasing=TRUE)
    df <- df[row,]
	df$y <- 0
    df$y[seq(500)] <- 1
    
    
    df <- df[,c("tradeItemId","y")]
    return(df)
}

LabelSample <- function(args) {

	file.clean <- args[1]
	file.pc.label <- args[2]
	file.app.label <- args[3]
    
  
	df <- ReadTxtData(file.clean)
	print(nrow(df))
	sample.pc.label <- LabelPCSample(df)
	SaveTxtData(sample.pc.label,file.pc.label)
	sample.app.label <- LabelAPPSample(df)
	SaveTxtData(sample.app.label,file.app.label)
}


args <- commandArgs(TRUE)
LabelSample(args)
