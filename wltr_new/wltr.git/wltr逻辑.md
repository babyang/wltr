---
title: "LTR逻辑流程"
author: "qiandu"
date: "Tuesday, December 02, 2014"
output: html_document
---

###ltr crontab任务列表
```
*/5  * * * *   sh -x /home/zhiyuan/Projects/wltr/rank.sh
2 */60  * * * *   sh -x /home/zhiyuan/Projects/wltr/generate_train_model.
```
####rank.sh
```
build_feature.R
predict.R
rerank.R
join_rank.awk
```

#####build_feature.R 构建特征
```
    df<-ReadTxtData(file.clean)
    df <- SequenceBehavior(df) 
	df <- OnlineFeature(df,flag.test,flag.test)
	df <- DeriveFeature(df)
	df <- DiscretePrice(df)
	df <- LogFeature(df)
	df <- NormFeature(df)
```

######SequenceBehavior(df) 离线数据
bookpv clickpv gmvpv orderpv 

```
    df <- SequenceTime(df)
    df <- ExpOfflineSmooth(df)
    #sequenceTime
    df$pc.gmv1day <- 0.01*(df$item_gmv_sum_1day)
    df$pc.gmv3day <- 0.01*(df$item_gmv_sum_3day - df$item_gmv_sum_1day)
    df$pc.gmv7day <- 0.01*(df$item_gmv_sum_7day - df$item_gmv_sum_3day)
    df$pc.gmv15day <- 0.01*(df$item_gmv_sum_15day - df$item_gmv_sum_7day)
   
   #ExpOfflineSmooth
    
    df$pc.click <- exp(0)*df$pc.click1day  +
       exp(-2)*df$pc.click3day  +
       exp(-4)*df$pc.click7day  +
       exp(-8)*df$pc.click15day 
```
######OnlineFeature(df,flag.test,flag.test)实时数据  
第一个flag控制是否进行衰减，如果为test进行衰减;
第二个flag控制是否加实时特征***decay.factor的处理逻辑***

```
df$pc.click <- decay.factor * df$pc.click  + test.factor * exp(1)*df$item_click_pv_0day
```
######DeriveFeature(df)交叉特征数据

```
    #贝叶斯平滑处理ctr,click与gmv交叉特征log处理
    df <- CalcClickRate(df) 
    df <- CalcGmvRate(df)
	df <- CrossClickAndGmv(df)
    
    #crossClickAndGmv
    df$app.cross.gmv.click <- log10(df$app.gmv + 1) * log10(df$app.click + 1)
    
```
######DiscretePrice(df)价格离散化
######LogFeature(df)log平滑处理特征
```
pc.cols <- c("pc.click","pc.gmv","pc.order")
```
######NormFeature归一化

"app.click","app.gmv","app.order", "app.click.rate","app.gmv.rate",	"app.cross.gmv.click"这些特征用最大最小归一化






