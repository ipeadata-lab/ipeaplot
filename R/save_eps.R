#' Save the chart in Eps format
#'
#' Convenient function to save charts in Eps format.
#'
#' @param gplot ggplot which will be saved.
#' @param file.name Character. Name of the file which will be generated
#'
#' @family save
#' @export


save_eps <- function(gplot, file.name){

  if(!("ggplot" %in% class(gplot))){
    stop("gplot deve ser um grafico ggplot")
  }
  if(!inherits(file.name, 'character')){
    stop("O nome do arquivo deve ser uma 'string'")
  }

  if(!grepl(".eps",file.name)){
    # forçar que sempre seja terminado com '.eps'
    file.name <- paste0(gsub("\\.[^.]+$", "", file.name),".eps")
    warning("O formato do arquivo deve ser '.eps'")
  }

  grDevices::postscript(file = file.name, family = "Frutiger-LT-47-LightCn")
  gplot
  grDevices::dev.off()

}
