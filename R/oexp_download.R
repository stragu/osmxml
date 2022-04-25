#' Download OSM export
#'
#' @param bbox bounding box of area to download, determined by a numeric vector
#'   of four values: Western longitude, Southern latitude, Eastern longitude,
#'   Northern latitude (in this order)
#' @param destfile path to download the file to. Defaults to "map.osm" in the
#' current working directory.
#'
#' @return The path is returned so it can easily be piped into the
#'   \code{\link{oexp_read}} function
#' @export
#'
#' @examples
#' \dontrun{
#' # Download and read area around Te Kura Tatauranga, Waipapa Taumata Rau
#' TKT <- c(174.76598, -36.85440, 174.77019, -36.85129) |>
#'    oexp_download() |>
#'    oexp_read()
#' }
oexp_download <- function(bbox, destfile = "map.osm") {
  # check validity of bounding box
  if (length(bbox) != 4 | !is.numeric(bbox)) {
    stop("bbox must be a numeric vector of length 4")
  }
  # build query to OSM API
  query <- paste0("https://www.openstreetmap.org/api/0.6/map?bbox=",
                  bbox[1], "%2C",
                  bbox[2], "%2C",
                  bbox[3], "%2C",
                  bbox[4])
  # download OSM export
  download.file(query, destfile)
  # return the path for reuse
  return(destfile)
}
