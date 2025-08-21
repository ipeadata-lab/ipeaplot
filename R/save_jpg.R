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
save_jpg <- function(gplot, file.name, ...) {
  if(!inherits(gplot,"ggplot")) stop("gplot deve ser um gráfico ggplot")
  if(!is.character(file.name)) stop("O nome do arquivo deve ser uma string")

  if(!grepl("\\.(jpe?g)$", file.name, ignore.case = TRUE)){
    file.name <- paste0(gsub("\\.[^.]+$", "", file.name), ".jpg")
    warning("O formato do arquivo deve ser '.jpg' ou '.jpeg'")
  }

  ggplot2::ggsave(plot = gplot, filename = file.name, device = "jpeg", ...)
}
