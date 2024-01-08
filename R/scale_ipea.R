#' @title Scale color IPEA
#'
#' @description Generate a color palette (continuous or discrete) following the
#'              editorial guidelines used by the Institute for Applied Economic
#'              Research - Ipea.
#' @param discrete A logical value indicating whether to use discrete or
#'        continuous scale bar. The default value is continuous.
#' @param palette A character vector specifying the available palette for the
#'        color palette. The default palette are `"Blue"`, but we can also change
#'        to `'Green'`, `'Orange'`, `'Pink'`, `'Red-Blue'`, `'Orange-Blue'`, `'Green-Blue'`,
#'        `'Red-Blue-White'`, `'Orange-Blue-White'`, `'Green-Blue-White'`,
#'        `'Viridis'`, `'Inferno'`, `'Magma'`, `'Plasma'`, `'Cividis'`.
#' @param palette_direction A logical argument specifying if the ordering of the colors
#'        will follow the default of the palette (when the argument is 1) or if it will
#'        have an inverted ordering (for cases where it is -1).
#' @param decimal.mark The character to be used to indicate the numeric decimal point and
#'        Character used between every 3 digits to separate thousands.
#'        By default, the function uses a comma `","`, following
#'        the format used in Brazilian Portuguese.
#' @param barheight The height of the color gradient bar. This parameter is used
#'        when the direction is set to "horizontal".
#' @param barwidth The width of the color gradient bar. This parameter is used
#'        when the direction is set to "horizontal".
#' @param title.hjust A number specifying horizontal justification of the title text.
#' @param label.hjust A number specifying vertical justification of the title text.
#' @param ... Additional arguments to be passed to the scale_fill_gradientn,
#'        scale_color_gradientn, scale_fill_distiller or scale_color_distiller
#'        function from the ggplot2 package.
#'
#' @return A list object be added to a ggplot object to change color pallete.
#'
#' @export
# Definition of the scale_color_ipea function
scale_color_ipea <- function(palette = c('Blue','Green','Orange','Pink','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
                                         'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno','Magma','Plasma','Cividis'),
                             palette_direction = 1,
                             decimal.mark = ",",
                             barheight = NULL, barwidth = NULL,
                             title.hjust = NULL, label.hjust = NULL,
                             ...) {

  structure(list(palette = palette, palette_direction = palette_direction,
                 decimal.mark = decimal.mark, barheight = barheight, barwidth = barwidth,
                 title.hjust = title.hjust, label.hjust = label.hjust,...), class = "scale_ipea")
}

