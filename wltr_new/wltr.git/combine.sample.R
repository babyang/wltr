# learning to rank ml system
# author zhiyuan@mogujie.com
# create 20140731
# zhiyuan code using his folder
#source("/home/zhiyuan/l2r/R/env.setting.R")
#source("/home/zhiyuan/l2r/R/utils.R")
#source("/home/zhiyuan/l2r/R/etl.R")
#source("/home/zhiyuan/l2r/R/generate.feature.R")
#source("/home/zhiyuan/l2r/R/ridge.model.R")
#source("/home/zhiyuan/l2r/R/cut.sample.R")


source("./env.setting.R")
source("./utils.R")
source("./etl.R")
source("./generate.feature.R")
source("./ridge.model.R")
source("./cut.sample.R")


train.date <- '20140930'

args <- commandArgs(TRUE)
test.date <- args[1]
#print("copy data .... ")
system.time(get.file.from.date(test.date))
#system.time(get.file.from.date(train.date))
#print("copy data done")



#print("etl data ......")
system.time(etl.data(test.date))
#system.time(etl.data(train.date))
#print("etl data done")

#print("cut data ......")
system.time(cut.sample(test.date))
#system.time(cut.sample(train.date))
#print("cut data done")

print("build feature ......")
system.time(build.features(test.date))
#system.time(build.features(train.date))
print("build feature done")


#print("generate train data ......")
#system.time(generate.train(train.date,test.date))
#print("generate train data  done")


#print("building ridge  model ......")
#system.time(ridge.predict(train.date,test.date))
#print("done")

#print("merge rank model ......")
#system.time(merge.rank(test.date))
#print("done")
