library(parallel)

getFlow <- function(filename) {
    df <- read.table(filename,
                      sep="\t",
                      header=TRUE,
                      quote="",
                      na.strings="NULL")
    
    df <- df[,c("tradeItemId","item_click_pv_0day_app")]
    df[is.na(df)] <- 0
	flow <- sum(df$item_click_pv_0day_app)
    return(flow)
}

statFlow <- function(filename) {
    flow <- getFlow(filename)
    seq <- getSequence(filename)
    return(c(seq,flow))
}


getSequence <- function(fileName) {
	fileName <- strsplit(fileName,"/")
	size <- length(fileName)
	fileName <- fileName[[1]][size]
    timeString <- substr(fileName,0,nchar(fileName)-3)
    timeInt <- as.numeric(timeString)
    time <- unclass(as.POSIXlt(timeInt,origin="1970-01-01 00:00:00"))
    seq <- floor(time$hour * 4 - 4 +  0.06666667 * time$min  )
    return(seq)
}

minusFlow <- function(i,data) {
    flow <- ifelse(1==i,data[[i]][2],data[[i]][2] - data[[ i - 1 ]][2])
	seq <- data[[i]][1]
	return(c(seq,flow))
}

statFlows <- function(args) {
    srcPath <- args[1]
    dstFile <- args[2]
    srcFiles <- sort(dir(srcPath))
	srcFiles <- paste(srcPath,srcFiles,sep="/")
	mc <- getOption("mc.cores", 8)
	flows <- mclapply(srcFiles,statFlow,mc.cores = mc)
    flows <- mclapply(1:length(flows),minusFlow,flows,mc.cores = mc)
    flows <- as.data.frame(t(sapply(flows,rbind)))
    write.table(flows,file=dstFile,sep=",",row.names=FALSE)
}

args <- commandArgs(TRUE)
statFlows(args)
