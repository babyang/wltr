# learning to rank ml system
# author zhiyuan@mogujie.com
# create 20140731
library(plyr)
library(glmnet)
library(ggplot2)

source("env.setting.R")
source("utils.R")
source("etl.R")
source("build.features.R")
source("training.R")
source("rf.R")
source("lasso.model.R")

train.date <- '20140904'
test.date <- '20140905'

print("copy data .... ")
#system.time(get.file.from.date(test.date))
#system.time(get.file.from.date(train.date))
print("copy data done")



print("etl data ......")
#system.time(etl.data(test.date))
#system.time(etl.data(train.date))
print("etl data done")


print("build feature ......")
system.time(build.features(test.date))
system.time(build.features(train.date))
print("build feature done")


print("generate train data ......")
system.time(generate.train(train.date,test.date))
print("generate train data  done")

print("building glmnet model ......")
system.time(lasso.model(train.date,test.date))
print("done")

