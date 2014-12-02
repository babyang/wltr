# zhiyuan original code using absolute folder name
#source("/home/zhiyuan/Projects/wltr/utils.R")
#source("/home/zhiyuan/Projects/wltr/manage_data.R")

# minxing code using relateive folder name

#source("/home/minxing/projects/zhiyuan/wltr/utils.R")
#source("/home/minxing/projects/zhiyuan/wltr/manage_data.R")

source("./utils.R")
source("./manage_data.R")


GenerateTrainSample <- function(args) {
	# 生成训练集
	# Args :
	#	path.src 从原始文件夹拷贝最新数据文件
	#	path.check 标记文件夹，标志文件已经写完整
	#	file.raw  拷贝过来的原始文件
	#	file.clean 清洗后的文件
	if (length(args) != 4){
		stop("generate train sample 参数数目不对")
	}
	path.src <- args[1]
	path.check <- args[2]
	file.raw <- args[3]
	file.clean <- args[4]

        print(paste("copying ", path.src, " to ", file.raw))
	CopyRawData(path.src,path.check,file.raw)
	data.clean <- CleanData(file.raw,file.clean)
	SaveTxtData(data.clean,file=file.clean)
}

args <- commandArgs(TRUE)
GenerateTrainSample(args)

