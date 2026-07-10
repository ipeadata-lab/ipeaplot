#' @title Contrasting text colour for labels drawn over a fill colour
#'
#' @description Given one or more fill/background colours, returns `"white"`
#' or `"black"`, whichever gives better contrast against that background.
#' Useful for value labels drawn inside bars or over points/lines, matching
#' the Ipea editorial guidelines for graphics, which alternate the colour of
#' data labels according to how dark the colour behind them is. See
#' <https://www.ipea.gov.br/manualeditorial/padroes/padroes-grafico-visuais/ilustracoes-pi.html>.
#'
#' @param background A character vector of colours (hex codes or R colour
#'        names) used as the fill/background behind the label.
#'
#' @return A character vector the same length as `background`, containing
#'         `"white"` or `"black"`.
#' @export
#' @family ggplot2 theme functions
#'
#' @examples
#' ipea_contrast_color(c("#29112F", "#D2A0C9"))
#'
#' library(ggplot2)
#' df <- data.frame(grupo = c("A", "B"), valor = c(22.6, 4.7),
#'                   cor = c("#29112F", "#D2A0C9"))
#' ggplot(df, aes(grupo, valor, fill = cor, label = valor)) +
#'   geom_col() +
#'   geom_text(aes(color = ipea_contrast_color(cor)), size = ipea_label_size(),
#'             fontface = "bold") +
#'   scale_fill_identity() +
#'   scale_color_identity() +
#'   theme_ipea()
ipea_contrast_color <- function(background) {
  # unname() evita que os rownames "red"/"green"/"blue" de col2rgb() vazem
  # como names() do vetor de saida (acontece via apply() quando length(background) == 1).
  rgb_mat <- unname(grDevices::col2rgb(background) / 255)

  # Luminancia relativa (WCAG): converte cada canal sRGB para linear antes de
  # ponderar pela sensibilidade do olho humano a cada cor.
  linear_channel <- function(ch) ifelse(ch <= 0.03928, ch / 12.92, ((ch + 0.055) / 1.055)^2.4)
  linear_rgb <- apply(rgb_mat, 2, linear_channel)
  luminance <- 0.2126 * linear_rgb[1, ] + 0.7152 * linear_rgb[2, ] + 0.0722 * linear_rgb[3, ]

  # 0.179 e o limiar em que o contraste com texto preto e branco se equivale.
  ifelse(luminance > 0.179, "black", "white")
}
