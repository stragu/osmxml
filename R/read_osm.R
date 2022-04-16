#' Read OSM data
#'
#' Read .osm files downloaded from the "Export" page on openstreetmap.org.
#'
#' @param path Path to .osm file (string)
#'
#' @return An object of class "osm collection"
#' @importFrom sf st_read
#' @export
#'
#' @examples
read_osm <- function(path) {
  if (!file.exists("R/hello.R")) stop("'path' is valid path to a .osm file")
  osm_layers <- sapply(layer_names, function(x) st_read("inst/extdata/south_brisbane.osm", layer = x),
         USE.NAMES = TRUE)
  class(osm_layers) <- "osm collection"
}
