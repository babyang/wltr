
convert  <- function(source.file, target.file){

    print(paste("reading ", source.file))
    data     <- read.table(source.file,
                           sep = "\t",
                           header=FALSE,
                           stringsAsFactors=FALSE)
    #names(data)[1:2] <- c("tradeItemId", "pc.rank")
    print(paste("writing ", target.file))
    write.table(data, target.file, row.names = FALSE, sep = ",",col.names = FALSE)
}






args                <- commandArgs(TRUE)
source.file        <- args[1]
target.file       <- args[2]

convert(source.file, target.file)
