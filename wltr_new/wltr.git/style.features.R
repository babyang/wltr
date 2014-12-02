require(plyr)
source("utils.R")
source("env.setting.R")



style.features <- function(df) {
	df$style.ctr <- 0
	for ( col in style.profile.factors) {
		row <- df[,col]==1
		df$style.ctr[row] <- log10(sum(df$gmv.sum[row])+1.0) / (log10(sum(df$book.pv[row])+1)+1)
	}
	df$style.ctr[df$style.ctr>1] <- 1
	return(df)
}

