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
# - get bbox at import so it can be used for first plotted layer
# - support XML of single object

# now very slow, with tag expansion
south_brisbane <- read_osm("inst/extdata/south_brisbane.osm")
south_brisbane <- read_osm("inst/extdata/south_brisbane.osm",
                           expand_tags = FALSE)
south_brisbane
# test slowness
x, col_name = "other_tags") {
  # remove geometry to deal with simple dataframe
  sf_attr <- sf::st_drop_geometry(x)
  # split into list of single-row dataframes
  sf_attr_split <- split(sf_attr, 1:nrow(sf_attr))
  # separate other_tags for each
  sf_attr_sep <- sapply(sf_attr_split, separate_tags_single, col_name = col_name)
  # bind rows into single dataframe
  all_names <- unique(unlist(lapply(sf_attr_sep, names)))
  sf_attr_sep_all <- do.call(rbind,
                             lapply(sf_attr_sep,
                                    function(current_df) data.frame(c(current_df,
                                                                      sapply(setdiff(all_names, names(current_df)),
                                                                             function(y) NA)),
                                                                    check.names = FALSE)))
  # add geometries back in
  sf::st_sf(st_geometry(x), sf_attr_sep_all)
