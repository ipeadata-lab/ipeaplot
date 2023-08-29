#' @title Scale color IPEA
#'
#' @description Generate a color palette (continuous or discrete) following the
#'              editorial guidelines used by the Institute for Applied Economic
#'              Research - Ipea.
#' @param discrete A logical value indicating whether to use discrete or
#'        continuous scale bar. The default value is continuous.
#' @param palette A character vector specifying the available palette for the
#'        color palette. The default palette are `"Blue"`, but we can also change
#'        to `'Green'`, `'Orange'`, `'Pink'`, `'Red-Blue'`, `'Orange-Blue'`, `'Blue-Green'`,
#'        `'Viridis'`, `'Inferno'`, `'Magma'`, `'Plasma'`, `'Cividis'`.
#' @param palette_direction A logical argument specifying if the ordering of the colors
#'        will follow the default of the palette (when the argument is 1) or if it will
#'        have an inverted ordering (for cases where it is 0).
#' @param pt_br A string indicating whether the decimal separator should be a
#'        `","` or a `"."`. By default, the function uses a comma `","`, following
#'        the format used in Brazilian Portuguese.
#' @param barheight The height of the color gradient bar. This parameter is used
#'        when the direction is set to "horizontal".
#' @param barwidth The width of the color gradient bar. This parameter is used
#'        when the direction is set to "horizontal".
#' @param title.hjust A number specifying horizontal justification of the title text.
#' @param title.vjust A number specifying vertical justification of the title text.
#' @param ... Additional arguments to be passed to the scale_fill_gradientn,
#'        scale_color_gradientn, scale_fill_distiller or scale_color_distiller
#'        function from the ggplot2 package.
#'
#' @return A list object be added to a ggplot object to change color pallete.
#'
#' @export
scale_color_ipea <- function(discrete = F, palette = c('Blue','Green','Orange','Pink','Green-Blue',
                                                       'Red-Blue','Blue-Green','Orange-Blue', 'Viridis',
                                                       'Inferno','Magma','Plasma','Cividis'),
                              palette_direction = 1,
                              pt_br = T,
                              barheight, barwidth,
                              title.hjust, label.hjust,
                               ...){




  # Set palette to 'ipea1' if it is not provided, otherwise use the provided value
  palette <-  ifelse(missing(palette),'Blue',palette)


  if (pt_br == T) {
    # Use comma as decimal mark and dot as thousand separator for labels (Brazilian Portuguese)
    labels = scales::label_comma(decimal.mark = ",", big.mark = ".", accuracy = 0.1)
  } else {
    # Use dot as decimal mark and comma as thousand separator for labels (default)
    labels = scales::label_comma(decimal.mark = ".", big.mark = ",", accuracy = 0.1)
  }


  label.hjust = ifelse(missing(label.hjust),0.5,label.hjust)
  title.hjust = ifelse(missing(title.hjust),0.5,title.hjust)

  if(missing(barheight)){
    barheight = NULL
  } else{
    barheight = unit(barheight, units = "mm")
  }

  if(missing(barwidth)){
    barwidth = NULL
  } else{
    barwidth = unit(barwidth, units = "mm")
  }



  if(isFALSE(discrete)){
      # Set palette option
    scale_manual_pal <- ipea_palette(palette = palette, n = 10, palette_direction = palette_direction)

      # Graph
      graph <- list(ggplot2::scale_color_gradientn(
        labels = labels,  # Set the labels for the gradient scale
        colours = scale_manual_pal,  # Set the scale_manual_pal for the gradient scale
        ...),
        guides(color =   guide_coloursteps(
          label.hjust = label.hjust,
          title.hjust = title.hjust,
          barheight = barheight,
          barwidth = barwidth,
          title.position = 'top',
          even.steps = F,...)))
      }
  if(isTRUE(discrete)){
    # Create a discrete color scale with the specified palette
    graph <- list(ggplot2::discrete_scale("color", "ipea", ipea_pal(palette = palette, palette_direction = palette_direction), ...),
                  ggplot2::guides(color=guide_legend(ncol = 3, byrow = TRUE)))
  }

  return(graph)
}




