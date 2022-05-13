south_brisbane <- oexp_read(system.file("extdata/south_brisbane.osm",
                                        package = "osmexport"),
                            expand_tags = FALSE)
test_that("print method works", {
  expect_vector(print(south_brisbane),
                ptype = character(),
                size = 5)
})
