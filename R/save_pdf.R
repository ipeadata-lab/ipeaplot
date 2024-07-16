#' Save the chart in PDF format
#'
#' Convenient function to save charts in PDF format.
#'
#' @param gplot ggplot which will be saved.
#' @param file.name Character. Name of the file which will be generated
#' @param ... Additional arguments to be passed to the `ggsave` function from the
#'        `ggplot2` package.
#'
#' @return An `"PDF"` file
#'
#' @import grDevices
#' @export
#' @family save
#'
#' @examples
#' \donttest{
#' # Creating theme for ggplot2 graph using default arguments
#' library(ggplot2)
#' fig_raw <- ggplot() +
#'   geom_col(data = mtcars, aes(x = hp , y = mpg, fill = cyl)) +
#'   theme_ipea()
#' # Save ggplot output
#' save_pdf(fig_raw,file.name = paste0(tempdir(),"/figura.pdf"))
#' }
save_pdf <- function(gplot, file.name,  ...){

  if(!("ggplot" %in% class(gplot))){
    stop("gplot deve ser um grafico ggplot")
  }
  if(!inherits(file.name, 'character')){
    stop("O nome do arquivo deve ser uma 'string'")
  }

  if(!grepl(".pdf",file.name)){
    # forçar que sempre seja terminado com '.pdf'
    file.name <- paste0(gsub("\\.[^.]+$", "", file.name),".pdf")
    warning("O formato do arquivo deve ser '.pdf'")
  }

  #grDevices::cairo_pdf(gplot, filename = file.name, ...)
  ggplot2::ggsave(gplot, file = file.name,  device= cairo_pdf, ...)

}
