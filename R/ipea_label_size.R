#' @title Font size for data labels in Ipea graphics
#'
#' @description Converts a font size in points (pt) into the `size`
#' argument/aesthetic (in mm) expected by `ggplot2::geom_text()`,
#' `ggplot2::geom_label()` and similar geoms. `ggplot2` specifies text size
#' for geoms in mm and internally converts it to points by multiplying by
#' `2.845276` (`72.27/25.4`); this helper performs the inverse conversion so
#' that labels are rendered at an exact point size.
#'
#' @param pt Numeric. Desired font size in points. Defaults to `6`, the size
#'        used by the editorial guidelines of the Institute for Applied
#'        Economic Research (Ipea) for labels drawn over data (e.g. values on
#'        bars or lines). See
#'        <https://www.ipea.gov.br/manualeditorial/padroes/padroes-grafico-visuais/ilustracoes-pi.html>.
#'
#' @return A numeric value (in mm) to be passed to the `size`
#'         argument/aesthetic of `ggplot2::geom_text()`, `ggplot2::geom_label()`
#'         or similar geoms.
#' @export
#' @family ggplot2 theme functions
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars[1:5, ], aes(hp, mpg, label = round(mpg))) +
#'   geom_text(size = ipea_label_size(), colour = "black") +
#'   theme_ipea()
ipea_label_size <- function(pt = 6) {
  checkmate::assert_number(pt, lower = 0)
  pt / 2.845276
}
