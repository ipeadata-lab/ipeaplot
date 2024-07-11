#' Imports necessary fonts to produce the charts
#'
#' @import extrafont
#' @noRd

.onLoad <- function(libname, pkgname) {

  path <- system.file("extdata/", package = "ipeaplot")
  suppressMessages({extrafont::font_import(paths = paste0(path,'/ttf/'), prompt = F)})
  #suppressMessages({extrafont::font_import(pattern="Roboto-",prompt = FALSE)})
  suppressMessages({extrafont::loadfonts(quiet = TRUE)})
}

.onAttach <- function(libname, pkgname) {
  roboto_fonts <- c("RobotoCondensed-Light")

  sys_fonts <- systemfonts::system_fonts()
  missing_fonts <- roboto_fonts[!(roboto_fonts %in% sys_fonts$name)]

  if (length(missing_fonts) > 0) {
    packageStartupMessage("The following Roboto fonts are missing, please install them: ", paste(missing_fonts, collapse = ", "))
  } else {
    packageStartupMessage("All Roboto fonts are installed.")
  }
}
