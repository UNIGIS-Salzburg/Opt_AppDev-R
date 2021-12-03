library(sf)

nc <- sf::st_read("data/nc.shp")

plot(nc["AREA"], main = "Area of NC counties")