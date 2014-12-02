require(glmnet)
require(doMC)
registerDoMC(cores=12)

# zhiyuan code using absolute folder name
# source("/home/zhiyuan/Projects/wltr/utils.R")
# source("/home/zhiyuan/Projects/wltr/alarm_sms.R")

# minxing code using his folder name
#source("/home/minxing/projects/zhiyuan/wltr/utils.R")
#source("/home/minxing/projects/zhiyuan/wltr/alarm_sms.R")

source("./utils.R")
source("./alarm_sms.R")


ModelWithLR <- function(train) {
    num.cols <- ncol(train)
	if (num.cols < 1) {
		SendSMS("训练集变量数少于1")
	}
    x <- as.matrix(train[ ,seq(num.cols - 1)])
    y <- as.factor(train[ ,num.cols])
    lr <- cv.glmnet(x,y,family="binomial",type.measure="auc",alpha=0,parallel=TRUE,nfolds=5)
    coef <- as.data.frame(as.matrix(coef(lr$glmnet.fit,lr$lambda.1se)))
    names(coef) <- c("coef")
	coef <- data.frame(feature=row.names(coef),coef)
	row.names(coef) <- NULL
    return(coef)
}



Training <- function(instances,step) {
    instances.matrix <- ReSample(instances)
    model.mean <- ModelWithLR(instances.matrix)
    
    for ( i in seq(step-1)) {
        instances.matrix <- ReSample(instances)
        model <- ModelWithLR(instances.matrix)
        model.mean$coef <- model.mean$coef + model$coef
	
    }
    model.mean$coef <- model.mean$coef 
    return(model.mean)
}

ReSample <- function(instances) {
    sample.plus <- subset(instances,y==1)
    sample.minus <- subset(instances,y==0)
    
    nrow.plus <- nrow(sample.plus)
    nrow.minus <- nrow(sample.minus)
    row <- sample(nrow.minus,nrow.plus)
    sample.minus <- sample.minus[row, ]
    train <- rbind(sample.plus,sample.minus)
    return(as.matrix(train))
}

MergeSample <- function(src,dst) {
    instances <- merge(src,dst,by="tradeItemId")  
    return (instances[ ,c(-1,-2)])
}

Train  <- function(args) {

	file.train <- args[1]
	file.label <- args[2]
	file.model <- args[3]
    step = as.numeric(args[4])

	train.feature <- ReadTxtData(file.train)
	train.label <- ReadTxtData(file.label)

    train.sample <- MergeSample(train.feature,train.label)
    model <- Training(train.sample,step)
	SaveTxtData(model,file.model)
}



args <- commandArgs(TRUE)
Train(args)
