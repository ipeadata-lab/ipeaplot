# Samples `n` colours, evenly spaced, along a Lab-space spline through `anchors`.
# Used to build the fixed 6-shade families behind the 'NT-Categorical' and
# 'TD-Categorical' qualitative palettes.
ipea_lab_ramp <- function(anchors, n) {
  fn <- grDevices::colorRamp(anchors, space = "Lab", interpolate = "spline")
  cols <- fn(seq(0, 1, length.out = n)) / 255
  toupper(grDevices::rgb(cols[, 1], cols[, 2], cols[, 3]))
}

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
#' These options are available:'Blue', 'Green', 'Orange', 'Pink', 'Pink-Deep', 'Red-Blue'
#' 'Orange-Blue', 'Green-Blue', 'Red-Blue-White', 'Orange-Blue-White',
#' 'Green-Blue-White', 'Viridis', 'Inferno', 'Magma', 'Plasma', 'Cividis',
#' 'NT', 'NT-Categorical', 'TD', 'TD-Categorical'.
#'
#' @references
#' 'Blue','Green','Orange','Pink','Pink-Deep','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
#' 'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno',
#' 'Magma','Plasma' and 'Cividis': https://pmassicotte.github.io/paletteer_gallery/
#' 'NT' and 'TD' are sequential palettes taken from the cover, section-title and
#' chart colours of two Ipea editorial series (Nota Tecnica and Texto para
#' Discussao, respectively). 'NT-Categorical' and 'TD-Categorical' are qualitative
#' 12-colour sets built from the same two publications, interleaving 6 shades of
#' each of their two hues so that adjacent categories stay visually distinct.
#' `scale_color_ipea()`/`scale_fill_ipea()` switch automatically from 'NT'/'TD'
#' to their '-Categorical' variant when the mapped variable is discrete, so most
#' users never need to type the '-Categorical' suffix themselves.
#'
#' @return \code{ipea_palette} produces a character vector, \code{cv}, containing color hex codes.
#' This vector can be utilized to establish a custom color scheme for future graphics using \code{palette(cv)},
#' or it can be applied directly as a \code{col =} parameter in graphic functions or within \code{par}.
#'
ipea_palette <- function(palette = c('Blue','Green','Orange','Pink','Pink-Deep','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
                                     'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno','Magma','Plasma','Cividis',
                                     'NT','NT-Categorical','TD','TD-Categorical'),
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
    colours <- paletteer::paletteer_dynamic("cartography::pink.pal", n)
  } else if (palette ==  "Pink-Deep") {
    # Set colours to the Pink-Deep palette using manual_pal function
    colours <- rev(paletteer::paletteer_d("RColorBrewer::RdPu", n)[-(1:2)])
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
  } else if (palette == "NT") {
    # Sequential palette from the Ipea "Nota Tecnica" series: cover background,
    # section-title colour and the "Depois das transferencias" line in Grafico 6
    # of NT_Disoc_120_Pobreza_e_desigualdade_no_Brasil.pdf (dark -> signature -> light).
    colours <- c("#3E0C2C", "#9C2565", "#E8B8D3")
  } else if (palette == "NT-Categorical") {
    # Qualitative set for the "NT" family: 6 magenta shades (as above) interleaved
    # with 6 blue shades (the contrast colour used for "Antes das transferencias"
    # in the same chart), so consecutive categories alternate hue.
    magenta6 <- ipea_lab_ramp(c("#3E0C2C", "#9C2565", "#E8B8D3"), 6)
    blue6    <- ipea_lab_ramp(c("#0B2E5C", "#2571B8", "#B8D9F0"), 6)
    colours  <- rep_len(as.vector(rbind(magenta6, blue6)), n)
  } else if (palette == "TD") {
    # Sequential palette from the Ipea "Texto para Discussao" series: cover
    # background and the "TEXTO para DISCUSSAO" title-bar colour (dark -> signature -> light).
    colours <- c("#0B2E5C", "#2571B8", "#B8D9F0")
  } else if (palette == "TD-Categorical") {
    # Qualitative set for the "TD" family: 6 blue shades (as above) interleaved
    # with 6 grey shades, mirroring the blue/grey pairing used across the six
    # series of Grafico 1 (p. 22) of TD_3203_Web.pdf.
    blue6 <- ipea_lab_ramp(c("#0B2E5C", "#2571B8", "#B8D9F0"), 6)
    grey6 <- ipea_lab_ramp(c("#333333", "#E0E0E0"), 6)
    colours <- rep_len(as.vector(rbind(blue6, grey6)), n)
  } else {
    # Stop the execution and display an error message if palettes is none of the specified values
    stop("Palette palettes must be 'Blue','Green','Orange','Pink','Pink-Deep','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
                                   'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno','Magma','Plasma','Cividis',
                                   'NT','NT-Categorical','TD','TD-Categorical'")
  }

  map_cols <- as.character(colours)
  # Keep just the opaque "#RRGGBB" part (7 characters): colorRamp() ignores
  # alpha, so any trailing alpha byte (e.g. paletteer's "#RRGGBBAA") is simply
  # dropped rather than overwritten. Using substr(...,1,6) here used to keep
  # only 5 hex digits after "#" and pad a literal "F", which silently forced
  # the low nibble of the blue channel to F in every palette.
  map_cols <- substr(map_cols, 1, 7)
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
#'  These options are available: 'Blue', 'Green', 'Orange', 'Pink', 'Pink-Deep', 'Red-Blue'
#'  'Orange-Blue', 'Green-Blue', 'Viridis', 'Inferno', 'Magma', 'Plasma'
#'  'Cividis', 'NT', 'NT-Categorical', 'TD', 'TD-Categorical'.
#' @references
#'  'Blue','Green','Orange','Pink','Pink-Deep','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
#'  'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno',
#'  'Magma','Plasma' and 'Cividis': https://pmassicotte.github.io/paletteer_gallery/
#'  'NT'/'TD' and their '-Categorical' variants: see `ipea_palette()`.
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
#' scales::show_col(ipea_pal(palette = "NT")(10))
#' scales::show_col(ipea_pal(palette = "TD-Categorical")(12))

ipea_pal <- function(palette = c('Blue','Green','Orange','Pink','Pink-Deep','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
                                 'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno','Magma','Plasma','Cividis',
                                 'NT','NT-Categorical','TD','TD-Categorical'),
                     alpha = 1, begin = 0, end = 1, palette_direction = 1) {
  force_all(palette, alpha, begin, end, palette_direction)
  function(n) {
    ipea_palette(palette, n, alpha, begin, end, palette_direction)
  }
}
