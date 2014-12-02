

SequenceTime <- function(df) {
    df$pc.book1day <- df$item_book_pv_1day
    df$pc.book3day <- df$item_book_pv_3day - df$item_book_pv_1day
    df$pc.book7day <- df$item_book_pv_7day - df$item_book_pv_3day
    df$pc.book15day <- df$item_book_pv_15day - df$item_book_pv_7day
    
    df$pc.click1day <- df$item_click_pv_1day
    df$pc.click3day <- df$item_click_pv_3day - df$item_click_pv_1day
    df$pc.click7day <- df$item_click_pv_7day - df$item_click_pv_3day
   df$pc.click15day <- df$item_click_pv_15day - df$item_click_pv_7day
    
    

    df$pc.gmv1day <- 0.01*(df$item_gmv_sum_1day)
    df$pc.gmv3day <- 0.01*(df$item_gmv_sum_3day - df$item_gmv_sum_1day)
    df$pc.gmv7day <- 0.01*(df$item_gmv_sum_7day - df$item_gmv_sum_3day)
    df$pc.gmv15day <- 0.01*(df$item_gmv_sum_15day - df$item_gmv_sum_7day)
    
    df$pc.order1day <- df$item_gmv_count_1day
    df$pc.order3day <- df$item_gmv_count_3day - df$item_gmv_count_1day
    df$pc.order7day <- df$item_gmv_count_7day - df$item_gmv_count_3day
    df$pc.order15day <- df$item_gmv_count_15day - df$item_gmv_count_7day
    
    df$app.book1day <- df$item_book_pv_1day_app
    df$app.book3day <- df$item_book_pv_3day_app - df$item_book_pv_1day_app
    df$app.book7day <- df$item_book_pv_7day_app - df$item_book_pv_3day_app
    df$app.book15day <- df$item_book_pv_15day_app - df$item_book_pv_7day_app
    
    df$app.click1day <- df$item_click_pv_1day_app
    df$app.click3day <- df$item_click_pv_3day_app - df$item_click_pv_1day_app
    df$app.click7day <- df$item_click_pv_7day_app - df$item_click_pv_3day_app
    df$app.click15day <- df$item_click_pv_15day_app - df$item_click_pv_7day_app
    
    
    df$app.gmv1day <- 0.01 * (df$item_gmv_sum_1day_app)
    df$app.gmv3day <- 0.01 * (df$item_gmv_sum_3day_app - df$item_gmv_sum_1day_app)
    df$app.gmv7day <- 0.01 * (df$item_gmv_sum_7day_app - df$item_gmv_sum_3day_app)
    df$app.gmv15day <- 0.01 * (df$item_gmv_sum_15day_app - df$item_gmv_sum_7day_app)
    
    df$app.order1day <- df$item_gmv_count_1day_app
    df$app.order3day <- df$item_gmv_count_3day_app - df$item_gmv_count_1day_app
    df$app.order7day <- df$item_gmv_count_7day_app - df$item_gmv_count_3day_app
    df$app.order15day <- df$item_gmv_count_15day_app - df$item_gmv_count_7day_app
    
    return(df)
}



ExpOfflineSmooth <- function(df) {
    df$pc.book <- exp(0)*df$pc.book1day  +
       exp(-2)*df$pc.book3day  +
       exp(-4)*df$pc.book7day  +
       exp(-8)*df$pc.book15day  
    
	row <- (df$item_book_pv_1day > 0 & df$pc.book == 0 )
    df$pc.click <- exp(0)*df$pc.click1day  +
       exp(-2)*df$pc.click3day  +
       exp(-4)*df$pc.click7day  +
       exp(-8)*df$pc.click15day 
    

    df$pc.gmv <- exp(0)*df$pc.gmv1day  +
        exp(-2)*df$pc.gmv3day  +
        exp(-4)*df$pc.gmv7day  +
        exp(-8)*df$pc.gmv15day 
    
    df$pc.order <- exp(0)*df$pc.order1day  +
        exp(-2)*df$pc.order3day  +
        exp(-4)*df$pc.order7day  +
        exp(-8)*df$pc.order15day
    
    
    df$app.book <- exp(0)*df$app.book1day  +
        exp(-2)*df$app.book3day  +
        exp(-4)*df$app.book7day  +
        exp(-8)*df$app.book15day 
    
    df$app.click <- exp(0)*df$app.click1day  +
        exp(-2)*df$app.click3day  +
        exp(-4)*df$app.click7day  +
        exp(-8)*df$app.click15day
    

    df$app.gmv <- exp(0)*df$app.gmv1day  +
        exp(-2)*df$app.gmv3day  +
        exp(-4)*df$app.gmv7day  +
        exp(-8)*df$app.gmv15day 

    df$app.order <- exp(0)*df$app.order1day  +
        exp(-2)*df$app.order3day  +
        exp(-4)*df$app.order7day  +
        exp(-8)*df$app.order15day


	return(df)
}

SequenceBehavior <- function(df) {
	df <- SequenceTime(df)
	df <- ExpOfflineSmooth(df)
	return(df)
}