# Definition of the ggplot_add.scale_ipea method
ggplot_add.scale_ipea <- function(object, plot, name, ...){

  # Set arguments
  args <- object
  palette <- args$palette
  palette_direction <- args$palette_direction
  decimal.mark <- args$decimal.mark
  barheight <- args$barheight
  barwidth <- args$barwidth
  title.hjust <- args$title.hjust
  label.hjust <- args$label.hjust

  # Set palette to 'ipea1' if it is not provided, otherwise use the provided value
  palette <-  ifelse(missing(palette),'Blue',palette)


  if (decimal.mark == ",") {
    # Use comma as decimal mark and dot as thousand separator for labels (Brazilian Portuguese)
    labels = scales::label_comma(decimal.mark = ",", big.mark = ".")
  } else if (decimal.mark == "."){
    # Use dot as decimal mark and comma as thousand separator for labels (default)
    labels = scales::label_comma(decimal.mark = ".", big.mark = ",")
  } else {
    stop("Decimal.mark argument must be '.' or ','.")
  }

  # Set default arguments
  label.hjust = ifelse(is.null(label.hjust),0.5,label.hjust)
  title.hjust = ifelse(is.null(title.hjust),0.5,title.hjust)

  if(is.null(barheight)){
    barheight = NULL
  } else{
    barheight = unit(barheight, units = "mm")
  }

  if(is.null(barwidth)){
    barwidth = NULL
  } else{
    barwidth = unit(barwidth, units = "mm")
  }



  # Find the first layer with the defined 'color' aesthetic
  # If ggplot includes aesthetics within geom_* this will recognize the class of the argument based on what is inside it
  for (i in seq_along(plot$layers)) {
    if ("colour" %in% names(plot$layers[[i]]$mapping)) {
      colour_var <- plot$layers[[i]]$mapping$colour
      break
    } else {
      colour_var <- NULL
    }
  }


  # If 'colour_var' was not found in any layer, check in the base ggplot call
  if (is.null(colour_var) && !is.null(plot$mapping$colour)) {
    colour_var <- plot$mapping$colour
  }

  # If 'colour_var' is not yet found, returns the graphic without changes
  if (is.null(colour_var)) {
    return(plot)
  }

  # Evaluates whether the variable is numeric.
  # Based on this criterion, we will select whether the palette will be discrete or continuous.
  var_evaluated <- rlang::eval_tidy(colour_var, plot$data)
  auto_discrete_choose <- !is.numeric(var_evaluated)

  # Choose the correct scale
  if (auto_discrete_choose) {

    return(plot +
             list(ggplot2::discrete_scale(aesthetics = "color", scale_name = "ipea", ipea_pal(palette = palette, palette_direction = palette_direction), ...),
                  ggplot2::guides(colour = guide_legend(...))))
  } else {
    scale_manual_pal <- ipea_palette(palette = palette, n = 10, palette_direction = palette_direction)
    return(
      plot +
        list(ggplot2::scale_color_gradientn(
          labels = labels,  # Set the labels for the gradient scale
          colours = scale_manual_pal,  # Set the scale_manual_pal for the gradient scale
          ...),
          guides(color =   guide_coloursteps(
            label.hjust = label.hjust,
            title.hjust = title.hjust,
            barheight = barheight,
            barwidth = barwidth,
            title.position = 'top',
            even.steps = F,...))))
  }
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
#'        to `'Green'`, `'Orange'`, `'Pink'`, `'Red-Blue'`, `'Orange-Blue'`,`'Green-Blue'`,
#'        `'Viridis'`, `'Inferno'`, `'Magma'`, `'Plasma'`, `'Cividis'`.
#' @param palette_direction A logical argument specifying if the ordering of the colors
#'        will follow the default of the palette (when the argument is 1) or if it will
#'        have an inverted ordering (for cases where it is 0).
#' @param decimal.mark The character to be used to indicate the numeric decimal point and
#'        Character used between every 3 digits to separate thousands.
#'        By default, the function uses a comma `","`, following
#'        the format used in Brazilian Portuguese.
#' @param barheight The height of the color gradient bar. This parameter is used
#'        when the direction is set to "horizontal".
#' @param barwidth The width of the color gradient bar. This parameter is used
#'        when the direction is set to "horizontal".
#' @param title.hjust A number specifying horizontal justification of the title text.
#' @param label.hjust A number specifying vertical justification of the title text.
#' @param ... Additional arguments to be passed to the scale_fill_gradientn,
#'        scale_color_gradientn, scale_fill_distiller or scale_color_distiller
#'        function from the ggplot2 package
#'
#'
#' @return A list object be added to a ggplot object to change color pallete.
#'
#' @export
scale_fill_ipea <- function(palette = c('Blue','Green','Orange','Pink','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
                                        'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno','Magma','Plasma','Cividis'),
                             palette_direction = 1,
                             decimal.mark = ",",
                             barheight = NULL, barwidth = NULL,
                             title.hjust = NULL, label.hjust = NULL,
                             ...) {

  structure(list(palette = palette, palette_direction = palette_direction,
                 decimal.mark = decimal.mark, barheight = barheight, barwidth = barwidth,
                 title.hjust = title.hjust, label.hjust = label.hjust,...), class = "scale_ipea")
}

# Definition of the ggplot_add.scale_ipea method
ggplot_add.scale_ipea <- function(object, plot, name, ...){

  # Set arguments
  args <- object
  palette <- args$palette
  palette_direction <- args$palette_direction
  decimal.mark <- args$decimal.mark
  barheight <- args$barheight
  barwidth <- args$barwidth
  title.hjust <- args$title.hjust
  label.hjust <- args$label.hjust

  # Set palette to 'ipea1' if it is not provided, otherwise use the provided value
  palette <-  ifelse(missing(palette),'Blue',palette)


  if (decimal.mark == ",") {
    # Use comma as decimal mark and dot as thousand separator for labels (Brazilian Portuguese)
    labels = scales::label_comma(decimal.mark = ",", big.mark = ".")
  } else if (decimal.mark == "."){
    # Use dot as decimal mark and comma as thousand separator for labels (default)
    labels = scales::label_comma(decimal.mark = ".", big.mark = ",")
  } else {
    stop("Decimal.mark argument must be '.' or ','.")
  }

  # Set default arguments
  label.hjust = ifelse(is.null(label.hjust),0.5,label.hjust)
  title.hjust = ifelse(is.null(title.hjust),0.5,title.hjust)

  if(is.null(barheight)){
    barheight = NULL
  } else{
    barheight = unit(barheight, units = "mm")
  }

  if(is.null(barwidth)){
    barwidth = NULL
  } else{
    barwidth = unit(barwidth, units = "mm")
  }



  # Find the first layer with the defined 'fill' aesthetic
  # If ggplot includes aesthetics within geom_* this will recognize the class of the argument based on what is inside it
  for (i in seq_along(plot$layers)) {
    if ("fill" %in% names(plot$layers[[i]]$mapping)) {
      fill_var <- plot$layers[[i]]$mapping$fill
      break
    } else {
      fill_var <- NULL
    }
  }


  # If 'fill_var' was not found in any layer, check in the base ggplot call
  if (is.null(fill_var) && !is.null(plot$mapping$fill)) {
    fill_var <- plot$mapping$fill
  }

  # If 'fill_var' is not yet found, returns the graphic without changes
  if (is.null(fill_var)) {
    return(plot)
  }

  # Evaluates whether the variable is numeric.
  # Based on this criterion, we will select whether the palette will be discrete or continuous.
  var_evaluated <- rlang::eval_tidy(fill_var, plot$data)
  auto_discrete_choose <- !is.numeric(var_evaluated)

  # Choose the correct scale
  if (auto_discrete_choose) {

    return(plot +
             list(ggplot2::discrete_scale(aesthetics = "fill", scale_name = "ipea", ipea_pal(palette = palette, palette_direction = palette_direction), ...),
                  ggplot2::guides(fill = guide_legend(...))))
  } else {
    scale_manual_pal <- ipea_palette(palette = palette, n = 10, palette_direction = palette_direction)
    return(
      plot +
        list(ggplot2::scale_fill_gradientn(
          labels = labels,  # Set the labels for the gradient scale
          colours = scale_manual_pal,  # Set the scale_manual_pal for the gradient scale
          ...),
          guides(fill =   guide_coloursteps(
            label.hjust = label.hjust,
            title.hjust = title.hjust,
            barheight = barheight,
            barwidth = barwidth,
            title.position = 'top',
            even.steps = F,...))))
  }
}
