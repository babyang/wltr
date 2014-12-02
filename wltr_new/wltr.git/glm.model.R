source("env.setting.R")
source("utils.R")
require(doMC)
registerDoMC(cores=10)

model.glm <- function(train,test,date) {
  
 train$y <- as.factor(train$y) 
  lr <- glmnet(y~.,family="binomial",data=train,alpha=0)
  png(file="../pic/glm.model.png", bg="transparent")
  plot(lr)
  dev.off()

  filename <- get.filename("glm.model",date)
  sink(filename)
  print(summary(lr)) #系数
  sink()

  score <- predict(lr,test[,c(-1,-2)])
  score.data <- cbind(test[,c(1,2)],score)
  filename <- get.filename("glm.predict",date)
  write.csv(score.data,file=filename,row.names=FALSE)
}


df.train <- get.data.from.file("20140811.train",",")
df.test <- get.data.from.file("20140812.feature",",")
model.glm(df.train,df.test,"20140811")
