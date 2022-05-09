# we are required to make the data licence clear
.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    paste("All data, downloaded or included as an example, is",
          "© OpenStreetMap contributors,",
          "and the conditions of its reuse are defined by the",
          "ODbL licence.\nFind out more on the OSM website:",
          "https://www.openstreetmap.org/copyright")
    )
}
