#' Read OSM data
#'
#' Read .osm files downloaded from the "Export" page on openstreetmap.org.
#'
#' @param path Path to .osm file (string)
#'
#' @return An object of class "osm". There are print and plot methods for this
#' class.
#' @importFrom sf st_read st_layers
#' @export
#'
#' @examples
read_osm <- function(path) {
  if (!file.exists(path)) stop("'path' is not a valid path to a .osm file")
  # store names of all components of OSM file
  layer_names <- st_layers(path)$name
  # read all layers, keeping names
  osm_layers <- sapply(layer_names, function(x) st_read(path,
                                                        layer = x,
                                                        quiet = TRUE),
         USE.NAMES = TRUE)
  # assign S3 class
  class(osm_layers) <- "osm"
  # return a list of class "osm collection"
  osm_layers
}


#' Title
#'
#' @param obj
#'
#' @return
#' @export
#'
#' @examples
print.osm <- function(obj) {
  cat("OSM data object made of", length(obj), "simple feature collections: ")
  cat(paste(names(obj), collapse = ", "))
}
