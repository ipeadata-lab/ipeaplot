#' Theme for IPEA graphics
#'
#' This function defines a custom theme for IPEA graphics, which provides standardized formatting
#' options for axis lines, text, legends, and panel borders.
#'
#' @param axis A character vector specifying the axis style. Valid options are "none" (no axis lines),
#'   "half" (half-length axis lines), and "full" (full-length axis lines).
#' @param box_option An integer indicating the box style. Use 1 for a dark background with white text
#'   (default), and any other value for a white background with black text.
#' @param text Logical value indicating whether to show text elements. If TRUE, axis text and ticks
#'   will be displayed in black; otherwise, they will be hidden.
#' @param legend.position A character vector specifying the position of the legend. Valid options are
#'   "right" (default), "left", "top", and "bottom".
#' @param ... Additional arguments to be passed to the `theme` function from the `ggplot2` package.
#'
#' @return A custom theme for IPEA graphics.
#' @import ggplot2
#' @export

theme_ipea <- function(...){

  list(scale_ipea(...),
       insert_text(...),
       ipea_style(...))

}


