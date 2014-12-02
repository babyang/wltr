require(glmnet)
require(doMC)
registerDoMC(cores=12)



modelWithLR <- function(train) {
    colSize <- ncol(train)
    x <- as.matrix(train[,seq(colSize-1)])
	 y <- train[,colSize]
    lr <- cv.glmnet(x,y,family="gaussian",type.measure="mse",alpha=0,parallel=TRUE,nfolds=5)
    coef <- as.data.frame(as.matrix(coef(lr$glmnet.fit,lr$lambda.1se)))
    names(coef) <- c("coef")
    return(coef)
}



training <- function(instances,step) {
    instances.matrix <- as.matrix(instances)
    model <- modelWithLR(instances.matrix)
    return(model)
}

reSample <- function(instances) {
    plusSample <- subset(instances,y==1)
    minusSample <- subset(instances,y==0)
    
    plusSize <- nrow(plusSample)
    minusSize <- nrow(minusSample)
    
    row <- sample(minusSize,plusSize)
    minusSample <- minusSample[row,]
    train <- rbind(plusSample,minusSample)
    return(as.matrix(train))
}

mergeSample <- function(src,dst) {
    instances <- merge(src,dst,by="tradeItemId")  
    return (instances[,c(-1,-2)])
}

train  <- function(args) {
    trainFilename  <- args[1]
    labelFilename <- args[2]
    modelFilename  <- args[3]
    
    step = as.numeric(args[4])

    trainData <- readDataFromCSV(trainFilename)
    labelData <- readDataFromCSV(labelFilename)
    sample <- mergeSample(trainData,labelData)
    model <- training(sample,step)
    write.table(model,file=modelFilename,sep=":",row.names=TRUE,col.names=FALSE)
}

train1 <- function(args) {
    sampleFilename  <- args[1]
    modelFilename  <- args[2]
    step = as.numeric(args[3])

    sample <- readDataFromCSV(sampleFilename)
    model <- training(sample,step)
    write.table(model,file=modelFilename,sep=":",row.names=TRUE,col.names=FALSE)
}

readDataFromCSV <- function(filename) {
    return(read.table(filename,
                      sep=",",
                      na.strings = "NULL",
                      stringsAsFactors=FALSE,
                      header=TRUE))
}

args <- commandArgs(TRUE)
train(args)
