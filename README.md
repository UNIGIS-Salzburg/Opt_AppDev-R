# UNIGIS Salzburg: Application Development - Scripting with R

These learning materials are designed for the UNIGIS distance-learning study programs as part of a module that introduces into Application Development. 

The contents of this module are based on [granolarr](https://sdesabbata.github.io/granolarr/), a *geogGRaphic dAta scieNce, reprOducibLe teAching resouRce in R* by Stefano De Sabbata, University of Leicester. 

In this module, the granolarr materials will be adapted and extended to fit the UNIGIS curriculum and layout of materials. Like the source materials, this work is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html).


ToDos:

* add long and wide table conversion (see spread and gather: https://datascienceplus.com/converting-data-from-long-to-wide-and-from-wide-to-long-simplified-tidyverse-package/)

Updates for 6 ECTS Module:

* new lesson 4 'Spatial Data Structures': intro sf, sfc, raster objects (watch out: terra replaces the raster package), stars package with spatiotemporal arrays and coordinate reference systems in R, convert from data frame / tibble to sf with st_as_sf, get crs with st_crs, assign crs with st_set_crs, project with st_transform etc. (see https://thinking-spatial.org/courses/angewandte_geodatenverarbeitung/kurs03/#coordinate-reference-systems-crs)   
* new lesson 7 'spatial data wrangling', filter sf objects and raster by condition, spatial joins, simple geometric operations like intersect and buffer (use terra or sfdep packages)
* new outlook lesson 'chatgpt and R'. similar to:
Part 1: https://www.youtube.com/watch?v=QDf-zc81NSE&t=6s
Part 2: https://www.youtube.com/watch?v=gn1BrRUBr74
* add two additional assignments

## Interesting API-Call's (if the OpenWeather API has some issues in the near future.)

https://api.nasa.gov/ #free to use - API-keys, that need different parameters.
for example: https://epic.gsfc.nasa.gov/about/api

## Used Packages in Module:
[provided by: https://github.com/UNIGIS-Salzburg/Opt_AppDev-R/blob/developer/packagechecker.R ]
```
ggplot2
ggspatial
httr
jsonlite
knitr
leaflet
nycflights13
sf
stringr
tidyverse
```
