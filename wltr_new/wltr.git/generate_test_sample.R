source("./manage_data.R")
source("./build_business_layer.R")

GenerateTestSample <- function(args) {
	# 生成训练集
	# Args :
	#	path.src 从原始文件夹拷贝最新数据文件
	#	path.check 标记文件夹，标志文件已经写完整
	#	file.raw  拷贝过来的原始文件
	#	file.clean 清洗后的文件
	#	file.buss 业务层基础数据，作为rerank的输入
	if (length(args) != 5 ) {
		stop("generate test sample 参数数目不对")
	}
	path.src <- args[1]
	path.check <- args[2]
	file.raw <- args[3]
	file.clean <- args[4]
	file.buss <- args[5]

	CopyRawData(path.src,path.check,file.raw)
	data.clean <- CleanData(file.raw,file.clean)
	SaveTxtData(data.clean,file=file.clean)
	data.buss <- BuildBusinessLayer(data.clean)
	SaveTxtData(data.buss,file=file.buss)
}

args <- commandArgs(TRUE)
GenerateTestSample(args)

