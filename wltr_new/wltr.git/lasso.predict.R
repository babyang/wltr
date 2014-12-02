source("env.setting.R")
source("utils.R")

get.coef <- function(coef.name) {
    df  <- read.csv(coef.name,
        head=FALSE,
		sep=" ",
        stringsAsFactors=FALSE,
        na.strings=".")
	print(df)
    names(df) <- c("name","coef")
    df[is.na(df)] <- 0
	df <- df[,c("coef")]
    return(df)
}

predict <- function(w,test) {
    test <- as.matrix(test)
    w0 <- w[c(1),]
    wi <- as.matrix(w[c(-1),])

    predicts <- test[,c(-1,-2,-ncol(test))] %*% wi
    predicts <- apply(predicts,1,sum) 
    predicts <- predicts + w0
    predicts <- cbind(test[,c(1,2)],predicts)
    write.csv(predicts,"predicts.csv",row.names = FALSE)
}

w <- get.coef("20140915.ridge.model")
test <- get.data.from.file("20140919.feature",',')
predict(w,test)


