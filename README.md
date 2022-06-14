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

![image](https://user-images.githubusercontent.com/38343820/173678630-01e053cb-259c-417a-b4ae-4e742674befe.png)

## Visualization 2

Using leaflet, to produce a basic map with very less interaction. Here in this map, we can zoom in order to see any distillery’s location clearly with the help of markers.

```
whiskey_db<-cbind(whisky.map,whiskey$Body,whiskey$Sweetness,whiskey$Smoky,whiskey$Medicinal,whiskey$Tobacco,whiskey$Honey,whiskey$Spicy,whiskey$Winey,whiskey$Nutty,whiskey$Malty,whiskey$Fruity,whiskey$Floral,whiskey$Postcode)
```
```
library(leaflet)
library(dplyr)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat)
map
```
![image](https://user-images.githubusercontent.com/38343820/173679496-fc43d7cf-e17b-448b-b1a0-d8414e49f0fd.png)
***To see th real maps, please open the html file or run the given R code***

## Visualization 3

Here in this map, we can zoom in order to see any distillery’s location clearly through the marker but also know the distilleries information by clicking on the specific marker of any distillery. Thus, the map’s effectiveness is increased by increasing the interaction of the map with its audience. The image below show the interaction level of the map under visualization 3
```
library(leaflet)
library(dplyr)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,popup=paste("Distillery name:",whiskey_db$Distiller,"<br>","Body:",whiskey$Body,"<br>","Sweetness:",whiskey$Sweetness,"<br>","Smoky:",whiskey$Smoky,"<br>","Medicinal:",whiskey$Medicinal,"<br>","Tobacco:",whiskey$Tobacco,"<br>","Honey:",whiskey$Honey,"<br>","Spicy:",whiskey$Spicy,"<br>","Winey:",whiskey$Winey,"<br>","Nutty:",whiskey$Nutty,"<br>","Malty:",whiskey$Malty,"<br>","Fruity:",whiskey$Fruity,"<br>","Floral:",whiskey$Floral,"<br>","Postcode:",whiskey$Postcode,"<br>","Lattitude:",whiskey$Latitude,"<br>","Longitude:",whiskey$Longitude))
map
```

![image](https://user-images.githubusercontent.com/38343820/173679926-6a8e0ca3-75cc-4daf-89d8-51ab175cf851.png)

## Visualization 4

Here in this map, we can zoom in order to see any distillery’s location clearly through the marker but also know the distilleries information by clicking on the specific marker of any distillery. Here, the map’s effectiveness is increased by adding customized markers that connects the map with audience with its presentation as to showcasing exactly what the map represents ( Location of distilleries). The image below show the interaction level of the map under visualization 4

```
library(leaflet)
library(dplyr)
newicon<-makeIcon(iconUrl="https://th.bing.com/th/id/R.ea3d8777c865475529457f6bdae5cdad?rik=Gdii5m0%2b54%2fUpw&riu=http%3a%2f%2fpngimg.com%2fuploads%2fwhisky%2fwhisky_PNG62.png&ehk=fO165RiE%2f61zY9bzAjVu1nQ1t%2b18iLob4YToocqd2LQ%3d&risl=&pid=ImgRaw&r=0",iconWidth=35,iconHeight=75)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,icon=newicon,popup=paste("Distillery name:",whiskey_db$Distiller,"<br>","Body:",whiskey$Body,"<br>","Sweetness:",whiskey$Sweetness,"<br>","Smoky:",whiskey$Smoky,"<br>","Medicinal:",whiskey$Medicinal,"<br>","Tobacco:",whiskey$Tobacco,"<br>","Honey:",whiskey$Honey,"<br>","Spicy:",whiskey$Spicy,"<br>","Winey:",whiskey$Winey,"<br>","Nutty:",whiskey$Nutty,"<br>","Malty:",whiskey$Malty,"<br>","Fruity:",whiskey$Fruity,"<br>","Floral:",whiskey$Floral,"<br>","Postcode:",whiskey$Postcode,"<br>","Lattitude:",whiskey$Latitude,"<br>","Longitude:",whiskey$Longitude))
map
```
![image](https://user-images.githubusercontent.com/38343820/173680221-4c04ca27-d357-44d9-bc5e-4ea4affbfcc7.png)

## Visualization 5
Here in this map, we can zoom in order to see any distillery’s location clearly through the marker but also know the distilleries information by clicking on the specific marker of any distillery. Here, the map’s effectiveness is increased by adding customized markers that connects the map with audience with its presentation as to showcasing exactly what the map represents ( Location of distilleries) but also the marker has been changed in this one because of the mess that marker was making. Also, this visualization has been made better by ***adding setView*** so that the view should look not messier and also pleasing to the eyes. The image below show the interaction level of the map under visualization 5

```
library(leaflet)
library(dplyr)
newicon<-makeIcon(iconUrl="https://cdn0.iconfinder.com/data/icons/alcoholic/120/bourbon1-512.png",iconWidth=50,iconHeight=65)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,icon=newicon,popup=paste("Distillery name:",whiskey_db$Distiller,"<br>","Body:",whiskey$Body,"<br>","Sweetness:",whiskey$Sweetness,"<br>","Smoky:",whiskey$Smoky,"<br>","Medicinal:",whiskey$Medicinal,"<br>","Tobacco:",whiskey$Tobacco,"<br>","Honey:",whiskey$Honey,"<br>","Spicy:",whiskey$Spicy,"<br>","Winey:",whiskey$Winey,"<br>","Nutty:",whiskey$Nutty,"<br>","Malty:",whiskey$Malty,"<br>","Fruity:",whiskey$Fruity,"<br>","Floral:",whiskey$Floral,"<br>","Postcode:",whiskey$Postcode,"<br>","Lattitude:",whiskey$Latitude,"<br>","Longitude:",whiskey$Longitude))
setView(map,lng=-2.4333,lat=53.5500,zoom=9)
```
![image](https://user-images.githubusercontent.com/38343820/173680726-e65c2f6c-44ed-42a2-a09b-2e5bbdaecbc2.png)

## Visualization 6
Here in this map, we can zoom in order to see any distillery’s location clearly through the marker but also know the distilleries information by clicking on the specific marker of any distillery. Here, the map’s effectiveness is increased by adding by ***adding setView*** and also ***a MINI MAP*** which hepls us to easily find where are we currently, at what location of the country are we at. It increases the interaction of the map and makes the interaction for the audience easier.Thus, the view should look not messier and also can be interacted effectively through the Mini map.

```
library(leaflet)
library(dplyr)
newicon<-makeIcon(iconUrl="https://cdn0.iconfinder.com/data/icons/alcoholic/120/bourbon1-512.png",iconWidth=50,iconHeight=65)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,icon=newicon,popup=paste("Distillery name:",whiskey_db$Distiller,"<br>","Body:",whiskey$Body,"<br>","Sweetness:",whiskey$Sweetness,"<br>","Smoky:",whiskey$Smoky,"<br>","Medicinal:",whiskey$Medicinal,"<br>","Tobacco:",whiskey$Tobacco,"<br>","Honey:",whiskey$Honey,"<br>","Spicy:",whiskey$Spicy,"<br>","Winey:",whiskey$Winey,"<br>","Nutty:",whiskey$Nutty,"<br>","Malty:",whiskey$Malty,"<br>","Fruity:",whiskey$Fruity,"<br>","Floral:",whiskey$Floral,"<br>","Postcode:",whiskey$Postcode,"<br>","Lattitude:",whiskey$Latitude,"<br>","Longitude:",whiskey$Longitude))%>%addMiniMap()
setView(map,lng=-2.4333,lat=53.5500,zoom=9)
```
![image](https://user-images.githubusercontent.com/38343820/173681059-dbc19d83-bd89-4012-9025-bb4b3da4a1d3.png)

## Visualization 7

Here in this map, in order to avoid the mess in the graph, we have added clusters of distilleries using the ***cluster option*** which are near to each other.The clusters are interctive and when are pressed, the show indivisual distillery which carries their indivisual information. Here, the map’s effectiveness is increased by adding by ***interactive clusters*** makes the map less messier and as they are interactive too, the audience can easily open them up for more information. It aslo helps us to understand which distilleries are in the vicinity of each other. ***THE CLUSTERS CAN BE EXPANDED BY CLICKING ON THEM.***

```
library(leaflet)
library(dplyr)
newicon<-makeIcon(iconUrl="https://cdn0.iconfinder.com/data/icons/alcoholic/120/bourbon1-512.png",iconWidth=50,iconHeight=65)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,icon=newicon,clusterOptions = markerClusterOptions(),popup=paste("Distillery name:",whiskey_db$Distiller,"<br>","Body:",whiskey$Body,"<br>","Sweetness:",whiskey$Sweetness,"<br>","Smoky:",whiskey$Smoky,"<br>","Medicinal:",whiskey$Medicinal,"<br>","Tobacco:",whiskey$Tobacco,"<br>","Honey:",whiskey$Honey,"<br>","Spicy:",whiskey$Spicy,"<br>","Winey:",whiskey$Winey,"<br>","Nutty:",whiskey$Nutty,"<br>","Malty:",whiskey$Malty,"<br>","Fruity:",whiskey$Fruity,"<br>","Floral:",whiskey$Floral,"<br>","Postcode:",whiskey$Postcode,"<br>","Lattitude:",whiskey$Latitude,"<br>","Longitude:",whiskey$Longitude))%>%addMiniMap()
setView(map,lng=-2.4333,lat=53.5500,zoom=9)
```
![image](https://user-images.githubusercontent.com/38343820/173681563-18938768-4a32-49fe-906e-f9bd25dcef9d.png)
![image](https://user-images.githubusercontent.com/38343820/173681716-c31988d0-abf8-452b-b403-5570b643f108.png)
![image](https://user-images.githubusercontent.com/38343820/173681776-77f5c533-67e6-4697-9a86-8fa961c355b5.png)
![image](https://user-images.githubusercontent.com/38343820/173681863-59019291-62f6-43be-bb72-5c77d6210f4d.png)

## Visualization 9
***Here in this map, we have added the title to the graph and also added a control layer to the graph.*** The image below shows the real output of the code though the html avoids showcasing the title of the map.

```library(leaflet)
library(dplyr)
library(htmlwidgets)
 library(htmltools)
tag.map.title <- tags$style(HTML("
  .leaflet-control.map-title {
    transform: translate(-50%,5%);
    position: fixed !important;
    left: 50%;
    text-align: center;
    color: black;
    background:white;
    font-weight: bold;
    font-size: 15px;
  }
"))
title <- tags$div(
  tag.map.title, HTML("Whiskey Distillery Mapping:Based On Location")
)
newicon<-makeIcon(iconUrl="https://cdn0.iconfinder.com/data/icons/alcoholic/120/bourbon1-512.png",iconWidth=50,iconHeight=65)
map<-leaflet()%>%
  addTiles(group = "Based on Location")%>%
  addControl(title, position = "topleft", className="map-title")%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,icon=newicon,clusterOptions = markerClusterOptions(),popup=paste("<h3>Info Table</h3>","<b>Distillery name:</b>",whiskey_db$Distiller,"<br>","<b>Body:</b>",whiskey$Body,"<br>","<b>Sweetness:</b>",whiskey$Sweetness,"<br>","<b>Smoky:</b>",whiskey$Smoky,"<br>","<b>Medicinal:</b>",whiskey$Medicinal,"<br>","<b>Tobacco:</b>",whiskey$Tobacco,"<br>","<b>Honey:</b>",whiskey$Honey,"<br>","<b>Spicy:</b>",whiskey$Spicy,"<br>","<b>Winey:</b>",whiskey$Winey,"<br>","<b>Nutty:</b>",whiskey$Nutty,"<br>","<b>Malty:</b>",whiskey$Malty,"<br>","<b>Fruity:</b>",whiskey$Fruity,"<br>","<b>Floral:</b>",whiskey$Floral,"<br>","<b>Postcode:</b>",whiskey$Postcode,"<br>","<b>Lattitude:</b>",whiskey$Latitude,"<br>","<b>Longitude:</b>",whiskey$Longitude))%>%addMiniMap()%>%
  addLayersControl(baseGroups = c("Based on Location"))
setView(map,lng=-2.4333,lat=53.5500,zoom=9)
```
![image](https://user-images.githubusercontent.com/38343820/173682202-609f9ba5-b6a8-4bc6-be25-0ba1a77a0d4e.png)

# Visualization 10

***Here in this map, we have markers factored on the bases of body and also the icons for the markers are customized. After clustering, the markers carry indisual colours evident through the legend added in the map and these markers are factored on the basis of body of the distillery.*** The image below shows the real output of the code though the html avoids showcasing the title of the map.

```
library(leaflet)
library(dplyr)
library(htmlwidgets)
 library(htmltools)
library(raster)
```
```
tag.map.title <- tags$style(HTML("
  .leaflet-control.map-title {
    transform: translate(-50%,5%);
    position: fixed !important;
    left: 50%;
    text-align: center;
    color: black;
    background:white;
    font-weight: bold;
    font-size: 15px;
  }
"))
title <- tags$div(
  tag.map.title, HTML("Whiskey Distillery Mapping:Based On Body")
)
whiskey_db$`whiskey$Body` <- factor(whiskey_db$`whiskey$Body`)
new <- c("red", "green","blue","orange","yellow")[whiskey_db$`whiskey$Body`]

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = new
)
unique_markers_map <- leaflet(whiskey_db$`whiskey$Body`)%>%
  addTiles(group = "Based on Body")%>%
  addControl(title, position = "topleft", className="map-title")%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addAwesomeMarkers(lng=UK.map$long,lat=UK.map$lat,icon=icons,clusterOptions = markerClusterOptions(),popup=paste("<h3>Info Table</h3>","<b>Distillery name:</b>",whiskey_db$Distiller,"<br>","<b>Body:</b>",whiskey$Body,"<br>","<b>Sweetness:</b>",whiskey$Sweetness,"<br>","<b>Smoky:</b>",whiskey$Smoky,"<br>","<b>Medicinal:</b>",whiskey$Medicinal,"<br>","<b>Tobacco:</b>",whiskey$Tobacco,"<br>","<b>Honey:</b>",whiskey$Honey,"<br>","<b>Spicy:</b>",whiskey$Spicy,"<br>","<b>Winey:</b>",whiskey$Winey,"<br>","<b>Nutty:</b>",whiskey$Nutty,"<br>","<b>Malty:</b>",whiskey$Malty,"<br>","<b>Fruity:</b>",whiskey$Fruity,"<br>","<b>Floral:</b>",whiskey$Floral,"<br>","<b>Postcode:</b>",whiskey$Postcode,"<br>","<b>Lattitude:</b>",whiskey$Latitude,"<br>","<b>Longitude:</b>",whiskey$Longitude))%>%addMiniMap()%>%addLegend(color="yellow",labels="Body 1")%>%addLegend(color="green",labels="Body 1")%>%addLegend(color="blue",labels="Body 2")%>%addLegend(color="orange",labels="Body 3")%>%addLegend(color="red",labels="Body 4")%>%
  addLayersControl(baseGroups = c("Based on Body"))
setView(unique_markers_map,lng=-2.4333,lat=53.5500,zoom=9)
```
![image](https://user-images.githubusercontent.com/38343820/173682580-bf7bfcc4-838a-4631-a5f4-c2192d283bec.png)

## Visualization 11

***Here in this map, we have markers factored on the bases of spicy feature and also the icons for the markers are customized. After clustering, the markers carry indisual colours evident through the legend added in the map and these markers are factored on the basis of spicy feature of the distillery.***
```
library(leaflet)
library(dplyr)
library(htmlwidgets)
 library(htmltools)
library(raster)
tag.map.title <- tags$style(HTML("
  .leaflet-control.map-title {
    transform: translate(-50%,5%);
    position: fixed !important;
    left: 50%;
    text-align: center;
    color: black;
    background:white;
    font-weight: bold;
    font-size: 15px;
  }
"))
title <- tags$div(
  tag.map.title, HTML("Whiskey Distillery Mapping:Based On Spicy")
)
whiskey_db$`whiskey$Spicy` <- factor(whiskey_db$`whiskey$Spicy`)
new <- c("red", "green","blue","orange","yellow")[whiskey_db$`whiskey$Spicy`]

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = new
)
unique_markers_map <- leaflet(whiskey_db$`whiskey$Spicy`)%>%
  addTiles(group = "Based on Spicy")%>%
  addControl(title, position = "topleft", className="map-title")%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addAwesomeMarkers(lng=UK.map$long,lat=UK.map$lat,icon=icons,clusterOptions = markerClusterOptions(),popup=paste("<h3>Info Table</h3>","<b>Distillery name:</b>",whiskey_db$Distiller,"<br>","<b>Body:</b>",whiskey$Body,"<br>","<b>Sweetness:</b>",whiskey$Sweetness,"<br>","<b>Smoky:</b>",whiskey$Smoky,"<br>","<b>Medicinal:</b>",whiskey$Medicinal,"<br>","<b>Tobacco:</b>",whiskey$Tobacco,"<br>","<b>Honey:</b>",whiskey$Honey,"<br>","<b>Spicy:</b>",whiskey$Spicy,"<br>","<b>Winey:</b>",whiskey$Winey,"<br>","<b>Nutty:</b>",whiskey$Nutty,"<br>","<b>Malty:</b>",whiskey$Malty,"<br>","<b>Fruity:</b>",whiskey$Fruity,"<br>","<b>Floral:</b>",whiskey$Floral,"<br>","<b>Postcode:</b>",whiskey$Postcode,"<br>","<b>Lattitude:</b>",whiskey$Latitude,"<br>","<b>Longitude:</b>",whiskey$Longitude))%>%addMiniMap()%>%addLegend(color="yellow",labels="Spicy 1")%>%addLegend(color="green",labels="Spicy 1")%>%addLegend(color="blue",labels="Spicy 2")%>%addLegend(color="orange",labels="Spicy 3")%>%addLegend(color="#ff0000",labels="Spicy 4")%>%
  addLayersControl(baseGroups = c("Based on Spicy"))
setView(unique_markers_map,lng=-2.4333,lat=53.5500,zoom=9)
```
## Visualization 12

***Here in this map, we have markers factored on the bases of sweetness feature and also the icons for the markers are customized. After clustering, the markers carry indisual colours evident through the legend added in the map and these markers are factored on the basis of sweetness feature of the distillery.***

```library(leaflet)
library(dplyr)
library(htmlwidgets)
 library(htmltools)
library(raster)
tag.map.title <- tags$style(HTML("
  .leaflet-control.map-title {
    transform: translate(-50%,5%);
    position: fixed !important;
    left: 50%;
    text-align: center;
    color: black;
    background:white;
    font-weight: bold;
    font-size: 15px;
  }
"))
title <- tags$div(
  tag.map.title, HTML("Whiskey Distillery Mapping:Based On Sweetness")
)
whiskey_db$`whiskey$Sweetness` <- factor(whiskey_db$`whiskey$Sweetness`)
new <- c("red", "green","blue","orange","yellow")[whiskey_db$`whiskey$Sweetness`]

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = new
)
unique_markers_map <- leaflet(whiskey_db$`whiskey$Sweetness`)%>%
  addTiles(group = "Based on Sweetness")%>%
  addControl(title, position = "topleft", className="map-title")%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addAwesomeMarkers(lng=UK.map$long,lat=UK.map$lat,icon=icons,clusterOptions = markerClusterOptions(),popup=paste("<h3>Info Table</h3>","<b>Distillery name:</b>",whiskey_db$Distiller,"<br>","<b>Body:</b>",whiskey$Body,"<br>","<b>Sweetness:</b>",whiskey$Sweetness,"<br>","<b>Smoky:</b>",whiskey$Smoky,"<br>","<b>Medicinal:</b>",whiskey$Medicinal,"<br>","<b>Tobacco:</b>",whiskey$Tobacco,"<br>","<b>Honey:</b>",whiskey$Honey,"<br>","<b>Spicy:</b>",whiskey$Spicy,"<br>","<b>Winey:</b>",whiskey$Winey,"<br>","<b>Nutty:</b>",whiskey$Nutty,"<br>","<b>Malty:</b>",whiskey$Malty,"<br>","<b>Fruity:</b>",whiskey$Fruity,"<br>","<b>Floral:</b>",whiskey$Floral,"<br>","<b>Postcode:</b>",whiskey$Postcode,"<br>","<b>Lattitude:</b>",whiskey$Latitude,"<br>","<b>Longitude:</b>",whiskey$Longitude))%>%addMiniMap()%>%addLegend(color="yellow",labels="Sweetness 1")%>%addLegend(color="green",labels="Sweetness 1")%>%addLegend(color="blue",labels="Sweetness 2")%>%addLegend(color="orange",labels="Sweetness 3")%>%addLegend(color="red",labels="Sweetness 4")%>%
  addLayersControl(baseGroups = c("Based on Sweetness"))
setView(unique_markers_map,lng=-2.4333,lat=53.5500,zoom=9)
```
![image](https://user-images.githubusercontent.com/38343820/173683086-84120131-ab7c-4222-8bf4-0db62617e2e6.png)

***Rest all the other features, could be produced the same way.***

## Analysis done:

1) Based on location:

The intended visualization was much effective as apart from just knowing the location, we inteded to increase the interactivity of the map by adding waterfall plot that could help compare nearby distilleries by clicking on the clustered markers but it could be only achieved through shiny. For, the current visualization, from a user’s perspective, it was crucial to know where the distilleries were located and the best way that could be achieved was through a map. The map also shows the distilleries information which would be very useful when once know the location of the distillery.

2) Based on all features.

Features of the distilleries could be compared with shiny by creating an onclick event thrugh shiny and producing a bubble chart or radar plot but here, in this visualization, we have focused on based on features, if a user wants to know the place of the distillery, could know it through a map. The coloured markers are associated with the fetaure type and offcouse the markers contain other information as well.

## Limitation:

The analysis could have more grapghs like radar plot, waterfall plot and bubble graph to draw comparisons between the distilleries in the vicinity but it could require to use shiny along with leaflet as alone leaflet does not have on click feature. Thus, restricted us to the work produced.

## Scope:

1) Use shiny to add onclick graphs and then this visualization could be a lot better.
2) Shiny could also be used for making better looking dashboards.

## Critiquing the map produced.
The map contains a proper view set through SetView that produces the desired zoomed view, the provider is selected keeping in mind proper display of the map. To avoid clustering clusterOption is used. LayerControl and Mini Maps also added for the right reason. Interactivity through a map is produced to the maximum limit but the map does not have the desired legend table. The legends produced are not at all effective.
