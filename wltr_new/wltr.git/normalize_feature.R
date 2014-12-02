


MaxMinNorm <- function(y) {
    ymax <- max(y)
    ymin <- min(y)
    delta <- ifelse(ymin==ymax,1,ymax-ymin)
    y <- (y-ymin) / delta
    y[y<0.0001] <- 0
    return(y)
}


NormFeature <- function(df) {
	pc.cols <- c("pc.click","pc.gmv","pc.order",
			"pc.click.rate","pc.gmv.rate",
			"pc.cross.gmv.click")

	app.cols <- c("app.click","app.gmv","app.order",
			"app.click.rate","app.gmv.rate",
			"app.cross.gmv.click")

	cols <- c(pc.cols,app.cols)

#	row <- cols %in% names(df)
#	print(cols[!row])
	for ( col in cols ) {
		df[ ,col] <- MaxMinNorm(df[ ,col])	
	}
	
	return(df)
}
