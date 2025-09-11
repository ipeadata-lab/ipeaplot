#' @title Save ggplot in multiple formats
#' @description Função unificada para salvar objetos ggplot em um ou mais formatos.
#'
#' @param gplot ggplot object.
#' @param file.name Base do arquivo (sem extensão). Ex.: "results/figs/meu_grafico".
#' @param format Vetor com um ou mais entre: "eps","jpg","pdf","png".
#'   Se NULL, usa getOption("ipea.plot.default_format", "eps").
#' @param width,height Tamanho do gráfico (default 160 x 100).
#' @param units Unidades: "mm","cm","in" (default "mm").
#' @param dpi DPI para formatos raster (default 300).
#' @param background Cor de fundo; use NA para PNG transparente.
#'                  Para JPEG (sem transparência), NA vira "white".
#' @param quality Qualidade do JPEG (0–100) (default 95).
#' @param path Diretório de saída (default ".").
#' @param scale Fator de escala passado ao ggsave (default 1).
#' @param overwrite Se FALSE, não sobrescreve: cria sufixo _1, _2, ... (default TRUE).
#' @param include_date Se TRUE, anexa data ao nome: _YYYYMMDD (default FALSE).
#' @param date_format Formato da data (default "%Y%m%d").
#' @param use_cairo Preferir Cairo para PDF/EPS (default TRUE).
#' @param use_ragg Preferir ragg para PNG/JPG quando disponível (default TRUE).
#' @param quiet Silencia mensagens do ggsave quando suportado (default TRUE).
#' @param ... Passado a ggplot2::ggsave() (e, portanto, aos devices quando aplicável).
#'
#' @return Vetor nomeado (invisível) com caminhos dos arquivos salvos.
#' @export
save_ipeaplot <- function(
    gplot, file.name, format = NULL,
    width = 160, height = 100, units = c("mm","cm","in"),
    dpi = 300, background = "white", quality = 95,
    path = ".", scale = 1, overwrite = TRUE,
    include_date = FALSE, date_format = "%Y%m%d",
    use_cairo = TRUE, use_ragg = TRUE, quiet = TRUE, ...
) {
  if (!inherits(gplot, "ggplot"))
    stop("gplot deve ser um objeto ggplot2.", call. = FALSE)
  if (!is.character(file.name) || length(file.name) != 1L || nchar(file.name) == 0L)
    stop("file.name deve ser uma string não vazia.", call. = FALSE)

  units <- match.arg(units)

  if (is.null(format)) {
    format <- getOption("ipea.plot.default_format", "eps")
  }

  valid  <- c("eps","jpg","pdf","png")
  format <- unique(match.arg(format, choices = valid, several.ok = TRUE))

  base_name <- sub("\\.[^.]+$", "", file.name)
  if (include_date) base_name <- paste0(base_name, "_", format(Sys.Date(), date_format))

  ext <- function(fmt) switch(fmt, eps=".eps", jpg=".jpg", pdf=".pdf", png=".png")

  get_device <- function(fmt) {
    if (fmt %in% c("png","jpg") && use_ragg && requireNamespace("ragg", quietly = TRUE)) {
      return(if (fmt == "png") ragg::agg_png else ragg::agg_jpeg)
    }
    if (fmt == "png") return("png")
    if (fmt == "jpg") return("jpeg")
    if (fmt == "pdf") return(if (use_cairo) grDevices::cairo_pdf else grDevices::pdf)
    if (fmt == "eps") return(if (use_cairo) grDevices::cairo_ps  else grDevices::postscript)
  }

  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  next_free_name <- function(fp) {
    if (!file.exists(fp)) return(fp)
    root <- sub("(\\.[^.]+)$", "", fp)
    ex   <- sub("^.*(\\.[^.]+)$", "\\1", fp)
    i <- 1L
    repeat {
      candidate <- paste0(root, "_", i, ex)
      if (!file.exists(candidate)) return(candidate)
      i <- i + 1L
    }
  }

  ggsave_has_quiet <- "quiet" %in% names(formals(ggplot2::ggsave))

  out <- character(length(format))
  names(out) <- format

  for (i in seq_along(format)) {
    fmt <- format[i]
    file_path <- file.path(path, paste0(base_name, ext(fmt)))
    if (!overwrite) file_path <- next_free_name(file_path)

    dev <- get_device(fmt)

    # JPEG não tem transparência: NA -> "white"
    bg_use <- if (fmt == "jpg" && is.na(background)) "white" else background

    gargs <- list(
      filename = file_path,
      plot     = gplot,
      device   = dev,
      width    = width,
      height   = height,
      units    = units,
      scale    = scale
    )

    # Raster
    if (fmt %in% c("png","jpg")) {
      gargs$dpi <- dpi
      gargs$bg  <- bg_use
    }

    # Vetoriais:
    # - Em pdf()/postscript(): useDingbats = FALSE (evita fontes dingbat)
    # - Em todos vetoriais (inclui Cairo): fallback_resolution para rasterização
    if (fmt %in% c("pdf","eps")) {
      if (identical(dev, grDevices::pdf) || identical(dev, grDevices::postscript)) {
        gargs$useDingbats <- FALSE
      }
      gargs$fallback_resolution <- dpi
    }

    # JPEG: qualidade
    if (fmt == "jpg") {
      gargs$quality <- quality
    }

    gargs <- gargs[!vapply(gargs, is.null, logical(1))]

    dotlist <- list(...)
    if (ggsave_has_quiet) dotlist$quiet <- quiet
    if (length(dotlist)) gargs[names(dotlist)] <- dotlist

    do.call(ggplot2::ggsave, gargs)
    out[i] <- file_path
  }

  invisible(out)
}
