#### Example OSM file ####

# downloaded from the website

library(sf)
# see layers
osm_layers <- st_layers("inst/extdata/south_brisbane.osm")
# default reads first layer
osm_data <- st_read("inst/extdata/south_brisbane.osm")
# store names of layers
layer_names <- st_layers("inst/extdata/south_brisbane.osm")$name
osm_all_layers <- sapply(layer_names, function(x) st_read("inst/extdata/south_brisbane.osm", layer = x), USE.NAMES = TRUE)

plot(osm_all_layers$points)
class(osm_all_layers) <- "osm_collection"
plot(osm_all_layers$multipolygons)

# test read function
south_brisbane <- read_osm("inst/extdata/south_brisbane.osm")
south_brisbane
class(south_brisbane)
print.osm(south_brisbane)
south_brisbane

# plot
class(south_brisbane$multilinestrings)
plot(south_brisbane)
# what are other_relations?
plot(south_brisbane$other_relations)
south_brisbane$other_relations %>% st_drop_geometry() %>% View()
# transparent grey
rgb(198, 198, 198, 100, maxColorValue = 255)


# TODO
# - expand tags at import
# - get bbox at import so it can be used for first plotted layer
# -
