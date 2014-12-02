
readDataFromCSV <- function(filename) {
	return(read.table(file=filename,
				sep=",",
				header=TRUE))
}


repairData <- function() {
	df1 <- readDataFromCSV("../data/20141013.clean")
	df2 <- readDataFromCSV("../data/20141014.clean")
	df1 <- df1[,c("tradeItemId","item_book_pv_0day",
			"item_click_pv_0day","item_gmv_sum_0day",
			)
}
