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
  sysfonts::font_add("Frutiger-LT-47-LightCn", regular = paste0(path,"/ttf/Frutiger-LT-47-Light-Condensed.ttf"))
  sysfonts::font_add("Frutiger-LT-Std", regular = paste0(path,"/ttf/Frutiger-LT-57-Light-Condensed.ttf"))
  sysfonts::font_add("Frutiger-LT-55-Roman", regular = paste0(path,"/ttf/Frutiger-LT-55-Roman.ttf"))
  showtext::showtext_auto()

  suppressMessages(extrafont::font_import(path, prompt = F))
  suppressMessages(extrafont::loadfonts("win"))



}
