library(tidyverse)
library(knitr)

# Read data from comma-separated csv
fao_data <- read.csv("enter file directory", header = TRUE, sep = ",")

fao_data %>% 
  dplyr::select(Area, Item, Element, Unit, Y2019) %>%              #limit columns    
  dplyr::filter(Item == "Sorghum", Element == "Production") %>%    #limit rows
  dplyr::group_by(Area) %>%                                        #get production sum per country
  dplyr::summarise(yield_2019 = sum(Y2019)) %>%
  dplyr::arrange(-yield_2019) %>%                                  #sort descending by production in 2019
  drop_na() %>%                                                    #remove rows including NAs
  knitr::kable()

#Note: When using pipe operators, there is no need to pass outputs as parameter functions!
#(e.g. the parameter list of function drop_na() is empty)
