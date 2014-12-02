
BayesSmooth <- function(x,
		y,
		M,
		delta=1) {
	x <- as.numeric(x)
	y <- as.numeric(y)
	avg.rate <- sum(x) / (sum(y) + delta)
	rate <- x / ( y + delta)
	s <- y * rate / (y + M) + M * avg.rate / (y + M)
	return(s)
}



CalcClickRate <-  function(df,theta=1000) {

	row <- order(df$pc.book,decreasing=T)
	M <- df$pc.book[row[theta]]

#row <- df$pc.click >= df$pc.book
#	if (length(which(row)) > 0) {
#		df$pc.click[row] <- df$pc.book[row]
#	}
	df$pc.click.rate <- BayesSmooth(df$pc.click,df$pc.book,M)

	row <- order(df$app.book,decreasing=T)
	M <- df$app.book[row[theta]]

#	row <- df$app.click >= df$app.book
#	if (length(which(row)) > 0) {
#		df$app.click[row] <- df$app.book[row]
#	}
	df$app.click.rate <- BayesSmooth(df$app.click,df$app.book,M)

	return(df)
}


CalcGmvRate <- function(df,theta=1000) {
	
	row <- order(df$pc.book,decreasing=T)
	M <- df$pc.book[row[theta]]

	df$pc.gmv.rate <- BayesSmooth(df$pc.gmv,df$pc.book,M)

	row <- order(df$app.book,decreasing=T)
	M <- df$app.book[row[theta]]
	df$app.gmv.rate <- BayesSmooth(df$app.gmv,df$app.book,M)

	return(df)
}


CrossClickAndGmv <- function(df) {
	df$pc.cross.gmv.click <- log10(df$pc.gmv + 1) * log10(df$pc.click + 1)
	df$app.cross.gmv.click <- log10(df$app.gmv + 1) * log10(df$app.click + 1)
	return(df)
}


DeriveFeature <- function(df) {
	df <- CalcClickRate(df)
	df <- CalcGmvRate(df)
	df <- CrossClickAndGmv(df)
	return(df)
}
