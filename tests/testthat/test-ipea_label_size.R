test_that("ipea_label_size() converts pt to the mm size ggplot2 expects", {
  expect_equal(ipea_label_size(6), 6 / 2.845276)
  expect_equal(ipea_label_size(7), 7 / 2.845276)
})

test_that("ipea_label_size() defaults to 6pt", {
  expect_equal(ipea_label_size(), ipea_label_size(6))
})

test_that("ipea_label_size() rejects negative sizes", {
  expect_error(ipea_label_size(-1))
})

test_that("ipea_label_size() accepts zero", {
  expect_equal(ipea_label_size(0), 0)
})
