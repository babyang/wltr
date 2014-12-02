readDataFromCSV <- function(filename) {
    return(read.table(filename,
                      sep=",",
                      na.strings = "NULL",
                      stringsAsFactors=FALSE,
                      header=TRUE))
}




rankWithType <- function(dfScore,
                        dfType,
                        type) {
    dfType <- subset(dfType,type=type)
    data <- merge(dfScore,dfType,by="tradeItemId")
    
    row <- order(data$score,decreasing=TRUE)
    data <- subset(data,c("itemInfoId","tradeItemId"))
    data <- data[row,]
    data$rank <- seq(nrow(data))
    return(data)
}

businessRank <- function(args) {
    typeFilename <- args[1]
    scoreFilename <- args[2]
    rankFilename <- args[3]
    
    dfScore <- readDataFromCSV(scoreFilename)
    dfType <- readDataFromCSV(typeFilename)
    
    relYouRank <- rankWithType(dfScore,dfType,"relYou")
    normRank <- rankWithType(dfScore,dfType,"norm")
    normRank <- normRank + nrow(relYouRank)
    ranks <- rbind(relYouRank,normRank)
    write.table(ranks,
                file=rankFilename,
                sep=",",
                row.names=FALSE,
                col.names=FALSE)
}
