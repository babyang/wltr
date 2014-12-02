
#source("/home/zhiyuan/Projects/wltr/utils.R")
#source("/home/zhiyuan/Projects/wltr/manage_data.bk.R")

source("./utils.R")
source("./manage_data.bk.R")


GenerateTrainSample <- function(args) {

	if (length(args) != 3 ) {
		stop("generate train sample 参数数目不对")
	}
	path.src <- args[1]
	path.check <- args[2]
	file.raw <- args[3]
	file.clean <- args[4]

	CopyRawData(path.src,path.check,file.raw)
	data.clean <- CleanData(file.raw,file.clean)
	SaveTxtData(data.clean,file=file.clean)
}

args <- commandArgs(TRUE)
GenerateTrainSample(args)

