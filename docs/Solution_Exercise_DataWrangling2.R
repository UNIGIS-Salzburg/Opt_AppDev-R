library(ggplot2) #new
library(maps)    #new
library(tidyverse)
library(knitr)

fao_data <- read.csv("enter file directory", header = TRUE, sep = ",")   #enter file directory

sorghum_production <- fao_data %>% 
  dplyr::select(Area, Item, Element, Unit, Y2019) %>%                  
  dplyr::filter(Item == "Sorghum", Element == "Production") %>%   
  dplyr::arrange(-Y2019)  

#create data frame from maps dataset 'world'
world_ctry <- map_data("world") 

# left table
africa_sorghum_production <- world_ctry %>%
  # inner join
  dplyr::left_join(
    # right table
    sorghum_production,
    #columns to match
    by = c("region" = "Area")
  )

ggplot(africa_sorghum_production, aes(x = long, y = lat)) +
  geom_polygon(aes( group = group, fill = Y2019)) +
  scale_fill_gradient(
    low = "white",
    high = "red",
    space = "Lab",
    na.value = "grey80",
    guide = "colourbar",
    aesthetics = "fill"
  )

