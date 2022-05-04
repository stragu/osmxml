south_brisbane <- oexp_read("../../inst/extdata/south_brisbane.osm",
                            expand_tags = FALSE)
test_that("oexp_read returns object of right class and type", {
  expect_s3_class(south_brisbane, "osm")
  expect_type(south_brisbane, "list")
})
test_that("oexp_read returns object of right size", {
  expect_equal(length(south_brisbane),
               length(sf::st_layers("../../inst/extdata/south_brisbane.osm")$geomtype))
})
