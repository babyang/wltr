

DiscretePrice <- function(df) {
    price.range <- c(50,100,150,200,250)
    price.val <- 0.01 * df$price 
    price.val[price.val>250] <- 1000
    
    prev <- -1
    for (col in price.range) {
        col.name <- paste("price",col,sep=".")
        row <- (price.val > prev) &  (price.val <= col)
        df[,col.name] <- 0
        df[row,col.name] <- 1
        prev <- col
    }
    return(df)
}
