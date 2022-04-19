south_brisbane <- read_osm("../../inst/extdata/south_brisbane.osm",
                           expand_tags = FALSE)
sb_points <- south_brisbane$points

test_that("Single-row dataframe works", {
  expect_equal(nrow(osm_separate_tags(sb_points[1,])),
               nrow(sb_points[1,]))
})

test_that("Works when no other tags", {
  expect_equal(ncol(osm_separate_tags(sb_points[1,])),
               ncol(sb_points)-1)
})

test_that("Works when single other tag", {
  expect_equal(ncol(osm_separate_tags(sb_points[10,])),
               ncol(sb_points))
})

test_that("Works when several other tags", {
  expect_equal(ncol(osm_separate_tags(sb_points[16,])),
               ncol(sb_points) + 1)
})
