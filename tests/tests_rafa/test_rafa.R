library(ipeaplot)
library(ggplot2)

data(mtcars)

# escala continua default do ggplot
ggplot() +
  geom_point(data = mtcars, aes(x = hp, y = mpg, color = mpg)) +
  ipeaplot::theme_ipea(x_text_angle = 45)
  #ipeaplot::theme_ipea(angle = 45)



ggplot() +
  geom_col(data = mtcars, aes(x = hp, y = mpg, color = mpg)) +
  ipeaplot::theme_ipea(axis_values = F)
 # ipeaplot::theme_ipea(text = T)


# escala continua do ipeaplot
ggplot() +
  geom_point(data = mtcars, aes(x = hp, y = mpg, color = mpg)) +
  ipeaplot::scale_color_ipea(discrete = F) +
  ipeaplot::theme_ipea()




##### Coverage ------------------------
library(covr)
library(testthat)
Sys.setenv(NOT_CRAN = "true")


# each function separately
a <- covr::function_coverage(fun=r5r::travel_time_matrix, test_file("tests/testthat/test-travel_time_matrix.R"))


# the whole package
Sys.setenv(NOT_CRAN = "true")
ipeaplot_cov <- covr::package_coverage(path = ".", type = "tests")
ipeaplot_cov

covr::report()








# checks spelling
library(spelling)
devtools::spell_check(pkg = ".", vignettes = TRUE, use_wordlist = TRUE, )

# Update documentation
devtools::document(pkg = ".")




# find unicode errors
tools::showNonASCIIfile(file = './man/accessibility.Rd')


functions <- list.files(path = './R', all.files = T, recursive = T, full.names = T)
lapply(X=functions, FUN = tools::showNonASCIIfile)

docs <- list.files(path = './man', all.files = T, recursive = T, full.names = T)
lapply(X=docs, FUN = tools::showNonASCIIfile)


### CMD Check ----------------
# Check package errors
library(tictoc)
library(beepr)

devtools::document()

# LOCAL
tictoc::tic()
Sys.setenv(NOT_CRAN = "true")
devtools::check(pkg = ".",  cran = FALSE, env_vars = c(NOT_CRAN = "true"))
tictoc::toc()
beepr::beep()


# CRAN
tictoc::tic()
Sys.setenv(NOT_CRAN = "false")
devtools::check(pkg = ".",  cran = TRUE, env_vars = c(NOT_CRAN = "false"))
tictoc::toc()


devtools::check_win_release(pkg = ".")

# devtools::check_win_oldrelease()
# devtools::check_win_devel()


beepr::beep()



tictoc::tic()
devtools::check(pkg = ".",  cran = TRUE, env_vars = c(NOT_CRAN = "false"))
tictoc::toc()



# submit to CRAN -----------------
usethis::use_cran_comments('teste 2222, , asdadsad')

urlchecker::url_check()
devtools::check(remote = TRUE, manual = TRUE)
devtools::check_win_release()
devtools::check_mac_release()
rhub::check_for_cran(show_status = FALSE)


devtools::submit_cran()



### pkgdown: update website ----------------

# Run to build the website
pkgdown::build_site()




