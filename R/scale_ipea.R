#' @title Scale color IPEA
#'
#' @description Generate a color palette (continuous or discrete) in the
#'              formatting of texts published by the Institute for Applied
#'              Economic Research (IPEA)
#'
#' @param discrete A logical value indicating whether to use discrete or continuous scale bar. The default value is continuous.
#'
#' @param palette A character vector specifying the available palette for the
#'                color palette. The default palette are "Blue",
#'                but we can also change to 'Green','Orange','Pink','Red-Blue','Orange-Blue'.
#'
#' @param direction A character vector specifying the direction of the color gradient. \cr
#' The available palette are "horizontal" and "vertical". The default value is "horizontal".
#'
#' @param show.limits A logical value indicating whether to display the color gradient limits. The default value is TRUE.
#'
#' @param pt_br A logical value indicating whether to use Brazilian Portuguese formatting for labels. \cr
#' If TRUE, decimal marks are set to ",", and big marks are set to ".". The default value is TRUE.
#'
#' @param barheight The height of the color gradient bar. This parameter is used when the direction is set to "horizontal". The default value is 2.
#'
#' @param barwidth The width of the color gradient bar. This parameter is used when the direction is set to "horizontal". The default value is 50.
#'
#' @param ... Additional arguments to be passed to the scale_fill_gradientn, scale_color_gradientn, scale_fill_distiller or scale_color_distiller function from the ggplot2 package.
#'
#'
#' @return Graph colors and formatting within the standard of Texts for Discussion (TD) of IPEA.
#'
#' @export
scale_color_ipea <- function(discrete = F, palette = c('Blue','Green','Orange','Pink',
                                                       'Red-Blue','Orange-Blue'),
                              direction = c('horizontal','vertical'),
                              palette_direction = 1,
                              show.limits = T, pt_br = T ,
                              hline,vline,
                              barheight = 2,barwidth = 50, ...){

  # Set direction to 'vertical' if it is not provided, otherwise use the provided value
  direction <- ifelse(missing(direction), "vertical", direction)

  # Set palette to 'ipea1' if it is not provided, otherwise use the provided value
  palette <-  ifelse(missing(palette),'Blue',palette)

  if(missing(hline)){
    hline <- NULL
  } else{
    hline <- geom_hline(yintercept = hline, size = 0.25)
  }

  if(missing(vline)){
    vline <- NULL
  } else{
    vline <- geom_vline(xintercept = vline, size = 0.25)
  }


  if (pt_br == T) {
    # Use comma as decimal mark and dot as thousand separator for labels (Brazilian Portuguese)
    labels = scales::label_comma(decimal.mark = ",", big.mark = ".")
  } else {
    # Use dot as decimal mark and comma as thousand separator for labels (default)
    labels = scales::label_comma(decimal.mark = ".", big.mark = ",")
  }

  if (show.limits) {
    # Set show.limits to TRUE if it is not provided
    show.limits = T
  } else {
    # Set show.limits to FALSE if it is not provided
    show.limits = F
  }

  if (direction == 'vertical') {
    barheight = NULL  # Set barheight to NULL if direction is 'vertical'
    barwidth = NULL  # Set barwidth to NULL if direction is 'vertical'
    title.hjust = NULL  # Set title.hjust to NULL if direction is 'vertical'
    label.hjust = NULL  # Set label.hjust to NULL if direction is 'vertical'
  } else {
    barheight = unit(2, units = "mm")  # Set barheight to 2mm if direction is not 'vertical'
    barwidth = unit(50, units = "mm")  # Set barwidth to 50mm if direction is not 'vertical'
    title.hjust = 0.5  # Set title.hjust to 0.5 if direction is not 'vertical'
    label.hjust = 0.5  # Set label.hjust to 0.5 if direction is not 'vertical'
  }

  if(isFALSE(discrete)){
      # Set palette option
    scale_manual_pal <- ipea_palette(palette = palette, n = 10, direction = palette_direction)

      # Graph
      graph <- list(hline,vline,
                    ggplot2::scale_color_gradientn(
        labels = labels,  # Set the labels for the gradient scale
        colours = scale_manual_pal,  # Set the scale_manual_pal for the gradient scale
        guide = guide_coloursteps(
          #show.limits = show.limits,  # Set whether to show the limits on the colour scale
          direction = direction,  # Set the direction of the colour scale
          barheight = barheight,  # Set the height of the colour scale bar
          barwidth = barwidth,  # Set the width of the colour scale bar
          draw.ulim = F,  # Set whether to draw the upper limit line
          title.position = 'top',  # Set the position of the title
          even.steps = F,
          # some shifting around
          title.hjust = title.hjust,  # Set the horizontal alignment of the title
          label.hjust = label.hjust  # Set the horizontal alignment of the labels
        ),...))
      }
  if(isTRUE(discrete)){
    # Create a discrete color scale with the specified palette
    graph <- list(hline,vline,
                  ggplot2::discrete_scale("color", "ipea", ipea_pal(palette = palette, direction = palette_direction), ...),
                  ggplot2::guides(color=guide_legend(ncol = 3, byrow = TRUE)))
  }

  return(graph)
}