#' @title Scale fill IPEA
#'
#' @description Generate a fill palette (continuous or discrete) in the
#'              formatting of texts published by the Institute for Applied
#'              Economic Research (IPEA)
#' @param discrete A logical value indicating whether to use discrete or
#'        continuous scale bar. The default value is continuous.
#' @param palette A character vector specifying the available palette for the
#'        fill palette. The default palette are `"Blue"`, but we can also change
#'        to `'Green'`, `'Orange'`, `'Pink'`, `'Red-Blue'`, `'Orange-Blue'`,`'Blue-Green'`,
#'        `'Viridis'`, `'Inferno'`, `'Magma'`, `'Plasma'`, `'Cividis'`.
#' @param palette_direction A logical argument specifying if the ordering of the colors
#'        will follow the default of the palette (when the argument is 1) or if it will
#'        have an inverted ordering (for cases where it is 0).
#' @param pt_br A string indicating whether the decimal separator should be a
#'        `","` or a `"."`. By default, the function uses a comma `","`, following
#'        the format used in Brazilian Portuguese.
#' @param barheight The height of the color gradient bar. This parameter is used
#'        when the direction is set to "horizontal".
#' @param barwidth The width of the color gradient bar. This parameter is used
#'        when the direction is set to "horizontal".
#' @param title.hjust A number specifying horizontal justification of the title text.
#' @param title.vjust A number specifying vertical justification of the title text.
#' @param ... Additional arguments to be passed to the scale_fill_gradientn,
#'        scale_color_gradientn, scale_fill_distiller or scale_color_distiller
#'        function from the ggplot2 package
#'
#'
#' @return A list object be added to a ggplot object to change color pallete.
#'
#' @export
scale_fill_ipea <- function(discrete = F, palette = c('Blue','Green','Orange','Pink','Green-Blue',
                                                      'Red-Blue','Blue-Green','Orange-Blue', 'Viridis',
                                                      'Inferno','Magma','Plasma','Cividis'),
                            palette_direction = 1,
                            pt_br = T,
                            barheight, barwidth,
                            title.hjust, label.hjust,
                            ...){

  # Set palette to 'ipea1' if it is not provided, otherwise use the provided value
  palette <-  ifelse(missing(palette),'Blue',palette)


  if (pt_br == T) {
    # Use comma as decimal mark and dot as thousand separator for labels (Brazilian Portuguese)
    labels = scales::label_comma(decimal.mark = ",", big.mark = ".")
  } else {
    # Use dot as decimal mark and comma as thousand separator for labels (default)
    labels = scales::label_comma(decimal.mark = ".", big.mark = ",")
  }


  label.hjust = ifelse(missing(label.hjust),0.5,label.hjust)
  title.hjust = ifelse(missing(title.hjust),0.5,title.hjust)

  if(missing(barheight)){
    barheight = NULL
  } else{
    barheight = unit(barheight, units = "mm")
  }

  if(missing(barwidth)){
    barwidth = NULL
  } else{
    barwidth = unit(barwidth, units = "mm")
  }

  if(isFALSE(discrete)){

      # Set palette palette
      scale_manual_pal <- ipea_palette(n = 10, palette = palette, palette_direction = palette_direction)

      # Graph
      graph <- list(
        ggplot2::scale_fill_gradientn(
        labels = labels,  # Set the labels for the gradient scale
        colours = scale_manual_pal),
        guides(color =   guide_coloursteps(
          label.hjust = label.hjust,
          title.hjust = title.hjust,
          barheight = barheight,
          barwidth = barwidth,
          title.position = 'top',
          even.steps = F,...)))
  }

  if(isTRUE(discrete)){


      # Create a discrete fill scale with the specified palette
      graph <- list(hline,vline,
                    ggplot2::discrete_scale("fill", "ipea", ipea_pal(palette = palette, palette_direction = palette_direction), ...),
                    ggplot2::guides(fill=guide_legend(ncol = 3, byrow = TRUE)))


  }

  return(graph)

}

