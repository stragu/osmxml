% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ox_read.R
\name{ox_read}
\alias{ox_read}
\title{Read OSM data}
\usage{
ox_read(path, expand_tags = TRUE)
}
\arguments{
\item{path}{Path to .osm file (string)}

\item{expand_tags}{Should the "other_tags" column be expanded into
single-tag columns? (logical; default is TRUE)}
}
\value{
An object of class "osm". There are \code{print} and \code{plot}
  methods for this class.

  According to GDAL, the object is made of:
  \itemize{
  \item points: “node” features that have
  significant tags attached
  \item lines: “way” features that are not recognised
  as areas
  \item multilinestrings: “relation” features that form a
  multilinestring (type = ‘multilinestring’ or type = ‘route’)
  \item
  multipolygons: “relation” features that form a multipolygon (type =
  ‘multipolygon’ or type = ‘boundary’), and “way” features that are
  recognised as areas
  \item other_relations: “relation” features that do not
  belong to either multilinestrings or multipolygons
  }
}
\description{
Read OSM XML files, sometimes obtained from the "Export" page on
openstreetmap.org. Internally, uses the \code{sf::st_read()} function, which
itself use GDAL's OSM driver: \url{https://gdal.org/drivers/vector/osm.html}
}
\examples{
# read example South Brisbane .osm file
sb <- ox_read(
  system.file("extdata/south_brisbane.osm",
              package = "osmxml"),
  expand_tags = FALSE)
}
