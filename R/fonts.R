#' Imports necessary fonts to produce the charts
#'
#' @import extrafont
#' @noRd

.onLoad <- function(libname, pkgname) {

  suppressMessages({sysfonts::font_add_google("Roboto", "Roboto")})
  suppressMessages({sysfonts::font_add_google("Roboto Condensed", "Roboto Condensed")})

  # Correspondência das fontes Frutiger para Roboto
  # suppressMessages({sysfonts::font_add("Frutiger-LT-47-LightCn", regular = "Roboto Condensed")})
  # suppressMessages({sysfonts::font_add("Frutiger-LT-Std", regular = "Roboto")})
  # suppressMessages({sysfonts::font_add("Frutiger-LT-55-Roman", regular = "Roboto")})
  # suppressMessages({sysfonts::font_add("Frutiger-LT-67-Bold-Condensed", regular = "Roboto Condensed")})

  #suppressMessages({showtext::showtext_auto()})
}


