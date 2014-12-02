# learning to rank ml system
# author zhiyuan@mogujie.com
# create 20140731

library(plyr)
library(glmnet)
library(ggplot2)
library(randomForest)

source("env.setting.R")
source("utils.R")
source("etl.R")
source("build.features.R")

train.date <- '20140904'
test.date <- '20140909'

source("env.setting.R")
source("utils.R")


rf.predict <- function(prev.date,
        curr.date) {
    model.file <- get.filename("rf.rda",prev.date)
    load(model.file)
	print(rf)
    file.test <- paste(curr.date,"feature",sep='.')

    df.test <- get.data.from.file(file.test,",")
	target.col <- ncol(df.test)
	test <- df.test[,c(-1,-2,-target.col)]
	score <- predict(rf,newdata=test,type="vote")
    score.rf <- cbind(df.test[,c(1,2)],score[,c(-1)])
    predict.file <- get.filename("rf.predict",curr.date)
	names(score.rf) <- c("itemInfoId","tradeItemId","score")
    write.csv(score.rf,file=predict.file,row.names=FALSE)
}

evaluate.rank <- function(predict.filename,date) {
    
    df.predict <- get.data.from.file(predict.filename,',')
    df.predict <- df.predict[,c("tradeItemId","score")]
    df.predict$score <- as.numeric(df.predict$score)
    order.predict <- order(df.predict$score,decreasing=TRUE)
    df.predict <- df.predict[order.predict,]
    ranks <- seq(nrow(df.predict))
    df.rank <-  data.frame(tradeItemId=df.predict$tradeItemId,rank=ranks)

#zero <- max(which(df.predict$score>0)) + 1
    tmp <- cbind(df.predict$tradeItemId,order.predict)
    filename <- get.filename("rank",date)

    write.csv(df.rank,file=filename,row.names=FALSE,col.names=FALSE)
#   print(zero)
}
print("copy data .... ")
system.time(get.file.from.date(test.date))
print("copy data done")



print("etl data ......")
system.time(etl.data(test.date))
print("etl data done")


print("build feature ......")
system.time(build.features(test.date))
print("build feature done")


rf.predict(train.date,test.date)

predict.filename <- paste(test.date,'rf.predict',sep='.')
#print(predict.filename)
evaluate.rank(predict.filename,test.date)
