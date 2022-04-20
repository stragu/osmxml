#' Read OSM data
#'
#' Read .osm files downloaded from the "Export" page on openstreetmap.org.
#'
#' @param path Path to .osm file (string)
#' @param expand_tags Should the "other_tags" columns be expanded into single-tag columns? (logical; default is TRUE)
#'
#' @return An object of class "osm". There are print and plot methods for this
#' class.
#' @importFrom sf st_read st_layers st_geometry_type
#' @importFrom magrittr %>%
#' @export
#'
#' @examples
read_osm <- function(path, expand_tags = TRUE) {
  if (!file.exists(path)) stop("'path' is not a valid path to a .osm file")
  # store names of all components of OSM file
  layer_names <- st_layers(path)$name
  # read all layers, keeping names
  osm_layers <- sapply(layer_names, function(x) st_read(path,
                                                        layer = x,
                                                        quiet = TRUE),
                       USE.NAMES = TRUE)
  # only expand other_tags if user chose to
  if (expand_tags) {
    osm_layers <- lapply(osm_layers, osm_separate_tags)
  }
  # assign S3 class
  class(osm_layers) <- "osm"
  # return a list of class "osm collection"
  osm_layers
}


#' Print method for OSM objects
#'
#' @param obj Object of class "osm"
#'
#' @return Description of object: what it is and what it contains.
#' @export
#'
#' @examples
print.osm <- function(obj) {
  cat("OSM data object made of", length(obj), "simple feature collections: ")
  cat(paste(names(obj), collapse = ", "))
  cat("\nThe corresponding sf geometry types are:\n")
  geom_types <- sapply(obj, sf::st_geometry_type, by_geometry = FALSE) %>%
    as.character()
  names(geom_types) <- names(obj)
  print(geom_types, quote = FALSE)
}
