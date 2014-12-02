

training <- function(instances,step) {
	instances.matrix <- reSample(instances)
	model.mean <- ridge.glmnet(instances.matrix)

	for ( i in seq(step-1)) {
		instances.matrix <- ensemble.instances(instances)
		model <- ridge.glmnet(instances.matrix)
		model.mean$coef <- model.mean$coef + model$coef
	}
	model.mean$coef <- model.mean$coef / step
	return(model.mean)
}

reSample <- function(instances) {
  plusSample <- subset(instances,y==1)
  minusSample <- subset(instances,y==0)
  
  plusSize <- nrow(plusSample)
  minusSize <- nrow(minusSample)
  
  row <- sample(minusSize,plusSize)
  minusSample <- minsSample[row,]
  train <- rbind(plusSample,minusSample)
  return(as.matrix(train))
}

mergeSample <- function(src,dst) {
  instances <- merge(src,dst,by="tradeItemId")  
  return (instances[,c(-1,-2)])
}

train  <- function(args) {
	file.train  <- args[1]
	file.target <- args[2]
	file.model  <- args[3]

	step = as.numeric(args[4])

	df.train <- read.table(file.train,
			sep=",",
			header=TRUE,
			stringsAsFactors=FALSE)

	df.target <- read.table(file.target,
			sep=",",
			header=TRUE,
			stringsAsFactors=FALSE)
    sample <- mergeSample(df.train,df.target)
	model <- training(sample,step)
	write.table(model,file=file.model,sep=",")
}



args <- commandArgs(TRUE)
train(args)
