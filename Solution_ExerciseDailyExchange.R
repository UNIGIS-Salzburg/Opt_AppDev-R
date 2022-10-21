#documentation alphavantager https://www.rdocumentation.org/packages/alphavantager/versions/0.1.2/topics/av_get

#Our standard API call frequency is 5 calls per minute and 500 calls per day
#--> use for loop method with 20 sec sleep intervals? use other example?

library(maps)
library(alphavantager)
library(tidyverse)
library(leaflet)
library(tidyquant)


#get currency codes from https://github.com/datasets/currency-codes
codes <- readr::read_csv("data/codes-all.csv")


symbols <- paste(codes$AlphabeticCode, "/USD",sep="")

base <- "https://www.alphavantage.co/query"
apiKey <- av_api_key("5A80E9FDZ6KO093O")
dat_alphaventage <- tq_get(symbols, get = "alphavantage", av_fun = "FX_DAILY") #%>%
  #dplyr::filter(timestamp==max(timestamp))
#today <- tail(dat_alphaventage$open, n=1)

max(dat_alphaventage$timestamp)

#[nrow(dat_alphaventage),2]

rates <- c()

# retrieve exchange rate for every country
for (code in codes$AlphabeticCode){  #codes[,3]

  #if (!is.na(code)){
    Sys.sleep(5)
  
    
    symbol <- paste(code, "/USD",sep="")
    
    base <- "https://www.alphavantage.co/query"
    apiKey <- av_api_key("5A80E9FDZ6KO093O")
    dat_alphaventage <- av_get(symbol, av_fun = "FX_DAILY")
    today <- tail(dat_alphaventage$open, n=1)
    
    print(today)
    
    if (!is.null(today)){
      
      rates <- c(rates, today)
      
    }
    else{
      
      rates <- c(rates, NA)
      
    }
    
    
    
 # }
  #else{
    
  #  rates <- c(rates, NA)
    
    
#  }

  
}

print(rates)


mapStates <- maps::map("world", fill = TRUE, plot = FALSE)


leaflet(data = mapStates) %>% 
  addTiles() %>% 
  addPolygons() %>%
  setView(lng = 0, lat = 10, zoom = 1.3)