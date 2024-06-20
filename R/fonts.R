#' Imports necessary fonts to produce the charts
#'
#' @import extrafont
#' @noRd

.onLoad <- function(libname, pkgname) {

  path <- system.file("extdata/", package = "ipeaplot")

  suppressMessages({sysfonts::font_add("Roboto-Black", regular = paste0(path,"/ttf/Roboto-Black.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-BlackItalic", regular = paste0(path,"/ttf/Roboto-BlackItalic.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-Bold", regular = paste0(path,"/ttf/Roboto-Bold.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-BoldItalic", regular = paste0(path,"/ttf/Roboto-BoldItalic.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-CondensedBold", regular = paste0(path,"/ttf/Roboto-CondensedBold.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-CondensedBoldItalic", regular = paste0(path,"/ttf/Roboto-CondensedBoldItalic.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-CondensedItalic", regular = paste0(path,"/ttf/Roboto-CondensedItalic.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-CondensedLight", regular = paste0(path,"/ttf/Roboto-CondensedLight.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-CondensedLightItalic", regular = paste0(path,"/ttf/Roboto-CondensedLightItalic.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-CondensedRegular", regular = paste0(path,"/ttf/Roboto-CondensedRegular.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-Italic", regular = paste0(path,"/ttf/Roboto-Italic.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-Light", regular = paste0(path,"/ttf/Roboto-Light.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-LightItalic", regular = paste0(path,"/ttf/Roboto-LightItalic.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-Medium", regular = paste0(path,"/ttf/Roboto-Medium.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-MediumItalic", regular = paste0(path,"/ttf/Roboto-MediumItalic.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-Regular", regular = paste0(path,"/ttf/Roboto-Regular.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-Thin", regular = paste0(path,"/ttf/Roboto-Thin.ttf"))})
  suppressMessages({sysfonts::font_add("Roboto-ThinItalic", regular = paste0(path,"/ttf/Roboto-ThinItalic.ttf"))})
  suppressMessages({showtext::showtext_auto()})
  suppressMessages({extrafont::font_import(paths = paste0(path,'/ttf/'), prompt = F)})
  extrafont::loadfonts(quiet = TRUE)
}


