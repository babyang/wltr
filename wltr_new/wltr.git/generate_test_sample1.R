# zhiyuan code using absolute folder name
# source("/home/zhiyuan/Projects/wltr/manage_data.bk.R")
# source("/home/zhiyuan/Projects/wltr/build_business_layer.R")

# minxing code using his folder name
#source("/home/minxing/projects/zhiyuan/wltr/manage_data.bk.R")
source("./manage_data.bk.R")


#source("/home/minxing/projects/zhiyuan/wltr/build_business_layer.R")

source("./build_business_layer.R")


GenerateTestSample <- function(args) {
	print(args)
	if (length(args) != 5 ) {
		stop("generate test sample 参数数目不对")
	}
	path.src <- args[1]
	path.check <- args[2]
	file.raw <- args[3]
	file.clean <- args[4]
	file.buss <- args[5]
        
	print(paste("copying ", path.src, "to ", file.raw))
	CopyRawData(path.src,path.check,file.raw)
	data.clean <- CleanData(file.raw,file.clean)
	SaveTxtData(data.clean,file=file.clean)
	data.buss <- BuildBusinessLayer(data.clean)
	SaveTxtData(data.buss,file=file.buss)
}

args <- commandArgs(TRUE)
GenerateTestSample(args)

