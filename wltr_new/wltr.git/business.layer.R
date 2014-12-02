#!/usr/bin/env Rscript


train.date <- 20140830
train.file <- paste('../data',train.date,sep='/')
rank.file <- paste(train.file,'rank',sep='.')
item.data <- read.table(train.file,
		header=TRUE,
		stringsAsFactors=TRUE,
		sep="\t")

item.rank <- read.table(rank.file,
		header=TRUE,
		stringsAsFactors=TRUE,
		sep=',')

item.cat <- item.data[,c('tradeItemId','categoryIds')]
item.rank.cat <- merge(item.cat,item.rank,by="tradeItemId")
item.rank.cat <- item.rank.cat[seq(165),]
#print(nrow(item.rank.cat[grep('683',item.rank.cat$categoryIds),]))

