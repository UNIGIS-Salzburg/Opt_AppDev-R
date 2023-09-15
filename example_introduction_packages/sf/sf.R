# req
library(sf)

# point
# Create a point
point <- st_point(c(5, 5))

# Convert to spatial feature
point_sf <- st_sf(geometry = st_sfc(point))

# Plot the point
plot(point_sf)


# line
# Create a line from a matrix of coordinates
line <- st_linestring(matrix(1:6, 3, 2))

# Convert to spatial feature
line_sf <- st_sf(geometry = st_sfc(line))

# Plot the line
plot(line_sf)


# polygon
# Create a matrix of coordinates
coords <- matrix(c(2,2, 4,4, 4,2, 2,2), ncol = 2, byrow = TRUE)

# Create a list of matrices (in this case, just one matrix)
list_of_coords <- list(coords)

# Create the polygon
polygon <- st_polygon(list_of_coords)

# Convert to spatial feature
polygon_sf <- st_sf(geometry = st_sfc(polygon))

# Plot the polygon
plot(polygon_sf)

