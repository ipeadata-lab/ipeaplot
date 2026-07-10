test_that("ipea_contrast_color() picks white text for dark backgrounds", {
  expect_equal(ipea_contrast_color("#29112F"), "white")
  expect_equal(ipea_contrast_color("black"), "white")
})

test_that("ipea_contrast_color() picks black text for light backgrounds", {
  expect_equal(ipea_contrast_color("#D2A0C9"), "black")
  expect_equal(ipea_contrast_color("white"), "black")
})

test_that("ipea_contrast_color() is vectorised and preserves order", {
  out <- ipea_contrast_color(c("#29112F", "#D2A0C9", "white", "black"))
  expect_equal(out, c("white", "black", "black", "white"))
  expect_length(out, 4)
})

test_that("ipea_contrast_color() accepts a single colour", {
  expect_length(ipea_contrast_color("#29112F"), 1)
})
