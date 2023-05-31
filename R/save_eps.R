#' Save the chart in .Eps
#'
#' This function makes easy to save charts in Eps.
#'
#' @param gplot ggplot which will be saved.
#' @param file.name name of the file which will be generated
#' @param width width of the picture
#' @param height height of the picture
#'
#' @family save
#' @import extrafont
#' @export


save_eps <- function(gplot, file.name, width = 5, height = 3){

  if(!("ggplot" %in% class(gplot))){
    stop("gplot deve ser um gráfico ggplot")
  }
  if(class(file.name) != "character"){
    stop("O nome do arquivo deve ser uma string")
  }

  loadfonts("postscript")
  postscript(file = file.name, width = width, height = height)
  gplot
  dev.off()

}
