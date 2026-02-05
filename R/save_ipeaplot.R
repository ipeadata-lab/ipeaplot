#' @title Save ggplot in multiple formats
#' @description Unified function to save ggplot objects in one or more formats.
#'
#' @param gplot ggplot object. Default: ggplot2::last_plot().
#' @param file.name Base name of the file (without extension). E.g., "results/figs/my_plot".
#' @param format Vector with one or more of: "eps", "jpg", "pdf", "png", "svg".
#'   If NULL, uses getOption("ipea.plot.default_format", "eps").
#' @param width,height Plot dimensions (default 160 x 100).
#' @param units Units: "mm", "cm", "in", "px" (default "in").
#' @param dpi DPI for raster formats (default 300).
#' @param background Background color; use NA for transparent PNGs.
#'                  For JPEG (no transparency), NA becomes "white".
#' @param quality JPEG quality (0 to 100) (default 95).
#' @param path Output directory (default ".").
#' @param scale Scale factor passed to ggsave (default 1).
#' @param overwrite If FALSE, does not overwrite existing files: creates suffixes _1, _2, ... (default TRUE).
#' @param include_date If TRUE, appends the date to the file name: _YYYYMMDD (default FALSE).
#' @param date_format Date format (default "%Y%m%d").
#' @param use_cairo Prefer using Cairo for PDF/EPS (default TRUE).
#' @param use_ragg Prefer using ragg for PNG/JPG when available (default TRUE).
#' @param quiet Suppress messages from ggsave when supported (default TRUE).
#' @param ... Passed to ggplot2::ggsave() (and therefore to the underlying graphics devices when applicable).
#'
#' @return Named (invisible) vector with the paths of the saved files.
#' @import ragg
#' @export
save_ipeaplot <- function(
    gplot = ggplot2::last_plot(),
    file.name,
    format = NULL,
    width = 6.30,
    height = 3.94,
    units = c("in", "mm", "cm", "px"),
    dpi = 300,
    background = "white",
    quality = 95,
    path = ".",
    scale = 1,
    overwrite = TRUE,
    include_date = FALSE,
    date_format = "%Y%m%d",
    use_cairo = TRUE,
    use_ragg = TRUE,
    quiet = TRUE,
    ...
) {
  if (!inherits(gplot, "ggplot")) {
    stop("gplot must be a ggplot2 object.", call. = FALSE)
  }
  if (!is.character(file.name) || length(file.name) != 1L || nchar(file.name) == 0L) {
    stop("file.name must be a non-empty string.", call. = FALSE)
  }

  units <- match.arg(units)

  if (is.null(format)) {
    format <- getOption("ipea.plot.default_format", "eps")
  }

  valid <- c("eps", "jpg", "pdf", "png", "svg")
  format <- unique(match.arg(format, choices = valid, several.ok = TRUE))

  # Auto-conversao de "mm digitado como in" (ex.: width=160, height=100 com units="in")
  if (units == "in" && (width >= 50 || height >= 50)) {
    width <- width / 25.4
    height <- height / 25.4
    message(sprintf(
      "Dimensions too large in 'in'; interpreting as mm -> width=%.2f in, height=%.2f in.",
      width, height
    ))
  }

  base_name <- sub("\\.[^.]+$", "", file.name)
  if (include_date) {
    base_name <- paste0(base_name, "_", format(Sys.Date(), date_format))
  }

  ext <- function(fmt) {
    switch(fmt,
           eps = ".eps",
           jpg = ".jpg",
           pdf = ".pdf",
           png = ".png",
           svg = ".svg"
    )
  }

  # ---------------------------------------------------------------------------
  # CORREÇÃO: evitar segfault do ragg no macOS em ambientes CI (GitHub Actions)
  # - Se estiver em CI + macOS, cai para device base png/jpeg.
  # - Permite forçar desligar via env var: IPEAPLOT_DISABLE_RAGG=1/true/yes
  # ---------------------------------------------------------------------------
  is_ci <- identical(Sys.getenv("GITHUB_ACTIONS"), "true") || identical(Sys.getenv("CI"), "true")
  is_macos <- identical(Sys.info()[["sysname"]], "Darwin")
  ragg_disabled <- tolower(Sys.getenv("IPEAPLOT_DISABLE_RAGG")) %in% c("1", "true", "yes")
  use_ragg_eff <- isTRUE(use_ragg) && !ragg_disabled && !(is_ci && is_macos)

  get_device <- function(fmt) {
    if (fmt %in% c("png", "jpg") && use_ragg_eff && requireNamespace("ragg", quietly = TRUE)) {
      return(if (fmt == "png") ragg::agg_png else ragg::agg_jpeg)
    }
    if (fmt == "png") return("png")
    if (fmt == "jpg") return("jpeg")
    if (fmt == "pdf") return(if (use_cairo) grDevices::cairo_pdf else grDevices::pdf)
    if (fmt == "eps") return(if (use_cairo) grDevices::cairo_ps else grDevices::postscript)
    if (fmt == "svg") {
      # Usa svglite se disponível; senão cai para o device base (grDevices::svg via "svg")
      if (requireNamespace("svglite", quietly = TRUE)) return(svglite::svglite)
      return("svg")
    }
  }

  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  next_free_name <- function(fp) {
    if (!file.exists(fp)) return(fp)
    root <- sub("(\\.[^.]+)$", "", fp)
    ex <- sub("^.*(\\.[^.]+)$", "\\1", fp)
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

    # JPEG nao tem transparencia: NA -> "white"
    bg_use <- if (fmt == "jpg" && is.na(background)) "white" else background

    gargs <- list(
      filename = file_path,
      plot = gplot,
      device = dev,
      width = width,
      height = height,
      units = units,
      scale = scale
    )

    # Raster
    if (fmt %in% c("png", "jpg")) {
      gargs$dpi <- dpi
      gargs$bg <- bg_use
    }

    # Vetoriais:
    # - Em pdf()/postscript(): useDingbats = FALSE (evita fontes dingbat)
    # - Em todos vetoriais (inclui Cairo): fallback_resolution para rasterizacao
    if (fmt %in% c("pdf", "eps", "svg")) {
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
