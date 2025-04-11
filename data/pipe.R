library(tidyverse)
library(nycflights13)


#intermediate variables

sel_column <- dplyr::select(nycflights13::flights, dep_time, origin)
sel_row <- dplyr::filter(sel_column, dep_time <= 600)
flights_per_origin <- count(sel_row, origin)


#nested

dplyr::filter(dplyr::select(nycflights13::flights, dep_time, origin), dep_time <= 600)


#pipe operators
new_var <- nycflights13::flights %>%
  dplyr::select(dep_time, origin) %>%
  dplyr::filter(dep_time <= 600) %>%
  dplyr::count(origin)


#base R pipe operator |>
nycflights13::flights |>
  dplyr::select(dep_time, origin) |>
  dplyr::filter(dep_time <= 600) |>
  dplyr::count(origin)


#placeholders . and _
nycflights13::flights %>%
  dplyr::filter(., month == 1)


10 |>
  sqrt(x = _)


#pipe operators together with operators like $, [[ or [
nycflights13::flights %>%
  {print(.$origin)}


#pass value to multiple arguments
nycflights13::flights %>%
  dplyr::filter(month == 1) %>%
  {plot(.$distance, .$air_time)}


