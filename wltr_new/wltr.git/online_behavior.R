


DecayBehavieFeature <- function(df) {
	T <- unclass(as.POSIXlt(Sys.time()))
	t <-  T$hour / 12 + T$min / 7200 
	decay.factor <- ifelse(t<=0.7 ,1.0 ,1.0 / ( 1.0 + exp(t - 1) ))
	return(decay.factor)
}




OnlineFeature <- function(df,decay,flag.test) {
	decay.factor <- 1.0
	if (decay == T ) decay.factor <- DecayBehavieFeature(df)
	test.factor <- 0.0
	if (flag.test==T) test.factor <- 1.0
	
	
    df$pc.book <- decay.factor * df$pc.book  + test.factor * exp(1)*df$item_book_pv_0day
	df$pc.click <- decay.factor * df$pc.click  + test.factor * exp(1)*df$item_click_pv_0day
    df$pc.gmv <- decay.factor * df$pc.gmv  + test.factor *  0.01*exp(1)*df$item_gmv_sum_0day
    df$pc.order <- decay.factor * df$pc.order  + test.factor * exp(1)*df$item_gmv_sum_0day / df$price
    
    df$app.book <- decay.factor * df$app.book  + test.factor * exp(1)*df$item_book_pv_0day_app
    df$app.click <- decay.factor * df$app.click  + test.factor * exp(1)*df$item_click_pv_0day_app
    df$app.gmv <- decay.factor * df$app.gmv  + test.factor * 0.01*exp(1)*df$item_gmv_sum_0day_app
    df$app.order <- decay.factor * df$app.order  + test.factor * exp(1)*df$item_gmv_sum_0day_app / df$price
    return(df)
	
}
