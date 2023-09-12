#' Imports necessary fonts to produce the charts
#'
#' @import extrafont
#' @noRd

.onLoad <- function(libname, pkgname) {
#   # path = file.path(getwd(), "inst")
  path <- system.file("extdata/", package = "ipeaplot")
  # path <- ifelse(dir.exists(path), path, find.package("ipeaplot"))
  #packageStartupMessage(path)

  suppressMessages({sysfonts::font_add("Frutiger-LT-47-LightCn", regular = paste0(path,"/ttf/Frutiger-LT-47-Light-Condensed.ttf"))})
  suppressMessages({sysfonts::font_add("Frutiger-LT-Std", regular = paste0(path,"/ttf/Frutiger-LT-57-Light-Condensed.ttf"))})
  suppressMessages({sysfonts::font_add("Frutiger-LT-55-Roman", regular = paste0(path,"/ttf/Frutiger-LT-55-Roman.ttf"))})
  suppressMessages({sysfonts::font_add("Frutiger-LT-67-Bold-Condensed", regular = paste0(path,"/ttf/Frutiger-LT-67-Bold-Condensed.ttf"))})
  suppressMessages({showtext::showtext_auto()})
  suppressMessages({extrafont::font_import(paths = paste0(path,'/ttf/'), prompt = F)})
  extrafont::loadfonts(quiet = TRUE)
}
