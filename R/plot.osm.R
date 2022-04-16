#' Plot OSM data
#'
#' @param x Object of class 'osm'
#'
#' @return A static visualisation
#' @importFrom sf st_geometry
#' @export
#'
#' @examples
plot.osm <- function(x) {
  layers <- names(x)
  if ("multipolygons" %in% layers) {
    st_geometry(x$multipolygons) %>%
      plot(border = 1, col = rgb(198, 198, 198, 100, maxColorValue = 255))
  }
  if ("multilinestrings" %in% layers) {
    st_geometry(x$multilinestrings) %>% plot(col = 5, add = TRUE)
  }
  if ("lines" %in% layers) {
    st_geometry(x$lines) %>% plot(col = 3, add = TRUE)
  }
  if ("points" %in% layers) {
    st_geometry(x$points) %>% plot(col = 4, add = TRUE)
  }
}

