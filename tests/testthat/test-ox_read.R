south_brisbane <- ox_read(system.file("extdata/south_brisbane.osm",
                                        package = "osmxml"),
                            expand_tags = FALSE)
test_that("ox_read returns object of right class and type", {
  expect_s3_class(south_brisbane, "osm")
  expect_type(south_brisbane, "list")
})
test_that("ox_read returns object of right size", {
  expect_equal(length(south_brisbane),
               length(sf::st_layers(
                 system.file("extdata/south_brisbane.osm",
                             package = "osmxml")
                 )$geomtype))
})
