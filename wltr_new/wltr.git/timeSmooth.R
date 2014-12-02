sequenceTime <- function(df) {
    df$pcBookPV1Day <- df$item_book_pv_1day
    df$pcBookPV3Day <- df$item_book_pv_3day - df$item_book_pv_1day
    df$pcBookPV7Day <- df$item_book_pv_7day - df$item_book_pv_3day
    df$pcBookPV15Day <- df$item_book_pv_15day - df$item_book_pv_7day
    df$pcBookPV30Day <- df$item_book_pv_30day - df$item_book_pv_15day
    
    df$pcDetailPV1Day <- df$item_click_pv_1day
    df$pcDetailPV3Day <- df$item_click_pv_3day - df$item_click_pv_1day
    df$pcDetailPV7Day <- df$item_click_pv_7day - df$item_click_pv_3day
    df$pcDetailPV15Day <- df$item_click_pv_15day - df$item_click_pv_7day
    df$pcDetailPV30Day <- df$item_click_pv_30day - df$item_click_pv_15day
    
    df$pcCartPV1Day <- df$item_cart_pv_1day
    df$pcCartPV3Day <- df$item_cart_pv_3day - df$item_cart_pv_1day
    df$pcCartPV7Day <- df$item_cart_pv_7day - df$item_cart_pv_3day
    df$pcCartPV15Day <- df$item_cart_pv_15day - df$item_cart_pv_7day
    df$pcCartPV30Day <- df$item_cart_pv_30day - df$item_cart_pv_15day
    
    df$pcGmvSum1Day <- 0.01*(df$item_gmv_sum_1day)
    df$pcGmvSum3Day <- 0.01*(df$item_gmv_sum_3day - df$item_gmv_sum_1day)
    df$pcGmvSum7Day <- 0.01*(df$item_gmv_sum_7day - df$item_gmv_sum_3day)
    df$pcGmvSum15Day <- 0.01*(df$item_gmv_sum_15day - df$item_gmv_sum_7day)
    df$pcGmvSum30Day <- 0.01*(df$item_gmv_sum_30day - df$item_gmv_sum_15day)
    
    df$pcGmvCount1Day <- df$item_gmv_count_1day
    df$pcGmvCount3Day <- df$item_gmv_count_3day - df$item_gmv_count_1day
    df$pcGmvCount7Day <- df$item_gmv_count_7day - df$item_gmv_count_3day
    df$pcGmvCount15Day <- df$item_gmv_count_15day - df$item_gmv_count_7day
    df$pcGmvCount30Day <- df$item_gmv_count_30day - df$item_gmv_count_15day
    
    df$appBookPV1Day <- df$item_book_pv_1day_app
    df$appBookPV3Day <- df$item_book_pv_3day_app - df$item_book_pv_1day_app
    df$appBookPV7Day <- df$item_book_pv_7day_app - df$item_book_pv_3day_app
    df$appBookPV15Day <- df$item_book_pv_15day_app - df$item_book_pv_7day_app
    df$appBookPV30Day <- df$item_book_pv_30day_app - df$item_book_pv_15day_app
    
    df$appDetailPV1Day <- df$item_click_pv_1day_app
    df$appDetailPV3Day <- df$item_click_pv_3day_app - df$item_click_pv_1day_app
    df$appDetailPV7Day <- df$item_click_pv_7day_app - df$item_click_pv_3day_app
    df$appDetailPV15Day <- df$item_click_pv_15day_app - df$item_click_pv_7day_app
    df$appDetailPV30Day <- df$item_click_pv_30day_app - df$item_click_pv_15day_app
    
    df$appCartPV1Day <- df$item_cart_pv_1day_app
    df$appCartPV3Day <- df$item_cart_pv_3day_app - df$item_cart_pv_1day_app
    df$appCartPV7Day <- df$item_cart_pv_7day_app - df$item_cart_pv_3day_app
    df$appCartPV15Day <- df$item_cart_pv_15day_app - df$item_cart_pv_7day_app
    df$appCartPV30Day <- df$item_cart_pv_30day_app - df$item_cart_pv_15day_app
    
    
    df$appGmvSum1Day <- 0.01*(df$item_gmv_sum_1day_app)
    df$appGmvSum3Day <- 0.01*(df$item_gmv_sum_3day_app - df$item_gmv_sum_1day_app)
    df$appGmvSum7Day <- 0.01*(df$item_gmv_sum_7day_app - df$item_gmv_sum_3day_app)
    df$appGmvSum15Day <- 0.01*(df$item_gmv_sum_15day_app - df$item_gmv_sum_7day_app)
    df$appGmvSum30Day <- 0.01*(df$item_gmv_sum_30day_app - df$item_gmv_sum_15day_app)
    
    df$appGmvCount1Day <- df$item_gmv_count_1day_app
    df$appGmvCount3Day <- df$item_gmv_count_3day_app - df$item_gmv_count_1day_app
    df$appGmvCount7Day <- df$item_gmv_count_7day_app - df$item_gmv_count_3day_app
    df$appGmvCount15Day <- df$item_gmv_count_15day_app - df$item_gmv_count_7day_app
    df$appGmvCount30Day <- df$item_gmv_count_30day_app - df$item_gmv_count_15day_app
    
    return(df)
}



