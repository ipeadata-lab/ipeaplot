#' Save the chart in Eps format
#'
#' Convenient function to save charts in Eps format.
#'
#' @param gplot ggplot which will be saved.
#' @param file.name Character. Name of the file which will be generated
#' @param width Numeric. Width of the picture in centimeters
#' @param height Numeric. Height of the picture in centimeters
#'
#' @family save
#' @export
#'
save_eps <- function(gplot, file.name, width = 5, height = 3){

  if(!("ggplot" %in% class(gplot))){
    stop("gplot deve ser um grafico ggplot")
  }
  if(!inherits(a, 'character')){
    stop("O nome do arquivo deve ser uma 'string'")
  }

  loadfonts("postscript")
  grDevices::postscript(file = file.name, width = width, height = height)
  gplot
  grDevices::dev.off()

}
