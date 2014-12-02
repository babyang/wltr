library(ggplot2)
library(ggthemes)

readDataFromText <- function(filename) {
    return(read.table(filename,
                      sep=",",
                      stringsAsFactors=FALSE,
                      header=TRUE))
}

summaryData <- function(df) {
    summary(df)
}


histVariable <- function(df) {
    p <- ggplot(df[df$item_book_pv_1day>0,],aes(x=log10(item_book_pv_1day+1),y=..count..))
    p <- p + geom_histogram(alpha=0.8,binwidth=0.2)
  #  p <- p + labs(title="hist of book pv in pc")
  #  p <- p + scale_x_continuous(breaks=seq(from=0,to=10,by=1))
 #   p <- p + scale_y_continuous(breaks=seq(from=0,to=30000,by=10000))
 #   p <- p +  theme_wsj() 
   
   
    ggsave("../pic/pcBookPVHist.png",p,width=6,height=6)
    
    p <- ggplot(df[df$item_book_pv_1day_app>0,],aes(x=log10(item_book_pv_1day_app+1),y=..count..))
    p <- p + geom_histogram(alpha=0.8,binwidth=0.2)
  #  p <- p + labs(title="hist of book pv in app",x="log(book pv)",y="count")
  #  p <- p + scale_x_continuous(breaks=seq(from=0,to=10,by=1))
  #  p <- p + scale_y_continuous(breaks=seq(from=0,to=20000,by=5000))
  #  p <- p +  theme_stata() 
    ggsave("../pic/appBookPVHist.png",p,width=6,height=6)
 
 
 p <- ggplot(df[df$item_click_pv_1day>0,],aes(x=log10(item_click_pv_1day+1),y=..count..))
 p <- p + geom_histogram(alpha=0.8,binwidth=0.2)
 #p <- p + labs(title="hist of click pv in pc")
 #p <- p + scale_x_continuous(breaks=seq(from=0,to=10,by=1))
 #p <- p + scale_y_continuous(breaks=seq(from=0,to=30000,by=10000))
 #   p <- p +  theme_wsj() 
 
 
 ggsave("../pic/pcClickPVHist.png",p,width=6,height=6)
 
 p <- ggplot(df[df$item_click_pv_1day_app,],aes(x=log10(item_click_pv_1day_app+1),y=..count..))
 p <- p + geom_histogram(alpha=0.8,binwidth=0.2)
 #  p <- p + labs(title="hist of click pv in app",x="log(book pv)",y="count")
 #p <- p + scale_x_continuous(breaks=seq(from=0,to=10,by=1))
 #p <- p + scale_y_continuous(breaks=seq(from=0,to=20000,by=5000))
 #  p <- p +  theme_stata() 
 ggsave("../pic/appClickPVHist.png",p,width=6,height=6)
 
 
 p <- ggplot(df[df$item_gmv_sum_1day>0,],aes(x=log10(item_gmv_sum_1day/100+1),y=..count..))
 p <- p + geom_histogram(alpha=0.8,binwidth=0.2)
 #p <- p + labs(title="hist of click pv in pc")
 #p <- p + scale_x_continuous(breaks=seq(from=0,to=10,by=1))
# p <- p + scale_y_continuous(breaks=seq(from=0,to=30000,by=10000))
 #   p <- p +  theme_wsj() 
 
 
 ggsave("../pic/pcGMVPVHist.png",p,width=6,height=6)
 
 p <- ggplot(df[df$item_gmv_sum_1day_app>0,],aes(x=log10(item_gmv_sum_1day_app/100+1),y=..count..))
 p <- p + geom_histogram(alpha=0.8,binwidth=0.2)
 #  p <- p + labs(title="hist of click pv in app",x="log(book pv)",y="count")
# p <- p + scale_x_continuous(breaks=seq(from=0,to=10,by=1))
# p <- p + scale_y_continuous(breaks=seq(from=0,to=20000,by=5000))
 #  p <- p +  theme_stata() 
 ggsave("../pic/appGMVPVHist.png",p,width=6,height=6)
}

boxplotVariable <- function(df) {
    
    pcBookPV <- cbind(df$item_book_pv_1day,tag="pc")
    appBookPV <- cbind(df$item_book_pv_1day_app,tag="app")
    bookPV <- rbind(pcBookPV,appBookPV)
    bookPV <- as.data.frame(bookPV)
    names(bookPV) <- c("bookPV","tag")
    
    
    p <- ggplot(bookPV,aes(x=as.factor(tag),y=bookPV))
    p <- p + geom_boxplot() 
    p <- p + theme_wsj()
    ggsave("../pic/bookPVBoxplot.png",p)
}

df <- readDataFromText("../data/20141009.clean")
<<<<<<< HEAD
histVariable(df)
=======
histVariable(df)
>>>>>>> bf28444d89b943a6aed7c7abce2defa6003d3c59
