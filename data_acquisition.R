
appearances <- read_csv(file.path('data','appearances.csv'))
characters <- read_csv(file.path('data','characters.csv'))
episodes <- read_csv(file.path('data','episodes.csv'))
populations <- read_csv(file.path('data','populations.csv'))
scenes <- read_csv(file.path('data','scenes.csv'))

colforest="#c0d7c2"
colriver="#7ec9dc"
colland="ivory"
borderland = "ivory3"

# geographic data
locations <- st_read("./data/GoTRelease/Locations.shp",crs=4326)
lakes <- st_read("./data/GoTRelease/Lakes.shp",crs=4326)
conts <- st_read("./data/GoTRelease/Continents.shp",crs=4326)
land <- st_read("./data/GoTRelease/Land.shp",crs=4326)
wall <- st_read("./data/GoTRelease/Wall.shp",crs=4326)
islands <- st_read("./data/GoTRelease/Islands.shp",crs=4326)
kingdoms <- st_read("./data/GoTRelease/Political.shp",crs=4326)
landscapes <- st_read("./data/GoTRelease/Landscape.shp",crs=4326)
roads <- st_read("./data/GoTRelease/Roads.shp",crs=4326)
rivers <- st_read("./data/GoTRelease/Rivers.shp",crs=4326)
scenes_loc <- st_read("./data/GoTRelease/ScenesLocations.shp",crs=4326)
