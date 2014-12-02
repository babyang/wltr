# learning to rank ml system
# author zhiyuan@mogujie.com
# create 20140731

library(plyr)
library(glmnet)
library(ggplot2)

source("env.setting.R")
source("utils.R")
source("etl.R")
source("cut.sample.R")
source("build.features.R")
source("merge.rank.R")

train.date <- '20140911'
test.date <- '20140913'

source("env.setting.R")
source("utils.R")

ltr.predict <- function(prev.date,curr.date) {
	ridget.predict(prev.date,curr.date,"yifu")
	ridget.predict(prev.date,curr.date,"xiezi")
	ridget.predict(prev.date,curr.date,"bao")
	ridget.predict(prev.date,curr.date,"peishi")
#ridget.predict(prev.date,curr.date,"jing")
#	ridget.predict(prev.date,curr.date,"norm")
}
ridget.predict <- function(prev.date,
        curr.date) {
	model.file <- paste('ridge','rda',sep=".")
    model.file <- get.filename(model.file,prev.date)
    load(model.file)

    file.test <- paste(curr.date,"feature",sep='.')

    df.test <- get.data.from.file(file.test,",")
    test <- as.matrix(df.test)
	target.col <- ncol(df.test)
    score <- predict(lr$glmnet.fit,test[,c(-1,-2,-target.col)],s=lr$lambda.1se)
	score.df <- cbind(df.test,score)
	score.df <- score.df[,c("itemInfoId","tradeItemId","1")]
	names(score.df) <- c("itemInfoId","tradeItemId","score")
    score.row <- order(score.df$score,decreasing=TRUE)
	score.df <- score.df[score.row,]
    predict.file <- get.filename("score",curr.date)
    write.csv(score.df,file=predict.file,row.names=FALSE)
}


print("copy data .... ")
#system.time(get.file.from.date(test.date))
print("copy data done")



print("etl data ......")
#system.time(etl.data(test.date))
print("etl data done")

print("cut data ......")
#system.time(cut.sample(test.date))
print("cut data done")

print("build feature ......")
#system.time(build.features(test.date,"yifu"))
#system.time(build.features(test.date,"xiezi"))
#system.time(build.features(test.date,"bao"))
#system.time(build.features(test.date,"peishi"))
print("build feature done")


print("predict model ......")
ltr.predict(train.date,test.date)
print("build feature done")

