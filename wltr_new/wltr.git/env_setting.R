# zhiyuan code using his folder name
# exec.path <- "/home/zhiyuan/Projects/wltr/"
# data.path <- "/home/zhiyuan/Projects/data/"

# minxing code using his folder name
exec.path <- "./"
data.path <- "./data/"

exec.path <- "./"
data.path <- "./data/"


book.prefix <- "item_book_pv"
click.prefix <- "item_click_pv"
gmv.prefix <- "item_gmv_sum"
order.prefix <- "item_gmv_count"

time.seq <- c("0","1","3","7","15")
day.seq <- paste(time.seq,"day",sep="")


book.cols <- paste(book.prefix,day.seq,sep="_")
click.cols <- paste(click.prefix,day.seq,sep="_")
gmv.cols <- paste(gmv.prefix,day.seq,sep="_")
order.cols <- paste(order.prefix,day.seq[c(-1)],sep="_")

pc.book.cols <- book.cols 
pc.click.cols <- click.cols 
pc.gmv.cols <- gmv.cols 
pc.order.cols <- order.cols 

app.book.cols <- paste(book.cols,"app",sep="_")
app.click.cols <- paste(click.cols,"app",sep="_")
app.gmv.cols <- paste(gmv.cols,"app",sep="_")
app.order.cols <- paste(order.cols,"app",sep="_")

check.cols <- c(pc.book.cols,
		pc.click.cols,
		pc.gmv.cols,
		pc.order.cols,
		app.book.cols,
		app.click.cols,
		app.gmv.cols,
		app.order.cols)

pc.book.col <- "pc.book"
pc.click.col <- "pc.click"
pc.gmv.col <- "pc.gmv"
pc.order.col <- "pc.order"

app.book.col <- "app.book"
app.click.col <- "app.click"
app.gmv.col <- "app.gmv"
app.order.col <- "app.order"


valid.size <- 10000

