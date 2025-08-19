#' Save the chart in PNG format
#'
#' @param gplot ggplot object.
#' @param file.name Caminho/nome do arquivo (com ou sem .png).
#' @param width,height,units Tamanho (padrão: 160x100 mm).
#' @param dpi Resolução (padrão: 300).
#' @param background Cor de fundo; para PNG com transparência use NA.
#' @param ... repassado a ggplot2::ggsave()
#' @return caminho do arquivo (invisível)
#' @export
save_png <- function(gplot,
                     file.name,
                     width = 160, height = 100, units = c("mm","cm","in")[1],
                     dpi = 300,
                     background = "white",
                     ...) {
  if (!inherits(gplot, "ggplot")) stop("gplot deve ser um gráfico 'ggplot2'.")
  if (!is.character(file.name) || length(file.name) != 1L) {
    stop("file.name deve ser uma string de comprimento 1.")
  }
  if (!grepl("\\.png$", file.name, ignore.case = TRUE)) {
    file.name <- paste0(gsub("\\.[^.]+$", "", file.name), ".png")
  }
  dev <- if (requireNamespace("ragg", quietly = TRUE)) ragg::agg_png else "png"

  ggplot2::ggsave(
    filename   = file.name,
    plot       = gplot,
    device     = dev,
    width      = width,
    height     = height,
    units      = units,
    dpi        = dpi,
    bg         = background,
    ...
  )
}

