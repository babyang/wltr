
#ltr.work.path <-"/home/zhiyuan/l2r/"

ltr.work.path <-"./"

data.dir <- paste(ltr.work.path,"data",sep="/")

pic.dir <- paste(ltr.work.path,"pic",sep="/")
hist.dir <- paste(ltr.work.path,"hist",sep="/")
point.dir <- paste(ltr.work.path,"point",sep="/")

stat.na.filename <- paste(data.dir,"stat.na.log",sep="/")
log.na.filename <- paste(data.dir,"contentna.log",sep="/")
log.summary.filename <- paste(data.dir,"summary.log",sep="/")


data1.filename <- paste(data.dir,"20140805",sep="/")
data2.filename <- paste(data.dir,"",sep="/")
data3.filename <- paste(data.dir,"",sep="/")

model.filename <- paste(data.dir,"model",sep="/")
model.pic <- paste(pic.dir,"model",sep="/")

item.profile.factors <- c("source","youpin","level","categoryIds","relYou","shopId")
item.profile.numeric <- c("price","created","sp_health")
style.profile.factors <- c("X3","X4","X5","X6","X7","X8","X9","X10",
                    "X11","X12","X13","X14","X15","X16","X17",
                    "X18","X19","X20","X21","X22","X23","X24",
                    "X25","X26","X27","X28","X29","X30","X31",
                    "X32","X33","X1000","X1001","X11604","X11605",
                    "X11606")

item.book.pv.numerics <- c("item_book_pv_1day","item_book_pv_3day","item_book_pv_7day","item_book_pv_15day","item_book_pv_30day")
item.book.uv.numerics <- c("item_book_uv_1day","item_book_uv_3day","item_book_uv_7day","item_book_uv_15day","item_book_uv_30day")
item.clk.pv.numerics <- c("item_click_pv_1day","item_click_pv_3day","item_click_pv_7day","item_click_pv_15day","item_click_pv_30day")
item.clk.uv.numerics <- c("item_click_uv_1day","item_click_uv_3day","item_click_uv_7day","item_click_uv_15day","item_click_uv_30day")
item.gmv.cnt.numerics <- c("item_gmv_count_1day","item_gmv_count_3day","item_gmv_count_7day","item_gmv_count_15day","item_gmv_count_30day")
item.gmv.sum.numerics <- c("item_gmv_sum_1day","item_gmv_sum_3day","item_gmv_sum_7day","item_gmv_sum_15day","item_gmv_sum_30day")

item.derive.numerics <- c("item_pv_ctr1_1day","item_pv_ctr2_1day","item_pv_ctr1_30day","item_pv_ctr2_30day","item_uv_ctr1_1day")




item.relYou.levels<-c("0","1","2","3")
item.level.levels<-c("1","2")
item.source.levels<-c("8","9")
item.youpin.levels<-c("0","1")


