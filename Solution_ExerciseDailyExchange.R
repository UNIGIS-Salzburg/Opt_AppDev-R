library(httr)

base <- "https://www.alphavantage.co/query"
func <- "FX_DAILY"
from <- "EUR"    
to <- "USD"
apiKey <- "5A80E9FDZ6KO093O"

call <- paste(base, "?function=", func, "&from_symbol=" , from, "&to_symbol=", to, "&apikey=", apiKey, sep="")

get <- GET(call)

#t <- Sys.Date()
#assign(t)
#substr(t,1,1)
#today <- as.character(Sys.Date())
#substr(today,1,1)

test <- content(get)
test1 <- content(get)[2]$`Time Series FX (Daily)`$`2022-10-20`$`1. open`
test2 <- content(get)[2]$`Time Series FX (Daily)`$`2022-10-20`$`1. open`
#test1 <- test$`Time Series FX (Daily)`
#test2 <- test1$`2022-10-20`
#test2$`1. open`


#`2022-10-20`

#str(content(get))

#status_code(get)

#print(call)
