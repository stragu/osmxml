south_brisbane <- ox_read(system.file("extdata/south_brisbane.osm",
                                        package = "osmxml"),
                            expand_tags = FALSE)
test_that("print method works", {
  expect_vector(print(south_brisbane),
                ptype = character(),
                size = 5)
})
