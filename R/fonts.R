#' Imports necessary fonts to produce the charts
#'
#' @import extrafont
#' @noRd

.onLoad <- function(libname, pkgname) {
  # path = file.path(getwd(), "inst")
  path <- system.file("extdata/tff", package = "ipeaplot")
  path <- ifelse(dir.exists(path), path, find.package("ipeaplot"))
  #packageStartupMessage(path)

  extrafont::font_import(path, prompt = F)
  extrafont::loadfonts("win")

  suppressMessages(extrafont::font_import(path, prompt = F))
  suppressMessages(extrafont::loadfonts("win"))



}
