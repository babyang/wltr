library(httr)

send <- function(phoneNum, msg){
  url <- 'http://10.11.3.204/receive.php?type=sms'
  args <- list(type="sms", key="related to the Japanese earthquake and tsunami", 
               to=phoneNum, content=msg,eventname="kuma")
  res <- GET(url, query=args)
}

sendSMS <- function(msg){
	send('13666606335', msg)
	send('18657160396', msg)
	send('13521455037', msg)
	send('13675818942', msg)
	send('15158049216', msg)
}
