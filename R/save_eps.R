#' Save the chart in Eps format
#'
#' Convenient function to save charts in Eps format.
#'
#' @param gplot ggplot which will be saved.
#' @param file.name Character. Name of the file which will be generated
#' @param ... Additional arguments to be passed to the `ggsave` function from the
#'        `ggplot2` package.
#'
#' @return An `"sf" "data.frame"` object
#'
#' @export
#' @family save
#'
#' @examples
#' \dontrun{
#' # Creating theme for ggplot2 graph using default arguments
#' library(ggplot2)
#' fig_raw <- ggplot() +
#'   geom_col(data = mtcars, aes(x = hp , y = mpg, fill = cyl)) +
#'   theme_ipea()
#' # Save ggplot output
#' save_eps(fig_raw,file.name = "figura.eps")
#' }
save_eps <- function(gplot, file.name,  ...){

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

  ggplot2::ggsave(gplot, file = file.name,  device="eps", family = 'Frutiger LT Light Cond', ...)


}
