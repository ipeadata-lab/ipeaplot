test_that("scale_color_ipea() switches NT/TD to their categorical variant for discrete data", {
  p <- suppressWarnings(
    ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg, color = factor(cyl))) +
      ggplot2::geom_point() +
      scale_color_ipea(palette = "NT")
  )
  b <- ggplot2::ggplot_build(p)
  expect_length(unique(b$data[[1]]$colour), 3)
})

test_that("scale_color_ipea() keeps NT/TD sequential for continuous data", {
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg, color = cyl)) +
    ggplot2::geom_point() +
    scale_color_ipea(palette = "NT")
  expect_silent(ggplot2::ggplot_build(p))
})

test_that("scale_color_ipea() leaves the plot untouched when there's no colour aesthetic", {
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg)) +
    ggplot2::geom_point() +
    scale_color_ipea()
  expect_s3_class(p, "ggplot")
})

test_that("scale_color_ipea() validates decimal.mark", {
  expect_error(
    ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg, color = cyl)) +
      ggplot2::geom_point() +
      scale_color_ipea(decimal.mark = "x"),
    "Decimal.mark"
  )
})

test_that("scale_fill_ipea() switches NT/TD to their categorical variant for discrete data", {
  p <- suppressWarnings(
    ggplot2::ggplot(mtcars, ggplot2::aes(factor(cyl), mpg, fill = factor(cyl))) +
      ggplot2::geom_col() +
      scale_fill_ipea(palette = "TD")
  )
  b <- ggplot2::ggplot_build(p)
  expect_length(unique(b$data[[1]]$fill), 3)
})

test_that("scale_fill_ipea() validates decimal.mark", {
  expect_error(
    ggplot2::ggplot(mtcars, ggplot2::aes(factor(cyl), mpg, fill = cyl)) +
      ggplot2::geom_col() +
      scale_fill_ipea(decimal.mark = "x"),
    "Decimal.mark"
  )
})
