library(httr)

base <- "http://api.openweathermap.org/data/2.5/weather"
lat <- "47.81"    
lon <- "13.03"
apiKey <- "3f87141421b32590d50416aae5ca780c"

call <- paste(base, "?lat=", lat, "&lon=" , lon, "&appid=", apiKey, sep="")

print(call)
get <- GET(call) # response object CHANGED!
status_code(get) # status code
str(content(get)) # gives content information

library(jsonlite)

get_text <- content(get, "text")                 #retrieve contents of request as character vector (library httr)
get_json <- fromJSON(get_text, flatten = TRUE)   #convert from JSON to R Object (library jsonlite)
get_df <- as.data.frame(get_json)                #convert R Object to Data Frame