expOfflineSmooth <- function(df) {
    df$pcBookPV <- exp(0)*df$pcBookPV1Day  +
        exp(-2)*df$pcBookPV3Day  +
        exp(-4)*df$pcBookPV7Day  +
        exp(-8)*df$pcBookPV15Day  +
        exp(-16)*df$pcBookPV30Day  
    
    df$pcDetailPV <- exp(0)*df$pcDetailPV1Day  +
        exp(-2)*df$pcDetailPV3Day  +
        exp(-4)*df$pcDetailPV7Day  +
        exp(-8)*df$pcDetailPV15Day  +
        exp(-16)*df$pcDetailPV30Day 
    
    df$pcCartPV <- exp(0)*df$pcCartPV1Day  +
        exp(-2)*df$pcCartPV3Day  +
        exp(-4)*df$pcCartPV7Day  +
        exp(-8)*df$pcCartPV15Day  +
        exp(-16)*df$pcCartPV30Day 

    df$pcGmvSum <- exp(0)*df$pcGmvSum1Day  +
        exp(-2)*df$pcGmvSum3Day  +
        exp(-4)*df$pcGmvSum7Day  +
        exp(-8)*df$pcGmvSum15Day  +
        exp(-16)*df$pcGmvSum30Day 
    
    df$pcGmvCount <- exp(0)*df$pcGmvCount1Day  +
        exp(-2)*df$pcGmvCount3Day  +
        exp(-4)*df$pcGmvCount7Day  +
        exp(-8)*df$pcGmvCount15Day  +
        exp(-16)*df$pcGmvCount30Day  
    
    
    df$appBookPV <- exp(0)*df$appBookPV1Day  +
        exp(-2)*df$appBookPV3Day  +
        exp(-4)*df$appBookPV7Day  +
        exp(-8)*df$appBookPV15Day  +
        exp(-16)*df$appBookPV30Day  
    
    df$appDetailPV <- exp(0)*df$appDetailPV1Day  +
        exp(-2)*df$appDetailPV3Day  +
        exp(-4)*df$appDetailPV7Day  +
        exp(-8)*df$appDetailPV15Day  +
        exp(-16)*df$appDetailPV30Day 
    
    df$appCartPV <- exp(0)*df$appCartPV1Day  +
        exp(-2)*df$appCartPV3Day  +
        exp(-4)*df$appCartPV7Day  +
        exp(-8)*df$appCartPV15Day  +
        exp(-16)*df$appCartPV30Day 

    df$appGmvSum <- exp(0)*df$appGmvSum1Day  +
        exp(-2)*df$appGmvSum3Day  +
        exp(-4)*df$appGmvSum7Day  +
        exp(-8)*df$appGmvSum15Day  +
        exp(-16)*df$appGmvSum30Day 
    
    df$appGmvCount <- exp(0)*df$appGmvCount1Day  +
        exp(-2)*df$appGmvCount3Day  +
        exp(-4)*df$appGmvCount7Day  +
        exp(-8)*df$appGmvCount15Day  +
        exp(-16)*df$appGmvCount30Day  
    return(df)
}


expOnlineSmooth <- function(df) {
    df$pcBookPV <- df$pcBookPV  + exp(1)*df$item_book_pv_0day
    df$pcDetailPV <- df$pcDetailPV  + exp(1)*df$item_detail_pv_0day
    df$pcCartPV <- df$pcCartPV  + exp(1)*df$item_cart_pv_0day
    df$pcGmvSum <- df$pcGmvSum  + 0.01*exp(1)*df$item_gmv_sum_0day
    df$pcGmvCount <- df$pcGmvCount  + exp(1)*df$item_gmv_sum_0day / df$price
  
    df$appBookPV <- df$appBookPV  + exp(1)*df$item_book_pv_0day_app
    df$appDetailPV <- df$appDetailPV  + exp(1)*df$item_detail_pv_0day_app
    df$appCartPV <- df$appCartPV  + exp(1)*df$item_cart_pv_0day_app
    df$appGmvSum <- df$appGmvSum  + 0.01*exp(1)*df$item_gmv_sum_0day_app
    df$appGmvCount <- df$appGmvCount  + exp(1)*df$item_gmv_sum_0day_app / df$price
    return(df)
}


timeOfflineSmooth <- function(df) {
    df <- sequenceTime(df)
    df <- expOfflineSmooth(df)
    return(df)
}


timeOnlineSmooth <- function(df) {
    df <- sequenceTime(df)
    df <- expSmooth(df)
    df <- expOnlineSmooth(df)
    return(df)
}

