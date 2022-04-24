south_brisbane <- oexp_read("../../inst/extdata/south_brisbane.osm",
                            expand_tags = FALSE)
test_that("print method works", {
  expect_vector(print(south_brisbane),
                ptype = character(),
                size = 5)
})
