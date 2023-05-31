#' @title Scale colour IPEA
#'
#' @description Generate a color palette (continuous or discrete) in the formatting of texts published by the Institute of Applied Economic Research (IPEA)
#'
#' @param options A character vector specifying the available options for the color palette. \cr
#' The default options are "crimson", "orpheu", "cartola", "caqui", "post", "wrapper", "blue_red", "ipea1", "ipea2", "ipea3", and "manual". \cr
#' low, mid, high: Colors to be used for the low, mid, and high values of the gradient, respectively.  \cr
#' These parameters are used when the "manual" option is selected.
#'
#' @param direction A character vector specifying the direction of the color gradient. \cr
#' The available options are "horizontal" and "vertical". The default value is "horizontal".
#'
#' @param colours A vector of colors to be used for the gradient. This parameter is used when options other than "manual" are selected.
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
source('./R/ipea_pallete.R')

#' @rdname scale_ipea
#' @export
scale_ipea <- function(type = c('continuous','discrete'),
                       style = c('colour','color','fill'),...){
  if(type == 'continuous' & style == 'fill'){
    scale_fill_continuous_ipea()
  } else if(type == 'continuous' & (style == 'colour' | style == 'color')){
    scale_colour_continuous_ipea()
  } else if(type == 'discrete' & (style == 'colour' | style == 'color')){
    scale_colour_discrete_ipea()
  } else if(type == 'discrete' & style == 'fill'){
    scale_fill_discrete_ipea()
  } else{
    stop("Type options must be 'continuous' or 'discrete' and Style options must be 'colour' or 'fill'")
  }
}

#' @rdname scale_colour_discrete_ipea
#' @export
scale_colour_discrete_ipea <- function(options = c("crimson","orpheu","cartola","caqui",
                                                   "post","wrapper","blue_red","ipea1",
                                                   "ipea2",'ipea3'),...){

    # Set options to 'ipea1' if it is missing
  options <- ifelse(missing(options), 'ipea1', options)

  if (options == "ipea1") {
    # Set colours to the ipea1 palette using manual_pal function
    colours <- scales::manual_pal(c(ipea_palettes$ipea1))
  } else if (options == "ipea2") {
    # Set colours to the ipea2 palette using manual_pal function
    colours <- scales::manual_pal(c(ipea_palettes$ipea2))
  } else if (options == "ipea3") {
    # Set colours to the ipea3 palette using manual_pal function
    colours <- scales::manual_pal(c(ipea_palettes$ipea2))
  } else if (options == "crimson") {
    # Set colours to the crimson palette using manual_pal function
    colours <- scales::manual_pal(c(ipea_palettes$crimson))
  } else if (options == "orpheu") {
    # Set colours to the orpheu palette using manual_pal function
    colours <- scales::manual_pal(c(ipea_palettes$orpheu))
  } else if (options == "cartola") {
    # Set colours to the cartola palette using manual_pal function
    colours <- scales::manual_pal(c(ipea_palettes$cartola))
  } else if (options == "caqui") {
    # Set colours to the caqui palette using manual_pal function
    colours <- scales::manual_pal(c(ipea_palettes$caqui))
  } else if (options == "post") {
    # Set colours to the post palette using manual_pal function
    colours <- scales::manual_pal(c(ipea_palettes$post))
  } else if (options == "wrapper") {
    # Set colours to the wrapper palette using manual_pal function
    colours <- scales::manual_pal(c(ipea_palettes$wrapper))
  } else {
    # Stop the execution and display an error message if options is none of the specified values
    stop("Palette options must be 'crimson', 'orpheu', 'top hat', 'khaki', 'post', 'wrapper', 'blue_red', 'ipea1', 'ipea2', 'ipea3'")
  }

  # Create a discrete colour scale with the specified palette
  ggplot2::discrete_scale("colour", "ipea", colours, ...)

}

#' @rdname scale_color_discrete_ipea
#' @export
# Correction of argument if it is written wrong
scale_color_discrete_ipea <- scale_colour_discrete_ipea



