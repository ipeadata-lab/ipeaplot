#' @title Scale color IPEA
#'
#' @description Generate a color palette (continuous or discrete) in the
#'              formatting of texts published by the Institute for Applied
#'              Economic Research (IPEA)
#'
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
#' @return Graph colors and formatting within the standard of Texts for Discussion (TD) of IPEA.
#'
#' @export
scale_color_ipea <- function(discrete = F, palette = c('ipeatd','ipea2','ipea3',...),
                              direction = c('horizontal','vertical'),
                              show.limits = T, pt_br = T ,barheight = 2,barwidth = 50, ...){

  # Set direction to 'vertical' if it is not provided, otherwise use the provided value
  direction <- ifelse(missing(direction), "vertical", direction)

  # Set palette to 'ipea1' if it is not provided, otherwise use the provided value
  palette <- ifelse(missing(palette), 'ipeatd', palette)


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
    if(!palette %in% c('ipeatd','ipea2','ipea3')){
      graph <- ggplot2::scale_fill_distiller (
        palette = gsub("ipea","",palette),
        direction = direction,
        aesthetics = "colour", ...)
    } else {

      # Set palette option
      colours <- ipea_palette(palette = palette)

      # Graph
      graph <- ggplot2::scale_color_gradientn(
        labels = labels,  # Set the labels for the gradient scale
        colours = colours,  # Set the colours for the gradient scale
        guide = guide_coloursteps(
          show.limits = show.limits,  # Set whether to show the limits on the colour scale
          direction = direction,  # Set the direction of the colour scale
          barheight = barheight,  # Set the height of the colour scale bar
          barwidth = barwidth,  # Set the width of the colour scale bar
          draw.ulim = F,  # Set whether to draw the upper limit line
          title.position = 'top',  # Set the position of the title
          # some shifting around
          title.hjust = title.hjust,  # Set the horizontal alignment of the title
          label.hjust = label.hjust  # Set the horizontal alignment of the labels
        ),...)
  }
}
  if(isTRUE(discrete)){
    if(!palette %in% c('ipeatd','ipea2','ipea3')){
      graph <- ggplot2::scale_color_brewer(
       # type = type,
        palette = gsub("ipea","",palette),
        direction = direction,
        aesthetics = "colour", ...)
    } else {

      # Set palette option
      colours <- scales::manual_pal(c(ipea_palette(palette = palette)))

      # Create a discrete colour scale with the specified palette
      graph <- ggplot2::discrete_scale("colour", "ipea", colours, ...)

    }
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
scale_fill_ipea <- function(discrete = F, palette = c('ipeatd','ipea2','ipea3',...),
                                         direction = c('horizontal','vertical'),colours,
                                         show.limits = T, pt_br = T ,barheight = 2,barwidth = 50, ...){

  # Set direction to 'vertical' if it is not provided, otherwise use the provided value
  direction <- ifelse(missing(direction), "vertical", direction)

  # Set palette to 'ipea1' if it is not provided, otherwise use the provided value
  palette <- ifelse(missing(palette), 'ipeatd', palette)


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
    if(!palette %in% c('ipeatd','ipea2','ipea3')){
      graph <- ggplot2::scale_fill_distiller (
        palette = gsub("ipea","",palette),
        direction = direction,
        aesthetics = "fill", ...)
    } else {

      # Set palette option
      colours <- ipea_palette(palette = palette)

      # Graph
      graph <- ggplot2::scale_fill_gradientn(
        labels = labels,  # Set the labels for the gradient scale
        colours = colours,  # Set the fills for the gradient scale
        guide = guide_coloursteps(
          show.limits = show.limits,  # Set whether to show the limits on the fill scale
          direction = direction,  # Set the direction of the fill scale
          barheight = barheight,  # Set the height of the fill scale bar
          barwidth = barwidth,  # Set the width of the fill scale bar
          draw.ulim = F,  # Set whether to draw the upper limit line
          title.position = 'top',  # Set the position of the title
          # some shifting around
          title.hjust = title.hjust,  # Set the horizontal alignment of the title
          label.hjust = label.hjust  # Set the horizontal alignment of the labels
        ),...)

    }
  }
  if(isTRUE(discrete)){
    if(!palette %in% c('ipeatd','ipea2','ipea3')){
      graph <- ggplot2::scale_color_brewer(
        # type = type,
        palette = gsub("ipea","",palette),
        direction = direction,
        aesthetics = "fill", ...)
    } else {

      # Set palette option
      fills <- scales::manual_pal(c(ipea_palette(palette = palette)))

      # Create a discrete fill scale with the specified palette
      graph <- ggplot2::discrete_scale("fill", "ipea", fills, ...)

    }
  }

  return(graph)

}

