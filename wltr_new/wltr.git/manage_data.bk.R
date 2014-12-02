#
#
#
# zhiyuan code using his folder name
#source("/home/zhiyuan/Projects/wltr/utils.R")
#source("/home/zhiyuan/Projects/wltr/check_data.R")

# minxing code using his folder name
#source("/home/minxing/projects/zhiyuan/wltr/utils.R")
#source("/home/minxing/projects/zhiyuan/wltr/check_data.R")

source("./utils.R")
source("./check_data.R")



CopyRawData <-  function(path.src,
		path.check,
		file.dst,
		index=1) {

	# Copy file from path.src to file.dst
	# Args :
	#	path.src 
	#	file.dst
	files <- sort(dir(path.src),decreasing=T)
	file.src <- paste(path.src,files[index],sep="/")
	file.check <- paste(path.check,files[index],sep="/")
	file.check <- paste(file.check,"finish",sep=".")
	WaitFileReady(file.check)
	if (file.exists(file.dst)) {
		file.remove(file.dst)
	}

	file.copy(file.src,file.dst)
}

WaitFileReady <- function(file.check,
		time.sleep=10) {
	
	# 检查文件是否可以读数据
	# Args :
	#	file.check 文件标记，如果文件存在就可以读数据
	#	time.sleep 如果文件不存在，等待时间
	ready <- F
	print(file.check)
	for ( i in seq(30) ) {

		if (file.exists(file.check)) {
			str('file ready')
			ready <- T
			break
		}

		str('waiting')
		Sys.sleep(time.sleep)
	}

	if (ready == F) {
		str('timeout')
		SendSMS('read 15min data file timeout')
	}

}





FillNA <- function(df) {
	# 用0填充NA
	# Args :
	#	df 处理的数据框
	df[is.na(df)] <- 0
    return(df)
}



CleanData <- function(file.raw,
		file.clean)
		 {
	
	# 清洗数据，包含缺失值,异常值
	# Args :
	#	df 处理的数据框
	data.raw <- ReadTxtData(file.raw)
#	row <- names(data.raw) %in% "item_gmv_sum_0day"
#	if (length(which(row))==0) data.raw$item_gmv_sum_0day<-0.4
#	row <- names(data.raw) %in% "item_gmv_sum_0day_app"
#	if (length(which(row))==0) data.raw$item_gmv_sum_0day_app<-0.4

	data.clean <- FillNA(data.raw)

	row.clean <- grepl("X",names(data.clean)) | grepl("cart",names(data.clean))
	data.clean <- data.clean[ ,names(data.clean)[!row.clean]]

	CheckRaw(data.clean)

	return(data.clean)
}




#args <- commandArgs(TRUE)
#ManageData(args)

