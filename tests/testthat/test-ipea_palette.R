all_palettes <- c(
  "Blue", "Green", "Orange", "Pink", "Pink-Deep",
  "Green-Blue", "Green-Blue-White", "Red-Blue", "Red-Blue-White",
  "Orange-Blue", "Orange-Blue-White",
  "Viridis", "Inferno", "Magma", "Plasma", "Cividis",
  "NT", "NT-Categorical", "TD", "TD-Categorical"
)

test_that("ipea_palette() returns n valid hex colours for every named palette", {
  for (p in all_palettes) {
    cols <- ipea_palette(palette = p, n = 5)
    expect_length(cols, 5)
    expect_true(all(grepl("^#[0-9A-Fa-f]{6,8}$", cols)), info = p)
  }
})

test_that("ipea_palette() returns character(0) for n = 0", {
  expect_identical(ipea_palette(palette = "Blue", n = 0), character(0))
})

test_that("ipea_palette() errors on an unknown palette name", {
  expect_error(ipea_palette(palette = "NaoExiste", n = 3), "Palette")
})

test_that("ipea_palette() validates begin/end", {
  expect_error(ipea_palette(palette = "Blue", n = 3, begin = -1), "begin and end")
  expect_error(ipea_palette(palette = "Blue", n = 3, end = 2), "begin and end")
})

test_that("ipea_palette() validates palette_direction", {
  expect_error(ipea_palette(palette = "Blue", n = 3, palette_direction = 2), "palette_direction")
})

test_that("NT/TD sequential palettes return n colours interpolated from their anchors", {
  expect_length(ipea_palette(palette = "NT", n = 10), 10)
  expect_length(ipea_palette(palette = "TD", n = 10), 10)
})

test_that("NT-Categorical/TD-Categorical recycle to any n", {
  expect_length(ipea_palette(palette = "NT-Categorical", n = 12), 12)
  expect_length(ipea_palette(palette = "NT-Categorical", n = 20), 20)
  expect_length(ipea_palette(palette = "TD-Categorical", n = 5), 5)
})

test_that("the blue-channel low-nibble colour bug stays fixed", {
  # Regression test: an incorrect string offset used to silently force the
  # low nibble of the blue channel to 'F' in every generated colour.
  cols <- ipea_palette(palette = "Blue", n = 9)
  blue_low_nibble <- toupper(substr(cols, 7, 7))
  expect_false(all(blue_low_nibble == "F"))
})

test_that("ipea_pal() returns a palette-generating function", {
  f <- ipea_pal(palette = "Green")
  expect_type(f, "closure")
  expect_length(f(4), 4)
})