#' @title Scale fill IPEA
#'
#' @description Generate a fill palette (continuous or discrete) in the
#'              formatting of texts published by the Institute for Applied
#'              Economic Research (IPEA)
#' @param palette A character vector specifying the available palette for the
#'                color palette. The default palette are "crimson", "orpheu",
#'                "cartola", "caqui", "post", "wrapper", "blue_red", "ipea1",
#'                "ipea2", "ipea3", and "manual".
#' low, mid, high: Colors to be used for the low, mid, and high values of the gradient, respectively.  \cr
#' These parameters are used when the "manual" option is selected.
#'
#' @param direction A character vector specifying the direction of the color gradient. \cr
#' The available palette are "horizontal" and "vertical". The default value is "horizontal".
#'
#' @param colours A vector of colors to be used for the gradient. This parameter is used when palette other than "manual" are selected.
#'
#' @param show.limits A logical value indicating whether to display the color gradient limits. The default value is TRUE.
#'
#' @param pt_br A logical value indicating whether to use Brazilian Portuguese formatting for labels. \cr
#' If TRUE, decimal marks are set to ",", and big marks are set to ".". The default value is TRUE.
#'
#' @param barheight The height of the color gradient bar. This parameter is used when the direction is set to "vertical". The default value is 2.
#'
#' @param barwidth The width of the color gradient bar. This parameter is used when the direction is set to "horizontal". The default value is 50.
#'
#' @param ... Additional arguments to be passed to the scale_fill_gradientn or scale_color_gradientn function from the ggplot2 package.
#'
#'
#' @return Graph fill and formatting within the standard of Texts for Discussion (TD) of IPEA.
#'
#' @export
scale_fill_ipea <- function(discrete = F, palette = c('Blue','Green','Orange','Pink',
                                                      'Red-Blue','Orange-Blue'),
                                         direction = c('horizontal','vertical'),
                                         palette_direction = 1,
                                         hline,vline,
                                         show.limits = T, pt_br = T ,barheight = 2,barwidth = 50, ...){

  # Set direction to 'vertical' if it is not provided, otherwise use the provided value
  direction <- ifelse(missing(direction), "vertical", direction)

  # Set palette to 'ipea1' if it is not provided, otherwise use the provided value
  palette <-  ifelse(missing(palette),'Blue',palette)

  if(missing(hline)){
    hline <- NULL
  } else{
    hline <- geom_hline(yintercept = hline, size = 0.25)
  }

  if(missing(vline)){
    vline <- NULL
  } else{
    vline <- geom_vline(xintercept = vline, size = 0.25)
  }

  if (pt_br == T) {
    # Use comma as decimal mark and dot as thousand separator for labels (Brazilian Portuguese)
    labels = scales::label_comma(decimal.mark = ",", big.mark = ".")
  } else {
    # Use dot as decimal mark and comma as thousand separator for labels (default)
    labels = scales::label_comma(decimal.mark = ".", big.mark = ",")
  }

  if (show.limits) {
    # Set show.limits to TRUE if it is not provided
    show.limits = T
  } else {
    # Set show.limits to FALSE if it is not provided
    show.limits = F
  }

  if (direction == 'vertical') {
    barheight = NULL  # Set barheight to NULL if direction is 'vertical'
    barwidth = NULL  # Set barwidth to NULL if direction is 'vertical'
    title.hjust = NULL  # Set title.hjust to NULL if direction is 'vertical'
    label.hjust = NULL  # Set label.hjust to NULL if direction is 'vertical'
  } else {
    barheight = unit(2, units = "mm")  # Set barheight to 2mm if direction is not 'vertical'
    barwidth = unit(50, units = "mm")  # Set barwidth to 50mm if direction is not 'vertical'
    title.hjust = 0.5  # Set title.hjust to 0.5 if direction is not 'vertical'
    label.hjust = 0.5  # Set label.hjust to 0.5 if direction is not 'vertical'
  }

  if(isFALSE(discrete)){

      # Set palette palette
      scale_manual_pal <- ipea_palette(n = 10, palette = palette, direction = palette_direction)

      # Graph
      graph <- list(hline,vline,
                    ggplot2::scale_fill_gradientn(
        labels = labels,  # Set the labels for the gradient scale
        colours = scale_manual_pal,  # Set the scale_manual_pal for the gradient scale
        guide = guide_coloursteps(
          #show.limits = show.limits,  # Set whether to show the limits on the fill scale
          direction = direction,  # Set the direction of the fill scale
          barheight = barheight,  # Set the height of the fill scale bar
          barwidth = barwidth,  # Set the width of the fill scale bar
          draw.ulim = F,  # Set whether to draw the upper limit line
          title.position = 'top',  # Set the position of the title
          even.steps = F, # Legend formation to not look like it's discrete scaling
          # some shifting around
          title.hjust = title.hjust,  # Set the horizontal alignment of the title
          label.hjust = label.hjust  # Set the horizontal alignment of the labels
        ),...))

    }

  if(isTRUE(discrete)){


      # Create a discrete fill scale with the specified palette
      graph <- list(hline,vline,
                    ggplot2::discrete_scale("fill", "ipea", ipea_pal(palette = palette, direction = palette_direction), ...),
                    ggplot2::guides(fill=guide_legend(ncol = 3, byrow = TRUE)))


  }

  return(graph)

}

