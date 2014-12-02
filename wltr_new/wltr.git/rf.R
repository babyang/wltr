#!/usr/bin/env Rscript 
require(randomForest)


rf <- function(train.date,test.date) {
	
   file.train <- paste(train.date,"train",sep='.')
   file.test <- paste(test.date,"feature",sep='.')
  df.train <- get.data.from.file(file.train,",")
   df.test <- get.data.from.file(file.test,",")

  df.train$y <- as.factor(df.train$y)
  model.file <- get.filename("rf.rda",train.date)
  coef.file <- get.filename("rf.model",train.date)
  sink(coef.file)
  rf <- randomForest(y~.,data=df.train,ntree=100)
  print(rf)
  sink()
  save(rf, file = model.file)
  target.col <- ncol(df.test)
  score <- predict(rf,df.test[,c(-1,-2,-target.col)])
  res <- cbind(df.test[,c(1,2)],score)
  predict.file <- get.filename("rf.predict",train.date)
  write.csv(res,file=predict.file,row.names=FALSE)
}
