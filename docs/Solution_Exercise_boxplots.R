library(tidyverse)
library(knitr)

#read csv data, Note: Semicolon seperated CSVs can be loaded by function 'read_delim()'
airquality <- read_delim("data/AirQualityUpperAut.csv", delim = ";")

airquality %>%
  dplyr::slice_head(n = 5) %>%
  knitr::kable()

airquality %>%
  dplyr::filter(component == "NO2" & meantype == "HMW") %>%
  dplyr::filter(station == "S125" | station == "S431" | station == "S270") %>%    #select 3 stations
  
  ggplot2::ggplot(.,    
                  aes(            
                    x = value, 
                    fill = station
                    
                  )
  ) +
  
  ggplot2::xlab("NO2 [mg/m^3]") +
  scale_fill_manual(name = "Measurement stations", values = c("grey20", "grey50", "grey80")) +
  ggplot2::geom_boxplot(outlier.size=1) +   
  ggplot2::theme(
    axis.text.y = element_blank(),    #remove text and ticks from y axis
    axis.ticks.y = element_blank()
  )            

