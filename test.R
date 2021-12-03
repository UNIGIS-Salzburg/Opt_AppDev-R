library("ggspatial")
library(sf)
library("ggplot2")

us_states <- sf::st_read("data/us-states.shp")
us_states_points <- st_centroid(us_states)
us_states_points <- cbind(us_states, st_coordinates(st_centroid(us_states$geometry)))

us_states_points


ggplot(data = nc) +
  geom_sf(data = us_states, fill= "antiquewhite1") +
  geom_sf(aes(fill = AREA)) +
  geom_label(data= us_states_points,aes(x=X, y=Y, label=NAME),
            color = "black", fontface = "bold", check_overlap = FALSE, size = 3) +
  annotation_scale(location = "br", width_hint = 0.5) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(11, "cm"), pad_y = unit(0.8, "cm"),
                         style = north_arrow_fancy_orienteering) + 
  scale_fill_viridis_c(trans = "sqrt", alpha = .4) +
  coord_sf(xlim = c(-84.9, -70), ylim = c(24.5, 37), expand = FALSE) +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("US Southeast", subtitle = "(Detail: North Carolina)") +
  annotate(geom = "text", x = -76.5, y = 30.5, label = "Atlantic Ocean", 
           fontface = "italic", color = "grey22", size = 6) +
  theme(panel.grid.major = element_line(color = gray(0.9), linetype = "dashed", 
                                        size = 0.1), panel.background = element_rect(fill = "aliceblue"))
  