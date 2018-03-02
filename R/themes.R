#' Ipea Theme
#'
#' This theme is designed to fulfill the requisites of Ipea's editorial about plots.
#'
#'
#' @inheritParams ggplot2::theme
#' @param axis logical, whether the plot should keed the axis line or not.
#' @param only.color logical, whether there is more than one factor in the plot.
#'
#' @family themes
#' @import ggplot2
#' @export


theme_ipea <- function(axis = TRUE, only.color = T, ...) {
  is.legenda = ifelse(only.color, "none", "bottom")
  if(axis){
    axis.line.x = element_line(size = 0.5, linetype = "solid", colour = "black")
    axis.line.y = element_line(size = 0.5, linetype = "solid", colour = "black")
  } else {
    axis.line.x = element_blank()
    axis.line.y = element_blank()
  }



  theme(panel.background = element_rect(fill = "white",colour = NA),
        panel.border = element_blank(),
        panel.grid.major = element_line(colour = "grey90",size = 0.2),
        panel.grid.minor = element_line(colour = "grey98",size = 0.5),
        panel.grid.major.x=element_blank(),
        axis.line = element_line(),
        legend.position=is.legenda,legend.title=element_blank(),
        legend.key = element_rect(colour = "transparent", fill = "white"),
        axis.line.x = axis.line.x,
        axis.line.y = axis.line.y,
        axis.text = element_text(colour = "black"),
        axis.title.y=element_text(vjust=1.5),
        axis.title.x=element_text(vjust=-0.4),
        plot.title = element_text(size = 9, lineheight = 8.4,
                                  family = "Roboto Condensed", face = "bold", hjust = 0),
        plot.subtitle = element_text(size = 9, lineheight = 8.4,
                                     family = "Roboto Light", hjust = 0),
        legend.text = element_text(size = 7, family = "Roboto Light"),
        legend.justification = "left"
        )

}

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

save.eps <- function(gplot, file.name, width = 5, height = 3){
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
