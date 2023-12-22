library(tidyverse)
library(knitr)

# read csv data, Note: Semicolon seperated CSVs can be loaded by function 'read_delim()'
airquality <- read_delim("data/AirQualityUpperAut.csv", delim = ";")

# half-hourly temperature measurement of station S108 to data frame
temp_tab <- airquality %>%
  dplyr::filter(component == "TEMP" & meantype == "HMW" & station == "S108") 

# half-hourly relative humidity measurement of station S108 to data frame
humidity_tab <- airquality %>%
  dplyr::filter(component == "RF" & meantype == "HMW" & station == "S108") 

# join humidity and temperature tables by common field 'time'
temp_tab %>%
  dplyr::inner_join(
    # right table
    humidity_tab,
    # columns to match
    by = c("time" = "time")
  ) %>%
  
  dplyr::select(time, value.x, value.y) %>% # select relevant columns from joined table
  
  # create plot  
  ggplot2::ggplot(.,    
                  aes(            
                    x = value.x,      
                    y = value.y
                  )
  ) +
  ggplot2::xlab("air temperature [°C]") +
  ggplot2::ylab("relative humidity [%]") +
  ggplot2::geom_point(color="blue")  +                                      # define geometry scatterplot, with point color blue
  ggplot2::geom_smooth(method=lm , color="red", fill="#69b3a2", se=TRUE) +  # with linear trend and confidence interval
  ggplot2::theme_minimal() 

