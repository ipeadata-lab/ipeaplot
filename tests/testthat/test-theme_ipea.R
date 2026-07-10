base_plot <- function() {
  ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg)) + ggplot2::geom_point()
}

test_that("theme_ipea() defaults legend.position to bottom", {
  p <- base_plot() + theme_ipea()
  expect_equal(p$theme$legend.position, "bottom")
})

test_that("theme_ipea() validates axis_lines, grid.adjust and legend.position", {
  expect_error(base_plot() + theme_ipea(axis_lines = "bad"))
  expect_error(base_plot() + theme_ipea(grid.adjust = "bad"))
  expect_error(base_plot() + theme_ipea(legend.position = "bad"))
})

test_that("theme_ipea() validates axis_values", {
  expect_error(base_plot() + theme_ipea(axis_values = "bad"), "axis_values must be TRUE or FALSE")
})

test_that("theme_ipea() gives geom_point() a square marker only alongside a line layer", {
  p_scatter <- base_plot() + theme_ipea()
  expect_null(p_scatter$layers[[1]]$aes_params$shape)

  p_line <- ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg)) +
    ggplot2::geom_line() +
    ggplot2::geom_point() +
    theme_ipea()
  expect_equal(p_line$layers[[2]]$aes_params$shape, 15)
})

test_that("theme_ipea() never overrides a shape already set by the user", {
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg)) +
    ggplot2::geom_line() +
    ggplot2::geom_point(shape = 17) +
    theme_ipea()
  expect_equal(p$layers[[2]]$aes_params$shape, 17)
})

test_that("theme_ipea() x-axis labels don't collide when line count is mixed", {
  # Regression test: a stray vjust = -1 on axis.text.x misaligned single-line
  # category labels whenever other categories on the same axis wrapped to two
  # lines via "\n", making the single-line label overlap the axis title.
  df <- data.frame(g = factor(c("A\nB", "C", "D\nE"), levels = c("A\nB", "C", "D\nE")), v = c(3, 10, 5))
  p <- ggplot2::ggplot(df, ggplot2::aes(g, v)) + ggplot2::geom_col() + theme_ipea()
  expect_equal(p$theme$axis.text.x$vjust, 1)
})
