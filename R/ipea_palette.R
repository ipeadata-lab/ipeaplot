#' Ipea Color Palette and Scales
#'
#' A 9-color Ipea palette.
#'
#' @description This function creates a vector of n equally spaced colors
#'               along the selected color map.
#'
#' @param n The number of colors (\eqn{\ge 1}) used in the palette.
#' @param alpha The alpha transparency in a number between `0` and `1`.
#' @param begin The (corrected) hue in a number between `0` and `1` at which the
#'        color map begins.
#' @param end The (corrected) hue in a number between `0` and `1` at which the
#'        color map ends.
#' @param palette_direction Sets the order of colors in the scale. If `1`, the default,
#'        colors are ordered from darkest to lightest. If `-1`, the order of
#'        colors is reversed.
#' @param palette A character string indicating the color map option to use.
#' These options are available:'Blue', 'Green', 'Orange', 'Pink', 'Red-Blue'
#' 'Orange-Blue', 'Green-Blue', 'Red-Blue-White', 'Orange-Blue-White',
#' 'Green-Blue-White', 'Viridis', 'Inferno', 'Magma', 'Plasma', 'Cividis'.
#'
#' @references
#' 'Blue','Green','Orange','Pink','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
#' 'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno',
#' 'Magma','Plasma' and 'Cividis': https://pmassicotte.github.io/paletteer_gallery/
#'
#' @return \code{ipea_palette} produces a character vector, \code{cv}, containing color hex codes.
#' This vector can be utilized to establish a custom color scheme for future graphics using \code{palette(cv)},
#' or it can be applied directly as a \code{col =} parameter in graphic functions or within \code{par}.
#'
ipea_palette <- function(palette = c('Blue','Green','Orange','Pink','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
                                     'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno','Magma','Plasma','Cividis'),
                         n,
                         alpha = 1,
                         begin = 0,
                         end = 1,
                         palette_direction = 1) {

  palette <-  ifelse(missing(palette),'Blue',palette)

   if (begin < 0 | begin > 1 | end < 0 | end > 1) {
     stop("begin and end must be in a number between `0` and `1`")
   }

   if (abs(palette_direction) != 1) {
     stop("palette_direction must be 1 or -1")
   }

   if (n == 0) {
     return(character(0))
   }

   if (palette_direction == -1) {
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
    colours <- paletteer::paletteer_c("ggthemes::Red-Blue Diverging", n)
  } else if (palette ==  "Green-Blue") {
    # Set colours to the Green-Blue palette using manual_pal function
    colours <- paletteer::paletteer_c("ggthemes::Green-Blue Diverging", n)
  } else if (palette ==  "Orange-Blue") {
    # Set colours to the Orange-Blue palette using manual_pal function
    colours <- paletteer::paletteer_c("ggthemes::Orange-Blue Diverging", n)
  } else if (palette ==  "Red-Blue-White") {
    # Set colours to the Red-Blue palette using manual_pal function
    colours <- paletteer::paletteer_c("ggthemes::Red-Blue-White Diverging", n)
  } else if (palette ==  "Green-Blue-White") {
    # Set colours to the Green-Blue palette using manual_pal function
    colours <- paletteer::paletteer_c("ggthemes::Green-Blue-White Diverging", n)
  } else if (palette ==  "Orange-Blue-White") {
    # Set colours to the Orange-Blue palette using manual_pal function
    colours <- paletteer::paletteer_c("ggthemes::Orange-Blue-White Diverging", n)
  } else if (palette ==  "Viridis") {
    # Set colours to the Viridis palette using manual_pal function
    colours <- paletteer::paletteer_c("viridis::viridis", n)
  } else if (palette ==  "Inferno") {
    # Set colours to the Inferno palette using manual_pal function
    colours <- paletteer::paletteer_c("viridis::inferno", n)
  } else if (palette ==  "Magma") {
    # Set colours to the Magma palette using manual_pal function
    colours <- paletteer::paletteer_c("viridis::magma", n)
  } else if (palette ==  "Plasma") {
    # Set colours to the Plasma palette using manual_pal function
    colours <- paletteer::paletteer_c("viridis::plasma", n)
  } else if (palette ==  "Cividis") {
    # Set colours to the Cividis palette using manual_pal function
    colours <- paletteer::paletteer_c("viridis::cividis", n)
  } else {
    # Stop the execution and display an error message if palettes is none of the specified values
    stop("Palette palettes must be 'Blue','Green','Orange','Pink','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
                                   'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno','Magma','Plasma','Cividis'")
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
#' @param alpha	The alpha transparency in a number between `0` and `1`.
#' @param begin The (corrected) hue in a number between `0` and `1` at which the color map begins.
#' @param end The (corrected) hue in a number between `0` and `1` at which the color map ends.
#' @param palette_direction Sets the order of colors in the scale. If 1, the default,
#'        colors are ordered from darkest to lightest. If -1, the order of
#'        colors is reversed.
#' @param palette A character string indicating the color map option to use.
#'  These options are available: 'Blue', 'Green', 'Orange', 'Pink', 'Red-Blue'
#'  'Orange-Blue', 'Green-Blue', 'Viridis', 'Inferno', 'Magma', 'Plasma'
#'  'Cividis'.
#' @references
#'  'Blue','Green','Orange','Pink','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
#'  'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno',
#'  'Magma','Plasma' and 'Cividis': https://pmassicotte.github.io/paletteer_gallery/
#'
#' @return \code{ipea_palette} produces a character vector, \code{cv}, containing color hex codes.
#' This vector can be utilized to establish a custom color scheme for future graphics using \code{palette(cv)},
#' or it can be applied directly as a \code{col =} parameter in graphic functions or within \code{par}.
#'
#' @export
#' @examples
#' scales::show_col(ipea_pal()(10))
#' scales::show_col(ipea_pal(palette_direction = -1)(6))
#' scales::show_col(ipea_pal(begin = 0.2, end = 0.8)(4))
#' scales::show_col(ipea_pal(palette = "Green")(6))

ipea_pal <- function(palette = c('Blue','Green','Orange','Pink','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
                                 'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno','Magma','Plasma','Cividis'),
                     alpha = 1, begin = 0, end = 1, palette_direction = 1) {
   force_all(palette, alpha, begin, end, palette_direction)
   function(n) {
     ipea_palette(palette, n, alpha, begin, end, palette_direction)
   }
}




