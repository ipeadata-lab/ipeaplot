#' Save the chart in two formats (one editable + one raster)
#'
#' Função prática para salvar simultaneamente um gráfico em dois formatos:
#' um vetorial/editável (EPS ou PDF) e um raster (JPG ou PNG).
#'
#' @param gplot Objeto `ggplot2` a ser salvo.
#' @param file.name Nome base do arquivo (sem extensão).
#' @param eps Salvar em EPS (default = TRUE).
#' @param pdf Salvar em PDF (default = FALSE).
#' @param jpg Salvar em JPG (default = TRUE).
#' @param png Salvar em PNG (default = FALSE).
#' @param ... Argumentos adicionais repassados para as funções
#'   `save_eps()`, `save_pdf()`, `save_jpg()`, `save_png()`.
#'
#' @return Vetor nomeado com os caminhos dos arquivos salvos (invisível).
#' @export
#' @family save
#'
#' @examples
#' \donttest{
#' library(ggplot2)
#' p <- ggplot(mtcars, aes(hp, mpg)) + geom_point() + theme_minimal()
#'
#' # default: EPS + JPG
#' save_multi(p, tempfile("grafico"))
#'
#' # PDF + PNG
#' save_multi(p, tempfile("grafico2"), eps = FALSE, jpg = FALSE, pdf = TRUE, png = TRUE)
#' }
save_multi <- function(gplot, file.name,
                       ..., eps = TRUE, pdf = FALSE,
                       jpg = TRUE, png = FALSE) {
  if (!inherits(gplot, "ggplot")) stop("gplot deve ser um gráfico 'ggplot2'.")
  if (!is.character(file.name) || length(file.name) != 1L) {
    stop("file.name deve ser uma string de comprimento 1.")
  }

  out <- character(0)

  if (eps) {
    out <- c(out, ipeaplot::save_eps(gplot, file.name, ...))
  }
  if (pdf) {
    out <- c(out, ipeaplot::save_pdf(gplot, file.name, ...))
  }
  if (jpg) {
    out <- c(out, ipeaplot::save_jpg(gplot, file.name, ...))
  }
  if (png) {
    out <- c(out, ipeaplot::save_png(gplot, file.name, ...))
  }

  invisible(out)
}
