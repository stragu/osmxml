#' Separate other_tags column into separate, single-tag columns
#'
#' @param x sf object containing a column grouping many OSM tags
#' @param col_name name of the column containing grouped tags (string; default is "other_tags")
#'
#' @return sf object with single-tag columns
#' @export
#' @importFrom sf st_drop_geometry st_geometry st_sf
#' @importFrom dplyr bind_rows
#' @importFrom utils strcapture
#'
#' @examples
ox_separate_tags <- function(x, col_name = "other_tags") {
  # remove geometry to deal with simple dataframe
  sf_attr <- sf::st_drop_geometry(x)
  # split into list of single-row dataframes
  sf_attr_split <- split(sf_attr, 1:nrow(sf_attr))
  # separate other_tags for each
  sf_attr_sep <- lapply(sf_attr_split, separate_tags_single, col_name = col_name)
  # if single-row dataframe, don't bind rows
  if (length(sf_attr_sep) > 1) {
    # bind rows into single dataframe
    sf_attr_sep <- dplyr::bind_rows(sf_attr_sep)
  }
  # add geometries back in
  sf::st_sf(st_geometry(x), sf_attr_sep)
}

# helper function for expanding tags in single-row dataframe
separate_tags_single <- function(x, col_name = "other_tags") {
  # if no extra tag(s), return dataframe as is, without other_tags column
  if (is.na(x[[col_name]])) {
    x[[col_name]] <- NULL
    return(x)
  }
  # split tags into character vector
  others <- strsplit(x[[col_name]], '","')[[1]]
  # remove double-quotes
  others <- sapply(others, gsub, pattern = '"', replacement = "")
  # construct dataframe of key-value pairs
  others_df <- strcapture("(.*)=>(.*)",
                          others,
                          data.frame(key = character(), value = character()))
  # make key the row name (while catering for corner cases) ...
  others_df <- data.frame(others_df[,-1, drop = FALSE], row.names = others_df[,1])
  # ... so we can transpose with column names
  others_wide <- t(others_df)
  # bind columns
  single_wide <- cbind(x, others_wide)
  # remove original
  single_wide[[col_name]] <- NULL
  # return wide single-row dataframe
  single_wide
}
