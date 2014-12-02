source("env.setting.R")

get.pv.ctr1.cols <- function(df) {
	pv.val <- seq(from=0,to=6+1,by=1)
	ctr1.val <- seq(from=0.00,to=0.025+0.005,by=0.005)
	combine.cols <- c()
	for ( x in pv.val) {
		for (y in ctr1.val) {
			
		combine.cols <- c(combine.cols,paste("pv",x,"ctr1",y,sep='_'))
		}
	}
	return(combine.cols)
}


combine.pv.ctr1 <- function(df) {
	pv.val <- seq(from=0,to=6+1,by=1)
	ctr1.val <- seq(from=0.00,to=0.025+0.005,by=0.005)
	df$book.pv[df$book.pv>6] <- 7
	df$ctr1[df$ctr1>0.025] <- 0.03
	pv.row <- ceiling((df$book.pv - 0) / 1 + 1)
	ctr1.row <- ceiling((df$ctr1 - 0) / 0.005 + 1)
	combine.name <- paste("pv",pv.val[pv.row],"ctr1",ctr1.val[ctr1.row],sep='_')
	
	combine.cols <- c()
	for ( x in pv.val) {
		for (y in ctr1.val) {
			
		combine.cols <- c(combine.cols,paste("pv",x,"ctr1",y,sep='_'))
		}
	}

	for ( col in combine.cols) {
		df[,col ] <- 0
	}

	for ( col in combine.cols) {
		df[combine.name == col,col ] <- 1
	}
	
	return(df)
}

combine.pv.ctr3 <- function(df) {
	pv.val <- seq(from=0,to=6+1,by=1)
	ctr3.val <- seq(from=0.00,to=2+0.1,by=0.1)
	df$book.pv[df$book.pv>6] <- 7
	df$ctr3[df$ctr3>2] <- 2.1
	pv.row <- ceiling((df$book.pv - 0) / 1 + 1)
	ctr3.row <- ceiling((df$ctr3 - 0) / 0.1 + 1)
	combine.name <- paste("pv",pv.val[pv.row],"ctr3",ctr3.val[ctr3.row],sep='_')
	
	combine.cols <- c()
	for ( x in pv.val) {
		for (y in ctr3.val) {
			
		combine.cols <- c(combine.cols,paste("pv",x,"ctr3",y,sep='_'))
		}
	}

	for ( col in combine.cols) {
		df[,col ] <- 0
	}

	for ( col in combine.cols) {
		df[combine.name == col,col ] <- 1
	}
	
	return(df)
}


get.pv.ctr3.cols <- function(df) {
	pv.val <- seq(from=0,to=6+1,by=1)
	ctr3.val <- seq(from=0.00,to=2+0.1,by=0.1)

	combine.cols <- c()
	for ( x in pv.val) {
		for (y in ctr3.val) {
			combine.cols <- c(combine.cols,paste("pv",x,"ctr3",y,sep='_'))
		}
	}
	return(combine.cols)
}
	

combine.uv.utr1 <- function(df) {
	uv.val <- seq(from=0,to=6+1,by=1)
	utr1.val <- seq(from=0.00,to=0.025+0.005,by=0.005)
	df$book.uv[df$book.uv>6] <- 7
	df$utr1[df$utr1>0.025] <- 0.03
	uv.row <- ceiling((df$book.uv - 0) / 1 + 1)
	utr1.row <- ceiling((df$utr1 - 0) / 0.005 + 1)
	combine.name <- paste("uv",uv.val[uv.row],"utr1",utr1.val[utr1.row],sep='_')
	
	combine.cols <- c()
	for ( x in uv.val) {
		for (y in utr1.val) {
			
		combine.cols <- c(combine.cols,paste("uv",x,"utr1",y,sep='_'))
		}
	}

	for ( col in combine.cols) {
		df[,col ] <- 0
	}

	for ( col in combine.cols) {
		df[combine.name == col,col ] <- 1
	}
	
	return(df)
}

get.uv.utr1.cols <- function(df) {
	uv.val <- seq(from=0,to=6+1,by=1)
	utr1.val <- seq(from=0.00,to=0.025+0.005,by=0.005)
	combine.cols <- c()
	for ( x in uv.val) {
		for (y in utr1.val) {
			
		combine.cols <- c(combine.cols,paste("uv",x,"utr1",y,sep='_'))
		}
	}
	return(combine.cols)
}

get.price.count.cols <- function(df) {
	price.val <- seq(from=0,to=250+50,by=50)
	count.val <- seq(from=0,to=20+1,by=1)
	combine.cols <- c()
	for ( x in price.val) {
		for (y in count.val) {
			
		combine.cols <- c(combine.cols,paste("price",x,"count",y,sep='_'))
		}
	}
	return(combine.cols)
}




combine.price.count <- function(df) {
	price.val <- seq(from=0,to=250+50,by=50)
	count.val <- seq(from=0,to=20+1,by=1)
	df$price <- df$price / 100.0
	df$price[df$price>250] <- 300
	df$gmv.count[df$gmv.count>20] <- 21
	price.row <- ceiling((df$price - 0) / 50 + 1)
	count.row <- ceiling((df$gmv.count - 0) / 1 + 1)
	combine.name <- paste("price",price.val[price.row],"count",count.val[count.row],sep='_')
	
	combine.cols <- c()
	for ( x in price.val) {
		for (y in count.val) {
			
		combine.cols <- c(combine.cols,paste("price",x,"count",y,sep='_'))
		}
	}

	for ( col in combine.cols) {
		df[,col ] <- 0
	}

	for ( col in combine.cols) {
		df[combine.name == col,col ] <- 1
	}
	
	return(df)
}

combine.features <- function(df) {
	df <- combine.pv.ctr1(df)
	df <- combine.pv.ctr3(df)
	df <- combine.uv.utr1(df)
	df <- combine.price.count(df)
    selected.cols <- c("itemInfoId","tradeItemId")
    selected.cols <- c(selected.cols,style.profile.factors)
	selected.cols <- c(selected.cols,get.pv.ctr1.cols(df))
	selected.cols <- c(selected.cols,get.pv.ctr3.cols(df))
	selected.cols <- c(selected.cols,get.uv.utr1.cols(df))
	selected.cols <- c(selected.cols,get.price.count.cols(df))
    selected.cols <- c(selected.cols,"target")
	return(df)
}
