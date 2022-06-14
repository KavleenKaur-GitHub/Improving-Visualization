library(sp)
library(sf)
library(rgdal)
library(classInt) 
library(RColorBrewer) # not a strictly a spatial ligrary
library(viridis) #my current "go to" color scales
library(ggmap)
library(leaflet)
library(tmap)
library(GISTools)
library(knitr) # to create nice documents in R
library(tidyverse) # loads ggplot2, dplyr,tidyr,readr,purr,tibble
library(broom)  # because I find it useful
library(forcats) # working with categorical variables
whiskey <- read_csv("Real whiskey dataset.csv")
whiskey$Longitude <- as.numeric(whiskey$Longitude)
whiskey$Latitude <- as.numeric(whiskey$Latitude)
str(whiskey)
library(maps)
world.map <- map_data ("world")
glimpse(world.map)
UK.map <- world.map %>% filter(region == "UK")
whiskies.coord <- data.frame(whiskey$Latitude, whiskey$Longitude)
coordinates(whiskies.coord) <- ~whiskey.Latitude + whiskey.Longitude
proj4string(whiskies.coord) <- CRS("+init=epsg:27700")
whiskies.coord <- spTransform(whiskies.coord, CRS("+init=epsg:4326"))
whisky.map <- data.frame(Distillery = whiskey$Distillery,
                         lat = whiskies.coord$whiskey.Latitude,
                         long = whiskies.coord$whiskey.Longitude)
UK.map %>%
  filter(subregion == "Scotland") %>% ggplot() + 
  geom_map(map = UK.map,aes(x = long, y = lat, map_id = region),fill="White", colour = "Black")+ coord_map() + geom_point(data = whisky.map,aes(x=lat, y = long, colour = "red", alpha = 0.9))
