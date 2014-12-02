#source("/home/zhiyuan/l2r/R/env.setting.R")
#source("/home/zhiyuan/l2r/R/utils.R")

source("./env.setting.R")
source("./utils.R")
require(glmnet)
require(doMC)
registerDoMC(cores=12)



ridge.glmnet <- function(train) {
  col.size <- ncol(train)
  x <- as.matrix(train[,1:(col.size-1)])
  y <- as.factor(train[,col.size])
  lr <- cv.glmnet(x,y,family="binomial",type.measure="auc",alpha=0,parallel=TRUE,nfolds=5)
  lr.coef <- as.data.frame(as.matrix(coef(lr$glmnet.fit,lr$lambda.1se)))
  names(lr.coef) <- c("coef")
  return(lr.coef)
}

