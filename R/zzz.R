#' Imports necessary fonts to produce the charts.
#'
#' @import extrafont
#' @noRd

.onLoad <- function(libname, pkgname) {
  path = file.path(getwd(), "inst")
  path = ifelse(dir.exists(path), path, find.package("templatesIpea"))
  #packageStartupMessage(path)
  extrafont::font_import(path, prompt = F)
  extrafont::loadfonts("win")


}
