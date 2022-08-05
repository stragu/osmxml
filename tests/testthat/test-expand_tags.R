south_brisbane <- ox_read(system.file("extdata/south_brisbane.osm",
                                        package = "osmxml"),
                            expand_tags = FALSE)
sb_points <- south_brisbane$points

test_that("Single-row dataframe works", {
  expect_equal(nrow(ox_separate_tags(sb_points[1,])),
               nrow(sb_points[1,]))
})

test_that("Works when no other tags", {
  expect_equal(ncol(ox_separate_tags(sb_points[1,])),
               ncol(sb_points)-1)
})

test_that("Works when single other tag", {
  expect_equal(ncol(ox_separate_tags(sb_points[10,])),
               ncol(sb_points))
})

test_that("Works when several other tags", {
  expect_equal(ncol(ox_separate_tags(sb_points[16,])),
               ncol(sb_points) + 1)
})
