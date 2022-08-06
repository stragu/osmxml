#' Plot OSM data
#'
#' Rudimentary rendering of OSM XML data, with one style per layer.
#'
#' @param x Object of class 'osm'
#' @param layers Character vector of names of items to plot
#' @param palette Vector of colour values of same length as layers
#'
#' @return A static visualisation
#' @importFrom sf st_geometry
#' @importFrom graphics par legend
#' @importFrom grDevices rgb
#' @export
#'
#' @examples
plot.osm <- function(x, layers = c("multipolygons", "multilinestrings", "lines",
                                   "points", "other_relations"),
                     palette = c(1,2,3,4,6)) {
  x_names <- names(x)
  names(palette) <- layers
  graphics::par(xpd = TRUE)
  # 1. Multipolygons
  if ("multipolygons" %in% x_names & "multipolygons" %in% layers) {
    st_geometry(x$multipolygons) %>%
      plot(border = palette["multipolygons"],
           # transparent grey fill
           col = rgb(198, 198, 198, 100, maxColorValue = 255))
  }
  # 2. Multiline strings
  if ("multilinestrings" %in% x_names & "multilinestrings" %in% layers) {
    st_geometry(x$multilinestrings) %>% plot(col = palette["multilinestrings"], add = TRUE)
  }
  # 3. Lines
  if ("lines" %in% x_names & "lines" %in% layers) {
    st_geometry(x$lines) %>% plot(col = palette["lines"], add = TRUE)
  }
  # 4. Points
  if ("points" %in% x_names & "points" %in% layers) {
    st_geometry(x$points) %>% plot(col = palette["points"], add = TRUE)
  }
  # 5. Other relations
  if ("other_relations" %in% x_names & "other_relations" %in% layers) {
    st_geometry(x$other_relations) %>% plot(col = palette["other_relations"], add = TRUE)
  }
  # Compose legend without overplotting
  # use symbols for 3 layers
  legend("topleft", legend = layers, col = palette,
         pch = c(0, NA, NA, 1, 13))
  # use lines for 2 (multi)line layers
  legend("topleft", legend = rep.int("", length(layers)), col = palette,
         pch = c(NA, "\u2014", "\u2014", NA, NA), bty = "n")
}
