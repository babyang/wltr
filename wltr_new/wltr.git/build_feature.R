# zhiyuan code using absolute folder name
# source("/home/zhiyuan/Projects/wltr/env_setting.R")
# source("/home/zhiyuan/Projects/wltr/alarm_sms.R")
# source("/home/zhiyuan/Projects/wltr/utils.R")
# source("/home/zhiyuan/Projects/wltr/derive_feature.R")
# source("/home/zhiyuan/Projects/wltr/log_feature.R")
# source("/home/zhiyuan/Projects/wltr/normalize_feature.R")
# source("/home/zhiyuan/Projects/wltr/discrete_price.R")
# source("/home/zhiyuan/Projects/wltr/sequence_behavior.R")
# source("/home/zhiyuan/Projects/wltr/online_behavior.R")

# minxing code using his folder name:
#source("/home/minxing/projects/zhiyuan/wltr/env_setting.R")
#source("/home/minxing/projects/zhiyuan/wltr/alarm_sms.R")
#source("/home/minxing/projects/zhiyuan/wltr/utils.R")
#source("/home/minxing/projects/zhiyuan/wltr/derive_feature.R")
#source("/home/minxing/projects/zhiyuan/wltr/log_feature.R")
#source("/home/minxing/projects/zhiyuan/wltr/normalize_feature.R")
#source("/home/minxing/projects/zhiyuan/wltr/discrete_price.R")
#source("/home/minxing/projects/zhiyuan/wltr/sequence_behavior.R")
#source("/home/minxing/projects/zhiyuan/wltr/online_behavior.R")

source("./env_setting.R")
source("./alarm_sms.R")
source("./utils.R")
source("./derive_feature.R")
source("./log_feature.R")
source("./normalize_feature.R")
source("./discrete_price.R")
source("./sequence_behavior.R")
source("./online_behavior.R")


SelectPcFeatures <- function(df) {
    cols <- c("itemInfoId","tradeItemId")
    cols <- c(cols,"price.50","price.100","price.150","price.200","price.250")
    cols <- c(cols,"pc.click","pc.gmv","pc.order","pc.click.rate","pc.gmv.rate")
    cols <- c(cols,"pc.cross.gmv.click")
   return(df[ ,cols])
}

SelectAppFeatures <- function(df) {
    cols <- c("itemInfoId","tradeItemId")
    cols <- c(cols,"price.50","price.100","price.150","price.200","price.250")
    cols <- c(cols,"app.click","app.gmv","app.order","app.click.rate","app.gmv.rate")
    cols <- c(cols,"app.cross.gmv.click")
   return(df[ ,cols])
}


BuildFeature <- function(args) {

	if (length(args) != 4 ) {
		stop("build feature 参数数目不对")
	}

	file.clean <- args[1]
#	控制是否进行衰减，如果为test进行衰减
	flag.test <- ifelse(args[2]=="test",T,F)
#	控制是否为pc
	flag.pc <- ifelse(args[3]=="pc",T,F)
	file.feature <- args[4]

	df <- ReadTxtData(file.clean)
	df <- SequenceBehavior(df) 
	df <- OnlineFeature(df,flag.test,flag.test)
	df <- DeriveFeature(df)
	df <- DiscretePrice(df)
	df <- LogFeature(df)
	df <- NormFeature(df)

	if (flag.pc == T) {
		df <- SelectPcFeatures(df)
	} else {
		df <- SelectAppFeatures(df)
	}

	SaveTxtData(df,file.feature)
}


args <- commandArgs(TRUE)
BuildFeature(args)







