#' Save the chart in JPG/JPEG format
#'
#' @param gplot ggplot object.
#' @param file.name Caminho/nome do arquivo (com ou sem .jpg/.jpeg).
#' @param width,height,units Tamanho (padrão: 160x100 mm).
#' @param dpi Resolução (padrão: 300).
#' @param quality Qualidade (0–100) se usar ragg::agg_jpeg.
#' @param background Cor de fundo (JPG não suporta transparência).
#' @param ... repassado a ggplot2::ggsave()
#' @return caminho do arquivo (invisível)
#' @export
save_jpg <- function(gplot,
                     file.name,
                     width = 160, height = 100, units = c("mm","cm","in")[1],
                     dpi = 300,
                     quality = 90,
                     background = "white",
                     ...) {
  if (!inherits(gplot, "ggplot")) stop("gplot deve ser um gráfico 'ggplot2'.")
  if (!is.character(file.name) || length(file.name) != 1L) {
    stop("file.name deve ser uma string de comprimento 1.")
  }
  # aceitar .jpg ou .jpeg; se não tiver, forçar .jpg
  if (!grepl("\\.(jpe?g)$", file.name, ignore.case = TRUE)) {
    file.name <- paste0(gsub("\\.[^.]+$", "", file.name), ".jpg")
  }

  if (requireNamespace("ragg", quietly = TRUE)) {
    dev <- function(...) ragg::agg_jpeg(..., quality = quality)
  } else {
    dev <- "jpeg"
  }

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

