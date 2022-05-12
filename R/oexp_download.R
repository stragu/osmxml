#' Download OSM export
#'
#' Download an OSM export by specifying its bounding box, or find a local cached
#' equivalent. The osmexport package does not further make use of the OSM API,
#' given that it is mainly intended to be used for editing purposes, as explained
#' on the API Usage Policy website:
#' \url{https://operations.osmfoundation.org/policies/api/}. This function
#' only mimics the existing \url{https://www.openstreetmap.org} "Export"
#' functionality to save the user manually downloading the file from the website.
#'
#' @section Licence:
#'
#' All data downloaded with this function is © OpenStreetMap contributors,
#' and the conditions of its reuse are defined by the ODbL licence.
#' You likely need to include this information on anything derived from it.
#' Find out more on the OSM website: \url{https://www.openstreetmap.org/copyright}
#'
#' @param bbox bounding box of area to download, determined by a numeric vector
#'   of four values: Western longitude, Southern latitude, Eastern longitude,
#'   Northern latitude (in this order)
#' @param destfile path to download the file to. Defaults to a filename
#'   that includes the bbox values so it can be used as cached data (in the
#'   current working directory).
#' @param use_cached should the function look for a matching cached file?
#'   Logical, default is TRUE.
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
oexp_download <- function(bbox, destfile = NULL, use_cached = TRUE) {
  # check validity of bounding box
  if (length(bbox) != 4 | !is.numeric(bbox)) {
    stop("bbox must be a numeric vector of length 4")
  }
  # build default name if none supplied
  if (is.null(destfile)) {
    destfile <- paste0("oexp_",
                              paste(bbox, collapse = "_"),
                              ".osm")
    # check if cached file exists, and if so, return its name
    if (file.exists(destfile) & use_cached) {
      message("Using cached file ", destfile,
              ", which was last modified on ",
              file.mtime(destfile))
      return(destfile)
    }
  } else {
    # check validity of destfile
    if (!is.character(destfile) | length(destfile) != 1) {
      stop("destfile must be a character vector of length 1")
    }
  }
  # build query to OSM API
  query <- paste0("https://www.openstreetmap.org/api/0.6/map?bbox=",
                  bbox[1], "%2C",
                  bbox[2], "%2C",
                  bbox[3], "%2C",
                  bbox[4])
  # wait for 1 second to be respectful of API
  Sys.sleep(1)
  # download OSM export
  download.file(query, destfile,
                headers = c("User-Agent" = paste("R package osmexport v.",
                                                 packageVersion("osmexport")))
                )
  # return the path for reuse
  return(destfile)
}
