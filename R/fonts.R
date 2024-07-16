#' Imports necessary fonts to produce the charts
#'
#' @import extrafont systemfonts
#' @noRd

.onLoad <- function(libname, pkgname) {

  font_dir <- systemfonts::system_fonts()
  cond <- grepl("roboto", font_dir$name, ignore.case = TRUE)
  font_dir <- font_dir[cond, ]
  font_dir <- unique(dirname(font_dir$path))

  if(length(font_dir) > 0){
    suppressMessages(extrafont::font_import(font_dir,
                                            pattern = "(?i)roboto",
                                            prompt = FALSE
    ))
    suppressMessages(extrafont::loadfonts())

    suppressMessages(extrafont::loadfonts(device = "pdf"))
    suppressMessages(extrafont::loadfonts(device = "postscript"))


  }
}

.onAttach <- function(libname, pkgname) {
  roboto_fonts <- c("RobotoCondensed-Light","Roboto-Regular")

  sys_fonts <- systemfonts::system_fonts()
  missing_fonts <- roboto_fonts[!(roboto_fonts %in% sys_fonts$name)]

  if (length(missing_fonts) > 0) {
    packageStartupMessage("The following Roboto fonts are missing, please install them: ", paste(missing_fonts, collapse = ", "))
  } else {
    packageStartupMessage("All Roboto fonts are installed.")
  }
}
