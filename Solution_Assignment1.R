library(httr)
library(jsonlite)
library(lubridate)
library(ggplot2)

#functions retrieves current weather data at location lat/lon
weather_retrieve <- function(lat_num, lon_num, key_string){
  
  base <- "http://api.openweathermap.org/data/2.5/weather"
  lat <- toString(lat_num)    
  lon <- toString(lon_num)
  apiKey <- key_string
  
  call <- paste(base, "?lat=", lat, "&lon=" , lon, "&appid=", apiKey, sep="")
  
  get_UVI <- GET(call)
  get_UVI_text <- content(get_UVI, "text")
  get_UVI_json <- fromJSON(get_UVI_text, flatten = TRUE)
  get_UVI_df <- as.data.frame(get_UVI_json)
  
  return_vals <- list("time" = as_datetime(get_UVI_df$dt, tz = "MET"), "temp" = get_UVI_df$main.temp - 273.15) # append time and temperature in a list
  
  return_vals  #return time and temperature

}

time_plus <- Sys.time() + 600

# retrieve data as long as current time < time_plus
while (Sys.time() < time_plus){
  
  time_vec <- c(time_vec, weather_retrieve(47.8, 13.033, "3f87141421b32590d50416aae5ca780c")[1]) #retrieve time element from function return
  temp_vec <- c(time_vec, weather_retrieve(47.8, 13.033, "3f87141421b32590d50416aae5ca780c")[2]) #retrieve temperature element from function return
  
  Sys.sleep(60) # interrupt 60 sec
  
}

result_df <- data.frame(time_vec, temp_vec)

print(result_df)


#p <- ggplot(data=dat1, aes(x=time, y=total_bill, group=sex)) +
#  geom_line() +
#  geom_point()


#print(Sys.time())



print(time_plus)

