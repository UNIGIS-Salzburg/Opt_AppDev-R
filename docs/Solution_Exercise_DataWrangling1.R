library(tidyverse)
library(knitr)

# Read data from comma-separated csv
fao_data <- read.csv("file/directory", header = TRUE, sep = ",")  

fao_data %>% 
  dplyr::select(Area, Item, Element, Unit, Y2019) %>%              #limit columns    
  dplyr::filter(Item == "Sorghum", Element == "Production") %>%    #limit rows
  dplyr::arrange(-Y2019) %>%                                       #sort descending by production in 2019
  drop_na() %>%                                                    #remove rows including NAs
  knitr::kable()


