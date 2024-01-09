#' Ggplot theme for Ipea charts and figures
#'
#' @description Applies a custom theme for ggplot figures following the editorial
#' guidelines used by the Institute for Applied Economic Research - Ipea. The
#' function includes standardized formatting of options for axis lines, text,
#'
#' @param axis_lines A character vector specifying the axis style. Valid options are
#'        `"none"` (no axis lines), `"full"` (full-length axis lines), and
#'        `"half"` (half-length axis lines), the default.
#' @param axis_values Logical value indicating whether to show text elements. If `TRUE`,
#'        axis text will be displayed in black; otherwise, they will
#'        be hidden.
#' @param legend.position A character vector specifying the position of the
#'        legend. Valid options are `"right"` (default), `"left"`, `"top"`, and
#'        `"bottom"`.
#' @param grid.adjust Defines whether the grid lines should be `"horizontal"`
#'       (default) or `"vertical"`.
#' @param x_breaks Numeric. The number of breaks on the x-axis
#' @param y_breaks Numeric. The number of breaks on the y-axis
#' @param expand_x_limit Logical value that indicates whether the x-axis
#'        boundary should be expanded. If `TRUE`, the x-axis text will be
#'        expanded; otherwise there will be no change
#' @param x_text_angle Numeric. Angle in degrees of the text in the x-axis.
#' @param include_x_text_title Logical. Whether to include x text title Defaults to `TRUE`.
#' @param include_y_text_title Logical. Whether to include x text title. Defaults to `TRUE`.
#' @param include_ticks Logical. Whether to include ticks. Defaults to `TRUE`.
#' @param ... Additional arguments to be passed to the `theme` function from the
#'        `ggplot2` package.
#'
#' @return A custom theme for IPEA graphics.
#' @import ggplot2
#' @export

theme_ipea <- function(axis_lines = 'full',
                       axis_values = TRUE,
                       legend.position = 'right',
                       grid.adjust = 'horizontal',
                       x_breaks = NULL, y_breaks = NULL,
                       expand_x_limit = TRUE,
                       x_text_angle = 0,
                       include_x_text_title = TRUE,
                       include_y_text_title = TRUE,
                       include_ticks = TRUE,
                       ...){

  hjust <- ifelse(x_text_angle == 0, 0.5, 1)
  vjust <- ifelse(x_text_angle == 0, 0, 0.5)

  checkmate::assert_number(x = x_text_angle)
  checkmate::assert_choice(axis_lines, choices = c('none', 'half', 'full'))
  checkmate::assert_choice(grid.adjust, choices = c('vertical', 'horizontal'))
  checkmate::assert_choice(legend.position, choices = c('right', 'left', 'bottom', 'top', 'none'))

  color <- "gray75"

  # Funções Auxiliares
  axis_line_config <- function(color, axis_lines) {
    if (axis_lines != "none") {
      return(ggplot2::element_line(linewidth = 0.25, linetype = "solid", colour = color))
    } else {
      return(ggplot2::element_blank())
    }
  }

  axis_ticks_config <- function(axis_lines) {
    if (axis_lines == "half" || axis_lines == "full") {
      return(ggplot2::element_line(colour = "black", linewidth = 0.25))
    } else {
      return(ggplot2::element_blank())
    }
  }

  panel_border_config <- function(axis_lines) {
    if (axis_lines == "full") {
      return(ggplot2::element_rect(linewidth = 0.25, colour = "black", fill = NA))
    } else {
      return(ggplot2::element_blank())
    }
  }

  # Configuração de Eixos e Bordas
  axis.line.x <- axis_line_config("black", axis_lines)
  axis.line.y <- axis_line_config("black", axis_lines)
  axis.ticks.x <- axis_ticks_config(axis_lines)
  axis.ticks.y <- axis_ticks_config(axis_lines)
  panel.border <- panel_border_config(axis_lines)

  # Configuração de Texto e Legenda
  axis.text.x <- if (axis_values) {
    ggplot2::element_text(family = "Frutiger-LT-47-LightCn", angle = x_text_angle, hjust = hjust, vjust = vjust)
  } else {
    ggplot2::element_blank()
  }

  axis.text.y <- if (axis_values) {
    ggplot2::element_text()
  } else {
    ggplot2::element_blank()
  }

  axis.title.x <- if (include_x_text_title) {
    ggplot2::element_text(family = "Frutiger-LT-47-LightCn", margin = margin(t = 4, r = 0, b = 0, l = 0, unit = 'mm'))
  } else {
    ggplot2::element_blank()
  }

  axis.title.y <- if (include_y_text_title) {
    ggplot2::element_text(family = "Frutiger-LT-47-LightCn", margin = margin(t = 0, r = 4, b = 0, l = 0, unit = 'mm'))
  } else {
    ggplot2::element_blank()
  }

  if (!include_ticks) {
    axis.ticks.x <- ggplot2::element_blank()
    axis.ticks.y <- ggplot2::element_blank()
  }

  # Composição do tema final
  theme <- ggplot2::theme(
    text = ggplot2::element_text(family = "Frutiger-LT-55-Roman"),
    panel.background = ggplot2::element_rect(fill = "white", colour = NA),
    panel.border = panel.border,
    panel.grid.major.x = ifelse(grid.adjust == 'horizontal', ggplot2::element_blank(), ggplot2::element_line(colour = color, linewidth = 0.25)),
    panel.grid.major.y = ifelse(grid.adjust == 'vertical', ggplot2::element_blank(), ggplot2::element_line(colour = color, linewidth = 0.25)),
    legend.position = legend.position,
    axis.line.x = axis.line.x,
    axis.line.y = axis.line.y,
    axis.text.x = axis.text.x,
    axis.text.y = axis.text.y,
    axis.title.x = axis.title.x,
    axis.title.y = axis.title.y,
    axis.ticks.x = axis.ticks.x,
    axis.ticks.y = axis.ticks.y,
    # Outras configurações conforme necessário...
    ...
  )

  # Escalas e limites
  scale_y <- if (is.null(y_breaks)) {
    scale_y_continuous(expand = c(0, 0), labels = scales::label_comma(decimal.mark = ",", big.mark = "."))
  } else {
    scale_y_continuous(expand = c(0, 0), labels = scales::label_comma(decimal.mark = ",", big.mark = "."), breaks = scales::pretty_breaks(n = y_breaks))
  }

  scale_x <- if (is.null(x_breaks)) {
    NULL
  } else {
    scale_x_continuous(expand = expansion(mult = c(0, ifelse(expand_x_limit, 0.03, 0))), labels = scales::label_comma(decimal.mark = ",", big.mark = ""), breaks = scales::pretty_breaks(n = x_breaks))
  }

  # Retorno da lista com tema e escalas
  list(theme, scale_x, scale_y)
}
