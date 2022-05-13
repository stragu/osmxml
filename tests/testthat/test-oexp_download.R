froggy <- c(152.99677, -27.48936, 152.99749, -27.48874)
test_that("oexp_download errors on bad arguments", {
  expect_error(oexp_download(bbox = 1.23))
  expect_error(oexp_download(bbox = "character"))
  expect_error(oexp_download(bbox = froggy,
                             destfile = c("a.osm", "b.osm")))
  expect_error(oexp_download(bbox = froggy,
                             destfile = 1))
})
test_that("oexp_download returns a character vector and writes a file", {
  skip_on_cran()
  expect_type(suppressMessages(oexp_download(bbox = froggy)), type = "character")
  expect_true(file.exists("oexp_152.99677_-27.48936_152.99749_-27.48874.osm"))
})
test_that("oexp_download uses cached file", {
  skip_on_cran()
  expect_message(oexp_download(bbox = froggy),
                 "Using cached")
})
file.remove("oexp_152.99677_-27.48936_152.99749_-27.48874.osm")
