
#source("/home/zhiyuan/Projects/wltr/check_data.R")

source("./check_data.R")


TestCheckRaw <- function(args) {
	filename <- args[1]
	df <- read.table(filename,
			sep="\t",
			header=T,
			stringsAsFactors=F)
	CheckRaw(df)
}


args <- commandArgs(T)
TestCheckRaw(args)
