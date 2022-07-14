

library(maps)
library(sf)

world.cities

cities <- st_as_sf(world.cities, coords = c("long", "lat"), 
         crs = 4326, agr = "field")

cities <- cities %>% 
  rename(country = country.etc)

world <- ne_countries(scale = "medium", returnclass = "sf")

city_matches <- geomander::geo_match(cities, world)

cities$continent <- world$continent[city_matches]
  

saveRDS(cities, "lessons/data/cities.rds")
