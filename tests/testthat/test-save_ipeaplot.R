local_test_dir <- function() {
  td <- tempfile("ipeaplot-test-")
  dir.create(td)
  withr::defer(unlink(td, recursive = TRUE), envir = parent.frame())
  td
}

base_plot <- function() {
  ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg)) + ggplot2::geom_point()
}

test_that("save_ipeaplot() saves a png that exists and is non-empty", {
  td <- local_test_dir()
  out <- save_ipeaplot(base_plot(), file.name = "fig", format = "png", path = td)
  expect_true(file.exists(out))
  expect_gt(file.size(out), 0)
})

test_that("save_ipeaplot() saves multiple formats at once", {
  td <- local_test_dir()
  out <- save_ipeaplot(base_plot(), file.name = "fig", format = c("png", "pdf"),
                        path = td, use_cairo = FALSE)
  expect_length(out, 2)
  expect_true(all(file.exists(out)))
})

test_that("save_ipeaplot() creates numbered suffixes when overwrite = FALSE", {
  td <- local_test_dir()
  out1 <- save_ipeaplot(base_plot(), file.name = "fig", format = "png", path = td)
  out2 <- save_ipeaplot(base_plot(), file.name = "fig", format = "png", path = td, overwrite = FALSE)
  expect_false(out1 == out2)
  expect_match(out2, "fig_1\\.png$")
})

test_that("save_ipeaplot() appends the date when include_date = TRUE", {
  td <- local_test_dir()
  out <- save_ipeaplot(base_plot(), file.name = "fig", format = "png", path = td, include_date = TRUE)
  expect_match(out, format(Sys.Date(), "%Y%m%d"))
})

test_that("save_ipeaplot() validates its inputs", {
  td <- local_test_dir()
  expect_error(save_ipeaplot("not-a-ggplot", file.name = "x", format = "png", path = td),
               "gplot must be a ggplot2 object")
  expect_error(save_ipeaplot(base_plot(), file.name = "", format = "png", path = td),
               "file.name must be a non-empty string")
  expect_error(save_ipeaplot(base_plot(), file.name = "x", format = "docx", path = td))
})
