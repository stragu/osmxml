#### TODO ####

# - get bbox at import so it can be used for first plotted layer
# - support XML of single object (?) -> this would add osmdata to dependencies
# - add tests
# V make binding faster
# - import id presets: https://github.com/openstreetmap/id-tagging-schema/tree/main/data/presets
# - download from web, syntax: https://www.openstreetmap.org/api/0.6/map?bbox=153.01449%2C-27.52169%2C153.03133%2C-27.51274
# - add "source" attribute, to potentially differentiate between import methods in the future

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

#### Faster ####

# now very slow, with tag expansion
south_brisbane <- read_osm("inst/extdata/south_brisbane.osm")
south_brisbane <- read_osm("inst/extdata/south_brisbane.osm",
                           expand_tags = FALSE)
south_brisbane
# test slowness
x = south_brisbane$points
col_name = "other_tags"
# remove geometry to deal with simple dataframe
sf_attr <- sf::st_drop_geometry(x)
# split into list of single-row dataframes
sf_attr_split <- split(sf_attr, 1:nrow(sf_attr))
# separate other_tags for each: somwhat slow too
sf_attr_sep <- sapply(sf_attr_split, separate_tags_single, col_name = col_name)
# bind rows into single dataframe
sf_attr_sep_all <- dplyr::bind_rows(sf_attr_sep)
# add geometries back in
sf::st_sf(st_geometry(x), sf_attr_sep_all)

# get geometry type

annerley <- read_osm("~/Downloads/map.osm")
annerley
plot(annerley)
annerley$other_relations %>% summary()
sf::st_geometry_type(annerley$other, by_geometry = FALSE)
sapply(annerley, sf::st_geometry_type, by_geometry = FALSE)

#### single row dataframe ####
x = sb_points[1,]
col_name = "other_tags"
# remove geometry to deal with simple dataframe
sf_attr <- sf::st_drop_geometry(x)
# split into list of single-row dataframes
sf_attr_split <- split(sf_attr, 1:nrow(sf_attr))
# separate other_tags for each
sf_attr_sep <- lapply(sf_attr_split, separate_tags_single, col_name = col_name)
# if single-row dataframe, don't bind rows
if (length(sf_attr_sep) > 1) {
  # bind rows into single dataframe
  all_names <- unique(unlist(lapply(sf_attr_sep, names)))
  sf_attr_sep <- do.call(rbind,
                         lapply(sf_attr_sep,
                                function(current_df) data.frame(c(current_df,
                                                                  sapply(setdiff(all_names, names(current_df)),
                                                                         function(y) NA)),
                                                                check.names = FALSE)))
}
# add geometries back in
sf::st_sf(st_geometry(x), sf_attr_sep)
