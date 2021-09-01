#Required skills: 1) read csv data, 2) pipe operator %>%, 3) data wrangling: dplyr filter select group_by, mutate and summarise 
# 4) joins: dplyr inner_join, join multiple tables with pipe operator, 5) rename columns in df (ok), 6) print all rows of df

# total pandemic excess mortality, data: https://www.mortality.org/, select 10 countries, create map

# besser lesbarer code mit dplyer pipe syntax: https://statistik-dresden.de/archives/15679

library(tidyverse)

# Read data from comma-separated csv
access_mortality_data <- read.csv("C:/Users/b1045498/Downloads/stmf_v01.csv", header = TRUE, sep = ";")

# Select specific columns, 'CountryCode', 'Year', 'DTotal' and rows of 10 countries, Important: select sex = both
access_mortality_data_SelectedCountries <- access_mortality_data %>% dplyr::filter(Sex == "b") %>% dplyr::select(CountryCode, Year, DTotal) %>% dplyr::filter(CountryCode == "AUT" 
| CountryCode == "CZE" | CountryCode == "CZE" | CountryCode == "SWE" | CountryCode == "POL" | CountryCode == "SVN" | CountryCode == "SVK" | CountryCode == "BEL"
| CountryCode == "ITA" | CountryCode == "FIN") 

# exclude year 2021, group by country and year, sum groups 
sum_d_ctry_yr <- access_mortality_data_SelectedCountries %>% dplyr::filter(!Year == 2021) %>% dplyr::group_by(CountryCode, Year) %>% dplyr::summarise(sum(DTotal))

# standard deviation per country (5 years: 2015-2020)
std_ctry <- sum_d_ctry_yr %>% dplyr::filter(Year > 2015) %>% dplyr::group_by(CountryCode) %>% dplyr::summarise(sd(`sum(DTotal)`))

# mean per country (5 years: 2015-2020)
mean_ctry <- sum_d_ctry_yr %>% dplyr::filter(Year > 2015) %>% dplyr::group_by(CountryCode) %>% dplyr::summarise(mean(`sum(DTotal)`))

# total death 2020 per country
total2020_ctry <- sum_d_ctry_yr %>% dplyr::filter(Year == 2020)

# join tables standard deviation, mean and total death 2020
final_tab <- dplyr::inner_join(std_ctry, mean_ctry, by = c("CountryCode" = "CountryCode")) %>% dplyr::inner_join(total2020_ctry, by = c("CountryCode" = "CountryCode"))

# give table columns meaningful names
names(final_tab)[1] = "country"
names(final_tab)[2] = "std"
names(final_tab)[3] = "mean"
names(final_tab)[5] = "d2020"

# calculate z score
z_score <- final_tab %>% dplyr::mutate(z = (d2020 - mean) / std)

# visualize in a map, Desktop GIS or use R (Geocomputation with R: https://geocompr.robinlovelace.net/adv-map.html, R Graph Gallery: https://www.r-graph-gallery.com/choropleth-map.html)

print(final_tab,n=nrow(final_tab))
print(z_score,n=nrow(z_score))

