library(sf)

# We read the shapefile and assign it to variable nc
nc <- sf::st_read("data/nc.shp")

# Initial plot of the entire dataset
plot(nc)

# Display a subset of the data with selected columns
nc %>%
  dplyr::select(AREA, NAME, geometry) %>%
  dplyr::slice_head(n = 3) %>%
  knitr::kable()

# Simplify the geometry and plot the result
sf::st_simplify(nc) %>%
  plot(., max.plot = 1)

# And finally, focusing on the AREA attribute with a meaningful title:
plot(nc["AREA"], main = "Area of NC counties") 
