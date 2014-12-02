
get.column.data <- function(file.name, column.name){
   data.full.path <- file.name
   data <- read.table(data.full.path,
                   sep="\t",
                   quote = "",                                      
                   header=TRUE,
                   stringsAsFactors=FALSE)
   
   sub.data <- data[, c("tradeItemId", column.name)]
   idx.null <- sub.data[, 2] == "NULL"
   sub.data[idx.null, 2] = "0"
   names(sub.data)[1] <- "tradeItemId"
   names(sub.data)[2] <- column.name
   return(sub.data)
}

convert.created <- function(df,base) {
  class(df$created) <- c('POSIXt',"POSIXct")
  df$created <- difftime(as.POSIXct(base,format="%Y%m%d"),
                         df$created,
                         units="days")
  df$created <- as.numeric(df$created)
  tmp <- df$created
  df$created[tmp>=120] <- '4'
  df$created[tmp<120] <- '3' 
  df$created[tmp<90] <- '2' 
  df$created[tmp<60] <- '1'
  df$created[tmp<30] <- '0'
  return (df)
}

date.features <- function(df,date) {
  df <- convert.created(df,date)
  return(df)
}


anlyze_log_data <- function(year.mon.day, column.name, select.num){
  
   #print(paste("processing ", fold.name, year.mon.day, sep =""))
   data.all.column <- get.column.data(as.character(year.mon.day), column.name)
   column.num      <- ncol(data.all.column)
   data.sin.column <- data.all.column[, column.num]
   data.sin.column[data.sin.column == "NULL"] <- "0"
   data.sin.column <- as.numeric(data.sin.column)
   idx.ordered     <- order(data.sin.column, decreasing = TRUE)
   data.all.column <- data.all.column[idx.ordered,]
   return(data.all.column)
} 

sigmod.local <- function(a, b, x){  
  return(1/(1+exp(a * (1.0/b) * (x - b))))
}

plot.wgt <- function(a, b, x){
  y <- sigmod.local(a, b, x)
 # pdf(file = "weight_curve.pdf")
  pdf(file = "./log/weight_curve.pdf")
  
  obj <- plot(x, y, type = "l")
  dev.off()
}