item.relYou.factors<-c("relYou1","relYou2","relYou3")
item.level.factors<-c("level2")
item.source.factors<-c("source9")
item.youpin.factors<-c("youpin1")
item.cat.factors <- c("categoryIds.1160...1191...1203."     
 ,"categoryIds.682...683...684...685."  
 ,"categoryIds.682...683...684...686."  
 ,"categoryIds.682...683...684...687."  
 ,"categoryIds.682...683...684...688."  
 ,"categoryIds.682...683...684...689."  
 ,"categoryIds.682...683...684...690."  
 ,"categoryIds.682...683...684...691."  
 ,"categoryIds.682...683...684...692."  
 ,"categoryIds.682...683...684...693."  
 ,"categoryIds.682...683...684...694."  
 ,"categoryIds.682...683...684...695."  
 ,"categoryIds.682...683...684...696."  
 ,"categoryIds.682...683...684...697."  
 ,"categoryIds.682...683...684...698."  
 ,"categoryIds.682...683...684...699."  
 ,"categoryIds.682...683...684...700."  
 ,"categoryIds.682...683...684...701."  
 ,"categoryIds.682...683...684...702."  
 ,"categoryIds.682...683...684...703."  
 ,"categoryIds.682...683...704...705."  
 ,"categoryIds.682...683...704...706."  
 ,"categoryIds.682...683...704...707."  
 ,"categoryIds.682...683...704...708."  
 ,"categoryIds.682...683...704...709."  
 ,"categoryIds.682...683...710...711."  
 ,"categoryIds.682...683...710...712."  
 ,"categoryIds.682...683...710...713."  
 ,"categoryIds.682...683...710...714."  
 ,"categoryIds.682...683...710...715."  
 ,"categoryIds.682...683...710...716."  
 ,"categoryIds.682...683...710...717."  
 ,"categoryIds.682...683...710...718."  
 ,"categoryIds.682...683...710...719."  
 ,"categoryIds.682...683...710...720."  
 ,"categoryIds.682...683...721...722."  
 ,"categoryIds.682...683...721...723."  
 ,"categoryIds.682...683...721...724."  
 ,"categoryIds.682...683...721...725."  
 ,"categoryIds.682...683...721...726."  
 ,"categoryIds.682...683...721...727."  
 ,"categoryIds.682...683...721...728."  
 ,"categoryIds.682...683...721...729."  
 ,"categoryIds.682...683...721...730."  
 ,"categoryIds.682...683...721...731."  
 ,"categoryIds.682...683...721...732."  
 ,"categoryIds.682...683...721...733."  
 ,"categoryIds.682...683...721...734."  
 ,"categoryIds.682...683...735...736."  
 ,"categoryIds.682...683...735...737."  
 ,"categoryIds.682...683...735...739."  
 ,"categoryIds.682...683...735...740."  
 ,"categoryIds.682...683...741."        
 ,"categoryIds.682...683...742."        
 ,"categoryIds.682...683...743...744."  
 ,"categoryIds.682...683...743...747."  
 ,"categoryIds.682...683...743...750."  
 ,"categoryIds.682...683...751...752."  
 ,"categoryIds.682...683...751...753."  
 ,"categoryIds.682...683...751...754."  
 ,"categoryIds.682...683...751...756."  
 ,"categoryIds.682...757...758."        
 ,"categoryIds.682...757...759."        
 ,"categoryIds.682...757...760."        
 ,"categoryIds.682...757...761."        
 ,"categoryIds.682...757...762."        
 ,"categoryIds.682...757...763."        
 ,"categoryIds.682...757...764."        
 ,"categoryIds.682...757...765."        
 ,"categoryIds.682...757...766...767."  
 ,"categoryIds.682...757...766...768."  
 ,"categoryIds.682...757...766...769."  
 ,"categoryIds.682...757...766...771."  
 ,"categoryIds.682...757...772...774."  
 ,"categoryIds.682...757...772...775."  
 ,"categoryIds.682...757...772...776."  
 ,"categoryIds.682...777...778."        
 ,"categoryIds.682...777...779."        
 ,"categoryIds.682...777...780."        
 ,"categoryIds.682...777...781."        
 ,"categoryIds.682...777...782."        
 ,"categoryIds.682...777...783."        
 ,"categoryIds.682...777...784."        
 ,"categoryIds.682...777...785...786."  
 ,"categoryIds.682...777...785...787."  
 ,"categoryIds.682...777...785...788."  
 ,"categoryIds.682...777...789."        
 ,"categoryIds.682...777...790."        
 ,"categoryIds.682...777...791."        
 ,"categoryIds.682...777...791...792."  
 ,"categoryIds.682...777...791...793."  
 ,"categoryIds.682...777...791...794."  
 ,"categoryIds.682...795...1088."       
 ,"categoryIds.682...795...1257."       
 ,"categoryIds.682...795...1257...1258."
 ,"categoryIds.682...795...1257...1259."
 ,"categoryIds.682...795...1257...1260."
 ,"categoryIds.682...795...1257...1261."
 ,"categoryIds.682...795...1262."       
 ,"categoryIds.682...795...796."        
 ,"categoryIds.682...795...797."        
 ,"categoryIds.682...795...798."        
 ,"categoryIds.682...795...799."        
 ,"categoryIds.682...795...800."        
 ,"categoryIds.682...795...800...801."  
 ,"categoryIds.682...795...800...802."  
 ,"categoryIds.682...795...800...803."  
 ,"categoryIds.682...795...800...804."  
 ,"categoryIds.682...795...805."        
 ,"categoryIds.682...795...806."        
 ,"categoryIds.682...795...807."        
 ,"categoryIds.682...795...808."        
 ,"categoryIds.682...795...809."        
 ,"categoryIds.682...795...810."        
 ,"categoryIds.682...795...811."        
 ,"categoryIds.682...795...812."        
 ,"categoryIds.682...795...813."        
 ,"categoryIds.682...795...814."        
 ,"categoryIds.682...795...815."        
 ,"categoryIds.682...795...816."        
 ,"categoryIds.682...795...817."        
 ,"categoryIds.682...795...818."        
 ,"categoryIds.682...795...819."        
 ,"categoryIds.682...795...820."        
 ,"categoryIds.821...869...876."        
 ,"categoryIds.821...889...890."        
 ,"categoryIds.821...889...891."        
 ,"categoryIds.821...889...894."        
 ,"categoryIds.821...906...908."        
 ,"categoryIds.821...906...910."        
 ,"categoryIds.925...1009...1010."      
 ,"categoryIds.925...1014...1018."      
 ,"categoryIds.925...1014...1022."      
 ,"categoryIds.925...1032...1044."      
 ,"categoryIds.925...926...933."        
 ,"categoryIds.925...952...965.")        

factor.cols <- c(item.profile.factors,style.profile.factors)

numeric.cols <- c(item.book.pv.numerics,item.book.uv.numerics,
        item.clk.pv.numerics,item.clk.uv.numerics,
        item.gmv.cnt.numerics,item.gmv.sum.numerics,
        item.profile.numeric)

log.cols <- c(item.book.pv.numerics,item.book.uv.numerics,
  item.clk.pv.numerics,item.clk.uv.numerics,
  item.gmv.cnt.numerics,item.gmv.sum.numerics)
