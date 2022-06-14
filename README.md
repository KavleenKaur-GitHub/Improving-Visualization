# Improving-Visualization

The project focuses on mapping the whiskey distillery dataset to our best of abilities. This project helps us to find few answers based on visualization. Visualization of any dataset helps us understand the dataset better and also help us answer some of he questions better. Thus, this dataset is also visualized in order to fully understand the dataset.
But due to many reasons, this visualizatin is limited. We will also discuss the limitation of this visualization and also critique the visualization to best of our capabilities and thus this project will involve all the aspects of visualization.

## The goal of this project is to step by step improve the visualization.

# Loading the required libraries.
```
library(sp)
library(sf)
library(rgdal)
library(classInt) 
library(RColorBrewer) # not a strictly a spatial ligrary
library(viridis) #my current "go to" color scales
library(ggmap)
## Loading required package: ggplot2
library(leaflet)
library(tmap)
library(knitr) # to create nice documents in R
library(tidyverse) # loads ggplot2, dplyr,tidyr,readr,purr,tibble
library(broom)  # because I find it useful
library(forcats) # working with categorical variables
```
# Loading the dataset and forming the dataframes.

```
whiskey <- read_csv("Real whiskey dataset.csv")
whiskey$Longitude <- as.numeric(whiskey$Longitude)
whiskey$Latitude <- as.numeric(whiskey$Latitude)
str(whiskey)
```

# Data needed for the visualization.
```
library(maps)
```
```
world.map <- map_data ("world")
glimpse(world.map)
```
# Map Vizualization.
This is the initial visualization that does not include any interaction.

```
UK.map <- world.map %>% filter(region == "UK")
whiskies.coord <- data.frame(whiskey$Latitude, whiskey$Longitude)
coordinates(whiskies.coord) <- ~whiskey.Latitude + whiskey.Longitude
proj4string(whiskies.coord) <- CRS("+init=epsg:27700")
```
```
whiskies.coord <- spTransform(whiskies.coord, CRS("+init=epsg:4326"))
whisky.map <- data.frame(Distillery = whiskey$Distillery,
lat = whiskies.coord$whiskey.Latitude,
long = whiskies.coord$whiskey.Longitude)
UK.map %>%
  filter(subregion == "Scotland") %>% ggplot() + 
  geom_map(map = UK.map,aes(x = long, y = lat, map_id = region),fill="White", colour = "Black")+ coord_map() + geom_point(data = whisky.map,aes(x=lat, y = long, colour = "red", alpha = 0.9))
  ```
