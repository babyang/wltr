
merge.all.rank <- function(pc.rank.file, app.rank.file, app.fresh.rank.file, all.rank.file){

    print(paste("reading ", pc.rank.file))
    pc.rank  <- read.table(pc.rank.file,
                           sep = "\t",
                           header=FALSE,
                           stringsAsFactors=FALSE)
    names(pc.rank)[1:2] <- c("tradeItemId", "pc.rank")
    print(paste("reading ", app.rank.file))
    app.rank <- read.table(app.rank.file,
                           sep = "\t",
		           header=FALSE,
		           stringsAsFactors=FALSE)
    names(app.rank)[1:2] <- c("tradeItemId", "app.rank")
    print(paste("reading ", app.fresh.rank.file))
    app.fresh.rank <- read.table(app.fresh.rank.file, 
                                 sep = "\t",
			         header=FALSE,
			         stringsAsFactors=FALSE)
   names(app.fresh.rank)[1:2] <- c("tradeItemId", "app.fresh.rank")
   all.rank <- merge(pc.rank, app.rank, by = "tradeItemId")
   if(nrow(all.rank) < nrow(pc.rank) ||nrow(all.rank) < nrow(app.rank)){
       print("some items are missing in all.rank due to mismatch between pc.rank and app.rank ")
   }

   all.rank <- merge(all.rank, app.fresh.rank, by = "tradeItemId")
   if(nrow(all.rank) < nrow(app.fresh.rank)){
       print("some items are missing in all.rank due to mismatch between all.rank and app.fresh.rank")
   }
   all.rank <- all.rank[order(all.rank$pc.rank, decreasing = FALSE), ]
   print(paste("writing ", all.rank.file))
   write.table(all.rank, all.rank.file, row.names = FALSE, sep = ",",col.names = FALSE)
}






args                <- commandArgs(TRUE)
pc.rank.file        <- args[1]
app.rank.file       <- args[2]
app.fresh.rank.file <- args[3]
all.rank.file       <- args[4]


merge.all.rank(pc.rank.file, app.rank.file, app.fresh.rank.file, all.rank.file)