#' @rdname scale_colour_continuous_ipea
#' @export
scale_colour_continuous_ipea <- function(options = c("crimson","orpheu","cartola","caqui",
                                                     "post","wrapper","blue_red","ipea1",
                                                     "ipea2",'ipea3',"manual"),low = NULL, mid = NULL,  high = NULL,
                                         direction = c('horizontal','vertical'),colours,
                                         show.limits = T, pt_br = T ,barheight = 2,barwidth = 50, ...){

  # Set direction to 'vertical' if it is not provided, otherwise use the provided value
  direction <- ifelse(missing(direction), "vertical", direction)

  # Set options to 'ipea1' if it is not provided, otherwise use the provided value
  options <- ifelse(missing(options), 'ipea1', options)


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

  if (options == "ipea1") {
    # Set colours to the ipea1 palette if options is "ipea1"
    colours <- ipea_palettes$ipea1
  } else if (options == "ipea2") {
    # Set colours to the ipea2 palette if options is "ipea2"
    colours <- ipea_palettes$ipea2
  } else if (options == "crimson") {
    # Set colours to the crimson palette if options is "crimson"
    colours <- ipea_palettes$crimson
  } else if (options == "orpheu") {
    # Set colours to the orpheu palette if options is "orpheu"
    colours <- ipea_palettes$orpheu
  } else if (options == "cartola") {
    # Set colours to the cartola palette if options is "cartola"
    colours <- ipea_palettes$cartola
  } else if (options == "caqui") {
    # Set colours to the caqui palette if options is "caqui"
    colours <- ipea_palettes$caqui
  } else if (options == "post") {
    # Set colours to the post palette if options is "post"
    colours <- ipea_palettes$post
  } else if (options == "wrapper") {
    # Set colours to the wrapper palette if options is "wrapper"
    colours <- ipea_palettes$wrapper
  } else {
    # Stop the execution and display an error message if options is none of the specified values
    stop("Palette options must be 'crimson', 'orpheu', 'top hat', 'khaki', 'post', 'wrapper', 'blue_red', 'ipea1', 'ipea2', 'ipea3', 'manual'")
  }
  if(options == "manual"){

    if (missing(mid)) {
      # Set colours to a vector containing low and high if mid is missing
      colours = c(low, high)
      # Set values to a vector containing 0 and 1 if mid is missing
      values = c(0, 1)
    } else {
      # Set colours to a vector containing low, mid, and high if mid is present
      colours = c(low, mid, high)
      # Set values to a vector containing 0, 0.5, and 1 if mid is present
      values = c(0, 0.5, 1)
    }

    ggplot2::scale_fill_gradientn(
      labels = labels,  # Set the labels for the gradient scale
      colours = colours,  # Set the colours for the gradient scale
      values = values,  # Set the values for the gradient scale
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
      ),...
    )

  } else {
    ggplot2::scale_color_gradientn(
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

#' @rdname scale_color_continuous_ipea
#' @export
# Correction of argument if it is written wrong
scale_color_continuous_ipea <- scale_colour_continuous_ipea






#' @rdname scale_fill_discrete_ipea
#' @export
scale_fill_discrete_ipea <- function(options = c("crimson","orpheu","cartola","caqui",
                                                 "post","wrapper","blue_red","ipea1",
                                                 "ipea2",'ipea3'),...){
  # Set options to 'ipea1' if it is missing
  options <- ifelse(missing(options), 'ipea1', options)

  if (options == "ipea1") {
    # Set colours to the ipea1 palette if options is "ipea1"
    colours <- ipea_palettes$ipea1
  } else if (options == "ipea2") {
    # Set colours to the ipea2 palette if options is "ipea2"
    colours <- ipea_palettes$ipea2
  } else if (options == "crimson") {
    # Set colours to the crimson palette if options is "crimson"
    colours <- ipea_palettes$crimson
  } else if (options == "orpheu") {
    # Set colours to the orpheu palette if options is "orpheu"
    colours <- ipea_palettes$orpheu
  } else if (options == "cartola") {
    # Set colours to the cartola palette if options is "cartola"
    colours <- ipea_palettes$cartola
  } else if (options == "caqui") {
    # Set colours to the caqui palette if options is "caqui"
    colours <- ipea_palettes$caqui
  } else if (options == "post") {
    # Set colours to the post palette if options is "post"
    colours <- ipea_palettes$post
  } else if (options == "wrapper") {
    # Set colours to the wrapper palette if options is "wrapper"
    colours <- ipea_palettes$wrapper
  } else {
    # Stop the execution and display an error message if options is none of the specified values
    stop("Palette options must be 'crimson', 'orpheu', 'top hat', 'khaki', 'post', 'wrapper', 'blue_red', 'ipea1', 'ipea2', 'ipea3', 'manual'")
  }

  # Create a discrete colour scale with the specified palette
  ggplot2::discrete_scale("fill", "ipea", colours, ...)

}

#' @rdname scale_fill_continuous_ipea
#' @export
scale_fill_continuous_ipea <- function(options = c("crimson","orpheu","cartola","caqui",
                                                   "post","wrapper","blue_red","ipea1",
                                                   "ipea2",'ipea3',"manual"),low = NULL, mid = NULL,  high = NULL,
                                       direction = c('horizontal','vertical'),colours,
                                       show.limits = T, pt_br = T ,barheight = 2,barwidth = 50, ...){

  # Set direction to 'vertical' if it is not provided, otherwise use the provided value
  direction <- ifelse(missing(direction), "vertical", direction)

  # Set options to 'ipea1' if it is not provided, otherwise use the provided value
  options <- ifelse(missing(options), 'ipea1', options)


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

  if (options == "ipea1") {
    # Set colours to the ipea1 palette if options is "ipea1"
    colours <- ipea_palettes$ipea1
  } else if (options == "ipea2") {
    # Set colours to the ipea2 palette if options is "ipea2"
    colours <- ipea_palettes$ipea2
  } else if (options == "crimson") {
    # Set colours to the crimson palette if options is "crimson"
    colours <- ipea_palettes$crimson
  } else if (options == "orpheu") {
    # Set colours to the orpheu palette if options is "orpheu"
    colours <- ipea_palettes$orpheu
  } else if (options == "cartola") {
    # Set colours to the cartola palette if options is "cartola"
    colours <- ipea_palettes$cartola
  } else if (options == "caqui") {
    # Set colours to the caqui palette if options is "caqui"
    colours <- ipea_palettes$caqui
  } else if (options == "post") {
    # Set colours to the post palette if options is "post"
    colours <- ipea_palettes$post
  } else if (options == "wrapper") {
    # Set colours to the wrapper palette if options is "wrapper"
    colours <- ipea_palettes$wrapper
  } else {
    # Stop the execution and display an error message if options is none of the specified values
    stop("Palette options must be 'crimson', 'orpheu', 'top hat', 'khaki', 'post', 'wrapper', 'blue_red', 'ipea1', 'ipea2', 'ipea3', 'manual'")
  }


  if (options == "manual") {

    if (missing(mid)) {
      # Set colours to a vector containing low and high if mid is missing
      colours = c(low, high)
      # Set values to a vector containing 0 and 1 if mid is missing
      values = c(0, 1)
    } else {
      # Set colours to a vector containing low, mid, and high if mid is present
      colours = c(low, mid, high)
      # Set values to a vector containing 0, 0.5, and 1 if mid is present
      values = c(0, 0.5, 1)
    }

    # Create a gradient scale with custom colours and values
    ggplot2::scale_fill_gradientn(
      labels = labels,  # Set the labels for the gradient scale
      colours = colours,  # Set the colours for the gradient scale
      values = values,  # Set the values for the gradient scale
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
      ), ...
    )

  } else {

    # Create a gradient scale with predefined colours
    ggplot2::scale_fill_gradientn(
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
      ), ...
    )

  }

}


