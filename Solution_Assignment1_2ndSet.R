# required skills: 1) get typeof() vector etc., 2) how to execute code in RStudio?, execute parts of the code
# 3) return functions, also multiple return values (ok), 4) while loops (ok), 5) system time and system sleep
# 6) retrieve data by API (ok), 7) ggplot visualization, 8) append to vector (ok)


library(httr)
library(jsonlite)
library(lubridate)
library(ggplot2)
library(sf)

locations <- sf::st_read("data/nc-centroids.shp")

coords <- sf::st_coordinates(locations)
coords[1,2]
coords[,1]
coords[,2]
coords[1,]
coords[1,][1]
coords[2,]
nrow(coords)

for (r in 1:nrow(coords)){
  
  print(coords[r,][1])
  print(coords[r,][2])
  
}

#functions retrieves current weather data at location lat/lon
weather_retrieve <- function(lat_num, lon_num, key_string){
  
  base <- "http://api.openweathermap.org/data/2.5/weather"
  lat <- toString(lat_num)    
  lon <- toString(lon_num)
  apiKey <- key_string
  
  call <- paste(base, "?lat=", lat, "&lon=" , lon, "&appid=", apiKey, sep="")
  
  get <- GET(call)
  get_text <- content(get, "text")
  get_json <- fromJSON(get_text, flatten = TRUE)
  get_df <- as.data.frame(get_json)
  
  return_vals <- list("y" = lat_num, "x" = lon_num, "temp" = get_df$main.temp - 273.15) # append temperature and coordinates in a list
  
  return_vals  #return coordinates and temperature

}

temp_vec <- c()                 # initialize vector outside loop and append within loop 
x_vec <- c()
y_vec <- c()


for (r in 1:nrow(coords)){
  
  x_vec <- c(coords[r,][1])
  y_vec <- c(coords[r,][2])
  temp_vec <- c(temp_vec, weather_retrieve(coords[r,][2], coords[r,][1], "3f87141421b32590d50416aae5ca780c")[[3]])

}

result_df <- data.frame(x_vec, y_vec, temp_vec) # vectors (x, y and temperature) to data frame

print(result_df)


# retrieve data a predefined number of times
rep <- 0
while (rep < 40){    # 40 x 15 min = 10h
  
  rep <- rep + 1
  
  hum_vec <- c(hum_vec, weather_retrieve(47.8, 13.033, "3f87141421b32590d50416aae5ca780c")[[1]]) #retrieve time element from function return
  temp_vec <- c(temp_vec, weather_retrieve(47.8, 13.033, "3f87141421b32590d50416aae5ca780c")[[2]]) #retrieve temperature element from function return

  
  print("step")
  
  Sys.sleep(900) # interrupt 900 sec, temp. resolution = 15 min
  
}

result_df <- data.frame(hum_vec, temp_vec) # two vectors (humidity and temperature) to data frame

print(result_df)

p <- ggplot(result_df, aes(x=hum_vec, y=temp_vec)) +
  geom_point()

p



