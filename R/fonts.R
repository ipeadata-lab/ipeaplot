#' Imports necessary fonts to produce the charts
#'
#' @import extrafont
#' @noRd

.onLoad <- function(libname, pkgname) {

  path <- system.file("extdata/", package = "ipeaplot")

  suppressMessages({sysfonts::font_add("RobotoCondensed-Light", regular = paste0(path,"/ttf/RobotoCondensed-Light.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-Regular", regular = paste0(path,"/ttf/Roboto-Regular.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-Medium", regular = paste0(path,"/ttf/Roboto-Medium.ttf"))})
  suppressMessages({sysfonts::font_add("RobotoCondensed-Bold", regular = paste0(path,"/ttf/RobotoCondensed-Bold.ttf"))})
  #suppressMessages({showtext::showtext_auto()})
  suppressMessages({extrafont::font_import(paths = paste0(path,'/ttf/'), prompt = F)})
  extrafont::loadfonts(quiet = TRUE)
}

