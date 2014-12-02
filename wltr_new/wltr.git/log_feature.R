
LogFeature <- function(df) {
	pc.cols <- c("pc.click","pc.gmv","pc.order")
	app.cols <- c("app.click","app.gmv","app.order")

	for ( col in pc.cols ) {
		df[ ,col] <- log10(df[ ,col] + 1.0)
	}

	for ( col in app.cols ) {
		df[ ,col] <- log10(df[ ,col] + 1.0)
	}

	return(df)
}
