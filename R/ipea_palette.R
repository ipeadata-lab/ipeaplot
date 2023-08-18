#' Ipea Color Palette and Scales
#'
#' A 9-color Ipea palette.
#'
#' @description This function creates a vector of n equally spaced colors
#'               along the selected color map.
#'
#' @param n The number of colors (\eqn{\ge 1}) to be in the palette.
#' @param alpha	The alpha transparency, a number in [0,1]
#' @param begin The (corrected) hue in [0,1] at which the color map begins.
#' @param end The (corrected) hue in [0,1] at which the color map ends.
#' @param direction Sets the order of colors in the scale. If 1, the default,
#'        colors are ordered from darkest to lightest. If -1, the order of
#'        colors is reversed.
#' @param option A character string indicating the color map option to use.
#'  Eight options are available:
#'  \itemize{
#'  \item{}{'Blue'}
#'  \item{}{'Green'}
#'  \item{}{'Orange'}
#'  \item{}{'Pink'}
#'  \item{}{'Red-Blue'}
#'  \item{}{'Orange-Blue}
#'  }
#'
ipea_palette <- function(n, alpha = 1, begin = 0, end = 1,
                     direction = 1, palette = c('Blue','Green','Orange','Pink',
                                               'Red-Blue','Orange-Blue')) {

  palette <-  ifelse(missing(palette),'Blue',palette)

   if (begin < 0 | begin > 1 | end < 0 | end > 1) {
     stop("begin and end must be in [0,1]")
   }

   if (abs(direction) != 1) {
     stop("direction must be 1 or -1")
   }

   if (n == 0) {
     return(character(0))
   }

   if (direction == -1) {
     tmp <- begin
     begin <- end
     end <- tmp
   }

   if (palette ==  "Blue") {
     # Set colours to the Blue palette using manual_pal function
     colours <- paletteer::paletteer_c("ggthemes::Blue", n)
   } else if (palette ==  "Green") {
     # Set colours to the Green palette using manual_pal function
     colours <-  paletteer::paletteer_c("ggthemes::Green", n)
   } else if (palette ==  "Orange") {
     # Set colours to the Orange palette using manual_pal function
     colours <- paletteer::paletteer_c("ggthemes::Orange", n)
   } else if (palette ==  "Pink") {
     # Set colours to the Pink palette using manual_pal function
     colours <- paletteer::paletteer_c("ggthemes::Pink", n)
   } else if (palette ==  "Red-Blue") {
     # Set colours to the Red-Blue palette using manual_pal function
     colours <- paletteer::paletteer_c("ggthemes::Red-Blue-White Diverging", n)
   }  else if (palette ==  "Orange-Blue") {
     # Set colours to the Orange-Blue palette using manual_pal function
     colours <- paletteer::paletteer_c("ggthemes::Orange-Blue-White Diverging", n)
   }   else {
     # Stop the execution and display an error message if palettes is none of the specified values
     stop("Palette palettes must be 'Blue','Green','Orange','Pink','Green-Blue','Red-Blue' or 'Orange-Blue'")
   }

   map_cols <- as.character(colours)
   map_cols <- paste0(substr(map_cols,1,6),"F")
   fn_cols <- grDevices::colorRamp(map_cols, space = "Lab", interpolate = "spline")
   cols <- fn_cols(seq(begin, end, length.out = n)) / 255
   grDevices::rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha)
}

# Evaluates all arguments (see #81)
force_all <- function(...) list(...)

#' Ipea palette
#'
#' @param n The number of colors (\eqn{\ge 1}) to be in the palette.
#' @param alpha	The alpha transparency, a number in [0,1]
#' @param begin The (corrected) hue in [0,1] at which the color map begins.
#' @param end The (corrected) hue in [0,1] at which the color map ends.
#' @param direction Sets the order of colors in the scale. If 1, the default,
#'        colors are ordered from darkest to lightest. If -1, the order of
#'        colors is reversed.
#' @param option A character string indicating the color map option to use.
#' @references
#' @export
#' @examples
#' scales::show_col(ipea_pal()(10))
#' scales::show_col(ipea_pal(direction = -1)(6))
#' scales::show_col(ipea_pal(begin = 0.2, end = 0.8)(4))
#' scales::show_col(ipea_pal(palette = "Green")(6))

ipea_pal <- function(alpha = 1, begin = 0, end = 1, direction = 1,
                    palette = c('Blue','Green','Orange','Pink',
                                'Red-Blue','Orange-Blue')) {
   force_all(alpha, begin, end, direction, palette)
   function(n) {
     ipea_palette(n, alpha, begin, end, direction, palette)
   }
}