whiskey_db<-cbind(whisky.map,whiskey$Body,whiskey$Sweetness,whiskey$Smoky,whiskey$Medicinal,whiskey$Tobacco,whiskey$Honey,whiskey$Spicy,whiskey$Winey,whiskey$Nutty,whiskey$Malty,whiskey$Fruity,whiskey$Floral,whiskey$Postcode)
library(leaflet)
library(dplyr)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat)
map
library(leaflet)
library(dplyr)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,popup=paste("Distillery name:",whiskey_db$Distiller,"<br>","Body:",whiskey$Body,"<br>","Sweetness:",whiskey$Sweetness,"<br>","Smoky:",whiskey$Smoky,"<br>","Medicinal:",whiskey$Medicinal,"<br>","Tobacco:",whiskey$Tobacco,"<br>","Honey:",whiskey$Honey,"<br>","Spicy:",whiskey$Spicy,"<br>","Winey:",whiskey$Winey,"<br>","Nutty:",whiskey$Nutty,"<br>","Malty:",whiskey$Malty,"<br>","Fruity:",whiskey$Fruity,"<br>","Floral:",whiskey$Floral,"<br>","Postcode:",whiskey$Postcode,"<br>","Lattitude:",whiskey$Latitude,"<br>","Longitude:",whiskey$Longitude))
map
library(leaflet)
library(dplyr)
newicon<-makeIcon(iconUrl="https://th.bing.com/th/id/R.ea3d8777c865475529457f6bdae5cdad?rik=Gdii5m0%2b54%2fUpw&riu=http%3a%2f%2fpngimg.com%2fuploads%2fwhisky%2fwhisky_PNG62.png&ehk=fO165RiE%2f61zY9bzAjVu1nQ1t%2b18iLob4YToocqd2LQ%3d&risl=&pid=ImgRaw&r=0",iconWidth=35,iconHeight=75)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,icon=newicon,popup=paste("Distillery name:",whiskey_db$Distiller,"<br>","Body:",whiskey$Body,"<br>","Sweetness:",whiskey$Sweetness,"<br>","Smoky:",whiskey$Smoky,"<br>","Medicinal:",whiskey$Medicinal,"<br>","Tobacco:",whiskey$Tobacco,"<br>","Honey:",whiskey$Honey,"<br>","Spicy:",whiskey$Spicy,"<br>","Winey:",whiskey$Winey,"<br>","Nutty:",whiskey$Nutty,"<br>","Malty:",whiskey$Malty,"<br>","Fruity:",whiskey$Fruity,"<br>","Floral:",whiskey$Floral,"<br>","Postcode:",whiskey$Postcode,"<br>","Lattitude:",whiskey$Latitude,"<br>","Longitude:",whiskey$Longitude))
map
library(leaflet)
library(dplyr)
newicon<-makeIcon(iconUrl="https://cdn0.iconfinder.com/data/icons/alcoholic/120/bourbon1-512.png",iconWidth=50,iconHeight=65)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,icon=newicon,popup=paste("Distillery name:",whiskey_db$Distiller,"<br>","Body:",whiskey$Body,"<br>","Sweetness:",whiskey$Sweetness,"<br>","Smoky:",whiskey$Smoky,"<br>","Medicinal:",whiskey$Medicinal,"<br>","Tobacco:",whiskey$Tobacco,"<br>","Honey:",whiskey$Honey,"<br>","Spicy:",whiskey$Spicy,"<br>","Winey:",whiskey$Winey,"<br>","Nutty:",whiskey$Nutty,"<br>","Malty:",whiskey$Malty,"<br>","Fruity:",whiskey$Fruity,"<br>","Floral:",whiskey$Floral,"<br>","Postcode:",whiskey$Postcode,"<br>","Lattitude:",whiskey$Latitude,"<br>","Longitude:",whiskey$Longitude))
setView(map,lng=-2.4333,lat=53.5500,zoom=9)
library(leaflet)
library(dplyr)
newicon<-makeIcon(iconUrl="https://cdn0.iconfinder.com/data/icons/alcoholic/120/bourbon1-512.png",iconWidth=50,iconHeight=65)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,icon=newicon,popup=paste("Distillery name:",whiskey_db$Distiller,"<br>","Body:",whiskey$Body,"<br>","Sweetness:",whiskey$Sweetness,"<br>","Smoky:",whiskey$Smoky,"<br>","Medicinal:",whiskey$Medicinal,"<br>","Tobacco:",whiskey$Tobacco,"<br>","Honey:",whiskey$Honey,"<br>","Spicy:",whiskey$Spicy,"<br>","Winey:",whiskey$Winey,"<br>","Nutty:",whiskey$Nutty,"<br>","Malty:",whiskey$Malty,"<br>","Fruity:",whiskey$Fruity,"<br>","Floral:",whiskey$Floral,"<br>","Postcode:",whiskey$Postcode,"<br>","Lattitude:",whiskey$Latitude,"<br>","Longitude:",whiskey$Longitude))%>%addMiniMap()
setView(map,lng=-2.4333,lat=53.5500,zoom=9)
library(leaflet)
library(dplyr)
newicon<-makeIcon(iconUrl="https://cdn0.iconfinder.com/data/icons/alcoholic/120/bourbon1-512.png",iconWidth=50,iconHeight=65)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,icon=newicon,clusterOptions = markerClusterOptions(),popup=paste("Distillery name:",whiskey_db$Distiller,"<br>","Body:",whiskey$Body,"<br>","Sweetness:",whiskey$Sweetness,"<br>","Smoky:",whiskey$Smoky,"<br>","Medicinal:",whiskey$Medicinal,"<br>","Tobacco:",whiskey$Tobacco,"<br>","Honey:",whiskey$Honey,"<br>","Spicy:",whiskey$Spicy,"<br>","Winey:",whiskey$Winey,"<br>","Nutty:",whiskey$Nutty,"<br>","Malty:",whiskey$Malty,"<br>","Fruity:",whiskey$Fruity,"<br>","Floral:",whiskey$Floral,"<br>","Postcode:",whiskey$Postcode,"<br>","Lattitude:",whiskey$Latitude,"<br>","Longitude:",whiskey$Longitude))%>%addMiniMap()
setView(map,lng=-2.4333,lat=53.5500,zoom=9)
library(leaflet)
library(dplyr)
newicon<-makeIcon(iconUrl="https://cdn0.iconfinder.com/data/icons/alcoholic/120/bourbon1-512.png",iconWidth=50,iconHeight=65)
map<-leaflet()%>%
  addTiles()%>%
  addProviderTiles(providers$OpenStreetMap)%>%
  addMarkers(lng=UK.map$long,lat=UK.map$lat,icon=newicon,clusterOptions = markerClusterOptions(),popup=paste("<h3>Info Table</h3>","<b>Distillery name:</b>",whiskey_db$Distiller,"<br>","<b>Body:</b>",whiskey$Body,"<br>","<b>Sweetness:</b>",whiskey$Sweetness,"<br>","<b>Smoky:</b>",whiskey$Smoky,"<br>","<b>Medicinal:</b>",whiskey$Medicinal,"<br>","<b>Tobacco:</b>",whiskey$Tobacco,"<br>","<b>Honey:</b>",whiskey$Honey,"<br>","<b>Spicy:</b>",whiskey$Spicy,"<br>","<b>Winey:</b>",whiskey$Winey,"<br>","<b>Nutty:</b>",whiskey$Nutty,"<br>","<b>Malty:</b>",whiskey$Malty,"<br>","<b>Fruity:</b>",whiskey$Fruity,"<br>","<b>Floral:</b>",whiskey$Floral,"<br>","<b>Postcode:</b>",whiskey$Postcode,"<br>","<b>Lattitude:</b>",whiskey$Latitude,"<br>","<b>Longitude:</b>",whiskey$Longitude))%>%addMiniMap()
setView(map,lng=-2.4333,lat=53.5500,zoom=9)
ibrary(leaflet)
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
