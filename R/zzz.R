#' Imports necessary fonts to produce the charts.
#'
#' @import extrafont
#' @noRd

.onLoad <- function(libname, pkgname) {
  path = file.path(getwd(), "inst")
  path = ifelse(dir.exists(path), path, find.package("templatesIpea"))
  #packageStartupMessage(path)

  font_import(path, prompt = F)
  loadfonts("win")

  suppressMessages(font_import(path, prompt = F))
  suppressMessages(loadfonts("win"))



}
