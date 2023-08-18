#' ipeaplot: ggplot Graphics in Ipea Standard
#'
#' Convenient functions to create ggplot graphics following the editorial
#' guidelines of the  Institute for Applied Economic Research - Ipea.
#'
#' @section Usage:
#' Please check the vignettes and data documentation on the
#' [website](https://github.com/ipeadata-lab/ipeaplot).
#'
#' @docType package
#' @name ipeaplot
#' @aliases ipeaplot-package
#'
#' @importFrom grDevices postscript dev.off
"_PACKAGE"


## quiets concerns of R CMD check re: the .'s that appear in pipelines
utils::globalVariables( c('postscript',
                          'dev.off'
                          ) )

