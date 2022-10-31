######This code retrieves today's currency exchange rates [USD to national currency] from Alpha Ventage and renders data in a world map#######
#Alpha Ventage API documentation: https://www.alphavantage.co/documentation/
#Documentation of library 'alphavantager' for R: https://www.rdocumentation.org/packages/alphavantager

library(maps)
library(alphavantager)
library(tidyverse)
library(leaflet)
library(tidyquant)
library(sfheaders)
library(htmltools)

#get currency codes from https://github.com/datasets/currency-codes
codes <- readr::read_csv("data/codes-all.csv")

rates <- c()
countries <- c()
currencies <- c()
numcalls <- 2      #set the number of national exchange rates to retrieve

# retrieve exchange rate for countries in range 1:numcalls as listed in table 'codes'
for (i in 1:length(codes$NumericCode[1:numcalls])){  
  
  #Make API call
  symbol <- paste(codes$AlphabeticCode[i], "/USD",sep="")
  base <- "https://www.alphavantage.co/query"
  apiKey <- alphavantager::av_api_key("5A80E9FDZ6KO093O")
  dat_alphaventage <- alphavantager::av_get(symbol, av_fun = "FX_DAILY")
  
  #Append API return to vectors
  if (length(dat_alphaventage) == 5){           #if: API call retrieved timestamp, open, high, low, close exchange rates
    
    today <- tail(dat_alphaventage$open, n=1)
    
    rates <- c(rates, today)
    countries <- c(countries, tolower(codes$Entity[i]))
    currencies <- c(currencies, codes$Currency[i])
      
    }
  else{                                         #else: API call returns only error message
    
    rates <- c(rates, NA)
    countries <- c(countries, tolower(codes$Entity[i]))
    currencies <- c(currencies, NA)
      
    }
    
    Sys.sleep(20)                               #sleep to make sure 5 calls/min is not exceeded
    
}

exchange_rates <- data.frame(countries, rates, currencies)      #combine country names and exchange rate vectors in a dataframe

#get world country dataframe and convert column to lower case letter for join
world_ctry <- ggplot2::map_data("world") %>%
  dplyr::mutate(region_lowercase = tolower(region))

#join API return and country dataframe
world_map <- world_ctry %>%
  dplyr::left_join(
    exchange_rates,
    by = c("region_lowercase" = "countries")
  )

#convert dataframe to SpatialPolygonsDataFrame for integration in Leaflet (see https://rstudio.github.io/leaflet/shapes.html)
world_map_sf <- sfheaders::sf_polygon(
  obj = world_map
  , x = "long"
  , y = "lat"
  , polygon_id = "group"
  , keep = TRUE
)

#create map in leaflet (see https://rstudio.github.io/leaflet/choropleths.html)
bins <- c(0.001, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5, Inf)
pal <- colorBin("YlOrRd", domain = world_map_sf$rates, bins = bins)

labels <- sprintf("<strong>%s</strong><br/>1 %s is %g US Dollars </sup>",world_map_sf$region, world_map_sf$currencies, world_map_sf$rates) %>% 
  lapply(htmltools::HTML)

leaflet(data = world_map_sf) %>% 
  addTiles() %>% 
  addPolygons(fillColor = ~pal(rates),
              weight = 2,
              opacity = 1,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.7,
              highlightOptions = highlightOptions(
                weight = 5,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto")) %>%
  setView(lng = 0, lat = 10, zoom = 1.3) %>%
  leaflet::addLegend(pal = pal, values = ~rates, opacity = 0.7, title = NULL,
            position = "bottomright")