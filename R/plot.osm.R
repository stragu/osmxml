#' Plot OSM data
#'
#' Rudimentary rendering of an OSM export, with one style per layer.
#'
#' @param x Object of class 'osm'
#' @param layers Character vector of names of items to plot
#' @param palette Vector of colour values of same length as layers
#'
#' @return A static visualisation
#' @importFrom sf st_geometry
#' @export
#'
#' @examples
plot.osm <- function(x, layers = c("multipolygons", "multilinestrings", "lines",
                                   "points", "other_relations"),
                     palette = c(1,2,3,4,6)) {
  x_names <- names(x)
  names(palette) <- layers
  if ("multipolygons" %in% x_names & "multipolygons" %in% layers) {
    st_geometry(x$multipolygons) %>%
      plot(border = palette["multipolygons"], col = rgb(198, 198, 198, 100, maxColorValue = 255))
  }
  if ("multilinestrings" %in% x_names & "multilinestrings" %in% layers) {
    st_geometry(x$multilinestrings) %>% plot(col = palette["multilinestrings"], add = TRUE)
  }
  if ("lines" %in% x_names & "lines" %in% layers) {
    st_geometry(x$lines) %>% plot(col = palette["lines"], add = TRUE)
  }
  if ("points" %in% x_names & "points" %in% layers) {
    st_geometry(x$points) %>% plot(col = palette["points"], add = TRUE)
  }
  if ("other_relations" %in% x_names & "other_relations" %in% layers) {
    st_geometry(x$other_relations) %>% plot(col = palette["other_relations"], add = TRUE)
  }
  legend("topright", legend = layers, fill = palette, cex = .8, y.intersp = .8)
}
