source("env.setting.R")
source("utils.R")
require(glmnet)
require(doMC)
registerDoMC(cores=12)


evaluate.rank <- function(predict.filename,date,tag) {
    
    df.predict <- get.data.from.file(predict.filename,',')
    df.predict <- df.predict[,c("tradeItemId","X1")]
    df.predict$X1 <- as.numeric(df.predict$X1)
    order.predict <- order(df.predict$X1,decreasing=TRUE)
    df.predict <- df.predict[order.predict,]
    ranks <- seq(nrow(df.predict))
    df.rank <-  data.frame(tradeItemId=df.predict$tradeItemId,rank=ranks)

    zero <- max(which(df.predict$X1>0)) + 1
    tmp <- cbind(df.predict$tradeItemId,order.predict)

	rank.file <- paste(tag,"rank",sep=".")
	rank.file <- get.filename(rank.file,date)
    write.csv(df.rank,file=rank.file,row.names=FALSE,col.names=FALSE)
}


model.glmnet <- function(train,test,date,next.date) {

  col.size <- ncol(train)
  x <- as.matrix(train[,1:(col.size-1)])
  y <- as.factor(train[,col.size])
 
  rda.file <- paste("ridge","rda",sep=".")
  txt.file <- paste("ridge","txt",sep=".")
  model.file <- get.filename(rda.file,date)
  coef.file <- get.filename(txt.file,date)
  sink(coef.file)
  lr <- cv.glmnet(x,y,family="binomial",type.measure="auc",alpha=0,parallel=TRUE,nfolds=10)
  print(paste("best lambda ",lr$lambda.1se,sep=":"))
  print(coef(lr$glmnet.fit,lr$lambda.1se))
  sink()
#model.pic <- paste(model.pic,'.jpeg',sep="")
#  print(model.pic)
#  jpeg(file=model.pic, bg="transparent")
#  plot(lr)
#  dev.off()
    

  save(lr, file = model.file)

  target.col <- ncol(test)
  score <- predict(lr$glmnet.fit,test[,c(-1,-2,-target.col)],s=lr$lambda.1se)
  score.lasso <- cbind(test[,c(1,2)],score)
  names(score.lasso) <- c("itemInfoId","tradeItemInfo","score")
  predict.file <- get.filename("score",next.date)
  write.csv(score.lasso,file=predict.file,row.names=FALSE)
}

lasso.model <- function(prev.date,
        curr.date) {
    file.train <- paste(prev.date,"train",sep='.')
    file.test <- paste(curr.date,"feature",sep='.')
    df.train <- get.data.from.file(file.train,",")
    df.test <- get.data.from.file(file.test,",")
    matrix.train <- as.matrix(df.train)
    matrix.test <- as.matrix(df.test)   
    model.glmnet(matrix.train,matrix.test,prev.date,curr.date)
}


