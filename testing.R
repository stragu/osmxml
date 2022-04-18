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

# try it
ost_output <- osm_separate_tags(ml)
class(ost_output)
class(ml)
?cbind
# two "other_tags"
x <- south_brisbane$points[16,]
# single "other_tags"
x <- south_brisbane$points[10,]
col_name <- "other_tags"
# if no extra tag(s), return dataframe as is
if (is.na(x[[col_name]])) return(x)
# split tags into character vector
others <- strsplit(x[[col_name]], '","')[[1]]
# remove double-quotes
others <- sapply(others, gsub, pattern = '"', replacement = "")
# construct dataframe of key-value pairs
others_df <- strcapture("(.*)=>(.*)",
                        others,
                        data.frame(key = character(), value = character()))
# make key the row name...
others_df <- data.frame(others_df, row.names = 1)
others_df <- data.frame(others_df[,-1], row.names = others_df[,1])
rownames(others_df) <- others_df[,1]
others_df <- others_df[,-1]
col_names <- others_df$key
others_wide <- data.frame()
colnames(others_wide) <- others_df$key
others_wide[1,] <- others_df$value
others_mat <- matrix(data = others_df$value, byrow = TRUE)
colnames(others_mat) <- others_df$key
others_wide <- as.data.frame(others_mat)
# ... so we can transpose with column names
others_wide <- t(others_df) # issue is here
colnames()
# bind columns
single_wide <- cbind(x, others_wide)
# remove original
single_wide$other_tags <- NULL
# return wide single-row df
single_wide

# new functions
south_brisbane <- read_osm("inst/extdata/south_brisbane.osm")
osm_separate_tags(south_brisbane$points) # error, and very slow
osm_separate_tags(south_brisbane$points)
south_brisbane
plot(south_brisbane)
