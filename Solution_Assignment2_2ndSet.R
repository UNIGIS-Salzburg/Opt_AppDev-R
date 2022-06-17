library(tidyverse)
library(nycflights13)
library(knitr)

airlines_from_nyc <- nycflights13::airlines
flights_from_nyc <- nycflights13::flights

# left join
dplyr::left_join(
  # left table
  flights_from_nyc, 
  # right table
  airlines_from_nyc,
  # columns to match
  by = c("carrier" = "carrier")
) %>%
  dplyr::filter(day==1 & month==1) %>%
  dplyr::select(name, origin, dest) %>%
  knitr::kable()


dplyr::arrange(-air_time)

  dplyr::slice_head(n = 20) %>%
  dplyr::select(year, month, day, carrier, name, origin, dest) %>%
  knitr::kable()