read.score <- function(score.name){
  
  data.full.path <- score.name
  data <- read.table(data.full.path,
                    # sep="",
		     sep = "\t",
                     header=TRUE,
                     stringsAsFactors=FALSE)
  data <- data[, c(1, 2, 3)]
  return(data) 
  
}

      
weight.score.fresh <- function(source.file, l2r.score.file, fresh.score.file, top.N, top.M, top.T, a){

   print(paste("reading ", source.file, sep = ""))
   
   data.pv.today      <- anlyze_log_data(source.file, "item_book_pv_0day_app", "all")
   names(data.pv.today)[2] <- c("pv")
   data.pv.today$pv[is.na(data.pv.today$pv)] <- 0
   data.pv.today$pv <- as.numeric(data.pv.today$pv)
   mean.pv <- mean(data.pv.today$pv[data.pv.today$pv > 0])

   print(paste("mean.pv = ", as.character(mean.pv), " used for calculating gmv.pv.rate"))

   data.gmv.today      <- anlyze_log_data(source.file, "item_gmv_sum_0day_app", "all")
  
   names(data.gmv.today)[2] <- c("gmv")
   data.gmv.today$gmv[is.na(data.gmv.today$gmv)] <- 0
   data.gmv.today$gmv <- as.numeric(data.gmv.today$gmv)
         
   b <- data.pv.today$pv[top.T]
   plot.dot <- seq(1, 3 * b, (3 * b) / 30)
   plot.wgt(a, b, plot.dot)

   print(paste("a = ", as.character(a), "; b = ", as.character(b), "; top.T = ", as.character(top.T)))
     
   score.frm <- read.score(l2r.score.file)
   score.frm$score <- as.numeric(score.frm$score)

   score.frm$score <- score.frm$score - min(score.frm$score)

   print(paste("reading ", l2r.score.file, sep = ""))

   score.frm <- merge(score.frm, data.pv.today, by = "tradeItemId", all.x = TRUE)
   idx.missed <- score.frm$pv == "NULL"
   
   if(sum(idx.missed) >= 1){
     print("some pv values is missed in score frm ")
     score.frm$pv[idx.missed] <- mean.pv
     score.frm$pv             <- as.numeric(score.frm$pv)
   }

   idx.order <- order(score.frm$score, decreasing = TRUE)
   item.num  <- length(idx.order)
   idx.top.N <- idx.order[1 : top.N]
   idx.top.M <- idx.order[1 : top.M]
   idx.low   <- idx.order[(top.M + 1) : item.num]
   pv.top.N  <- score.frm$pv[idx.top.N]
   wgt.top.N <- sigmod.local(a, b, pv.top.N)
   
   score.tradeItemId <- score.frm$tradeItemId[idx.top.N]
   gmv.subset.idx <- data.gmv.today$tradeItemId %in% score.tradeItemId
   
   if(sum(gmv.subset.idx) < length(score.tradeItemId)){
     print("some items in data.gmv.today$tradeItemId is missing")
   }
   
   gmv.selected <- data.gmv.today[gmv.subset.idx,]
   gmv.score.selected <- merge(gmv.selected, score.frm[idx.top.N, c("tradeItemId", "pv")], by = "tradeItemId" )
   
   if(nrow(gmv.score.selected) < nrow(gmv.selected) || nrow(gmv.score.selected) < length(idx.top.N)){
     print("some items are missing during merging")
   }
   
   gmv.pv.rate <- gmv.score.selected$gmv / (gmv.score.selected$pv + mean.pv)
   
   THR.GMV.PV.RATE <- 6
   min.fresh.rate <- 0.2

   gmv.pv.rate.ordered <- sort(gmv.pv.rate, decreasing = TRUE)
   idx.min.refresh <- as.integer((1.0 - min.fresh.rate) * length(gmv.pv.rate))
   idx.min.refresh <- if(idx.min.refresh <= 0) 1 else idx.min.refresh
   THR.MIN.REFRESH <- gmv.pv.rate.ordered[idx.min.refresh]

   print(paste("tradeItemId in top ", as.character(top.N), " positions"))
   print(gmv.score.selected$tradeItemId[order(gmv.pv.rate, decreasing = TRUE)])

   print(paste("gmv.pv.rate in top ", as.character(top.N), " positions"))
   print(gmv.pv.rate.ordered)
   print(paste("THR.GMV.PV.RATE = ", as.character(THR.GMV.PV.RATE), "; THR.MIN.REFRESH = ", as.character(THR.MIN.REFRESH))) 


   THR <- if(THR.GMV.PV.RATE > THR.MIN.REFRESH) THR.GMV.PV.RATE else THR.MIN.REFRESH 
   
   if(THR.GMV.PV.RATE > THR.MIN.REFRESH){
     print(paste("using absolute gmv.pv.rate criterion: ", as.character(THR.GMV.PV.RATE), sep = ""))
   }else{
     print(paste("using min freshing criterion: ", as.character(THR.MIN.REFRESH), sep = ""))
   }
   
   tradeItemId.no.pen <- gmv.score.selected$tradeItemId[gmv.pv.rate >= THR]
   tradeItemId.no.pen.loc <- score.frm$tradeItemId[idx.top.N]%in%tradeItemId.no.pen
   wgt.top.N[tradeItemId.no.pen.loc] <- 1
      
   score.frm$score[idx.top.N] <- score.frm$score[idx.top.N] * wgt.top.N
   idx.reorder <- order(score.frm$score[idx.top.M], decreasing = TRUE)
   idx.top.M   <- idx.top.M[idx.reorder]
   idx.order   <- c(idx.top.M, idx.low)
   
   score.frm.reorder <- score.frm[idx.order, ]
   score.frm.reorder <- data.frame(itemInfoId = score.frm.reorder$itemInfoId, 
                           tradeItemId = score.frm.reorder$tradeItemId, 
                           score = item.num : 1)
  
   out.score.name <- fresh.score.file

   print(paste("writing", out.score.name, sep = " "))
  
   write.table(score.frm.reorder, out.score.name, row.names = FALSE, sep = "\t",col.names = TRUE)
   diff <- score.frm$tradeItemId[idx.low] - score.frm.reorder$tradeItemId[(top.M + 1) : item.num]
   check <- sum(diff)
   print(paste("check = ", as.character(check), sep = ""))

   ind.retain.top.N <- score.frm.reorder$tradeItemId[1 : top.N] %in% score.frm$tradeItemId[idx.top.N]
   print(paste(as.character(100.0 - (sum(ind.retain.top.N) * 100 / top.N)),
         "% of items are refreshed in top ",as.character(top.N),
	 " positions", sep = ""))
   print(paste("items in top ", as.character(top.M), " positions are reranked", sep = ""))

}


#rm(list = ls())

#source.file      <- c("/Users/mhu/Desktop/projects/wltr_data/data/20141113")
#l2r.score.file   <- c("/Users/mhu/Desktop/projects/wltr_data/data/20141113.app.score")
#fresh.score.file <- c("/Users/mhu/Desktop/projects/wltr_data/data/20141113.app.score.fresh")

top.N <- 1000
top.M <- 5000
top.T <- 500
a <- 5



#example usage: Rscript weight.score.R /Users/mhu/Desktop/projects/wltr_data/data/20141113 
#                                      /Users/mhu/Desktop/projects/wltr_data/data/20141113.app.score
#                                      /Users/mhu/Desktop/projects/wltr_data/data/20141113.app.score.fresh
args           <- commandArgs(TRUE)
source.file    <- args[1]
l2r.score.file <- args[2]
fresh.score.file <- args[3]


weight.score.fresh(source.file, l2r.score.file, fresh.score.file, top.N, top.M, top.T, a)
rm(list = ls())



