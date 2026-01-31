#' @title Scale color IPEA
#'
#' @description Generate a color palette (continuous or discrete) following the
#'              editorial guidelines used by the Institute for Applied Economic
#'              Research - Ipea.
#' @param palette A character vector specifying the available palette for the
#'        color palette. The default palette are `"Blue"`, but we can also change
#'        to `'Green'`, `'Orange'`, `'Pink'`, `'Pink-Deep'`, `'Red-Blue'`, `'Orange-Blue'`, `'Green-Blue'`,
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
#' @import ggplot2 ggthemes rlang
#' @export
#' @family ggplot2 theme functions
#'
#' @examples
#' # Creating scale for ggplot2 graph using default arguments
#' library(ggplot2)
#' fig_raw <- ggplot() +
#'   geom_point(data = mtcars, aes(x = hp , y = mpg, color = cyl)) +
#'   scale_color_ipea()
#'
#' # Creating scale for ggplot2 graph using green sequential palette
#' fig_raw <- ggplot() +
#'   geom_point(data = mtcars, aes(x = hp , y = mpg, color = cyl)) +
#'   scale_color_ipea(palette = "Green")

# Definition of the scale_color_ipea function
scale_color_ipea <- function(palette = c('Blue','Green','Orange','Pink','Pink-Deep','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
                                         'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno','Magma','Plasma','Cividis'),
                             palette_direction = 1,
                             decimal.mark = ",",
                             barheight = NULL, barwidth = NULL,
                             title.hjust = NULL, label.hjust = NULL,
                             ...) {

  structure(list(palette = palette, palette_direction = palette_direction,
                 decimal.mark = decimal.mark, barheight = barheight, barwidth = barwidth,
                 title.hjust = title.hjust, label.hjust = label.hjust,...), class = "scale_ipea_color")
}

#' @export
#' @method ggplot_add scale_ipea_color
# Definition of the ggplot_add.scale_ipea_color method
ggplot_add.scale_ipea_color <- function(object, plot, object_name, ...){

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
      var_evaluated <- rlang::eval_tidy(colour_var, plot$layers[[i]]$data)
      break
    } else {
      colour_var <- NULL
    }
  }


  # If 'colour_var' was not found in any layer, check in the base ggplot call
  if (is.null(colour_var)) {
    colour_var <- plot$mapping$colour
    var_evaluated <- rlang::eval_tidy(colour_var, plot$data)
  }

  # If 'colour_var' is not yet found, returns the graphic without changes
  if (is.null(colour_var)) {
    return(plot)
  }

  # Evaluates whether the variable is numeric.
  # Based on this criterion, we will select whether the palette will be discrete or continuous.
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
#' @param palette A character vector specifying the available palette for the
#'        color palette. The default palette are `"Blue"`, but we can also change
#'        to `'Green'`, `'Orange'`, `'Pink'`, `'Pink-Deep'`, `'Red-Blue'`, `'Orange-Blue'`, `'Green-Blue'`,
#'        `'Red-Blue-White'`, `'Orange-Blue-White'`, `'Green-Blue-White'`,
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
#' @family ggplot2 theme functions
#'
#' @examples
#' # Creating scale for ggplot2 graph using default arguments
#' library(ggplot2)
#' fig_raw <- ggplot() +
#'   geom_col(data = mtcars, aes(x = hp , y = mpg, fill = cyl)) +
#'   scale_fill_ipea()
#'
#' # Creating scale for ggplot2 graph using green sequential palette
#' fig_raw <- ggplot() +
#'   geom_col(data = mtcars, aes(x = hp , y = mpg, fill = cyl)) +
#'   scale_fill_ipea(palette = "Green")
#'
scale_fill_ipea <- function(palette = c('Blue','Green','Orange','Pink','Pink-Deep','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
                                        'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno','Magma','Plasma','Cividis'),
                            palette_direction = 1,
                            decimal.mark = ",",
                            barheight = NULL, barwidth = NULL,
                            title.hjust = NULL, label.hjust = NULL,
                            ...) {

  structure(list(palette = palette, palette_direction = palette_direction,
                 decimal.mark = decimal.mark, barheight = barheight, barwidth = barwidth,
                 title.hjust = title.hjust, label.hjust = label.hjust,...), class = "scale_ipea_fill")
}

#' @export
#' @method ggplot_add scale_ipea_fill
# Definition of the ggplot_add.scale_ipea_fill method
ggplot_add.scale_ipea_fill <- function(object, plot, object_name, ...){

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
      var_evaluated <- rlang::eval_tidy(fill_var, plot$layers[[i]]$data)
      break
    } else {
      fill_var <- NULL
    }
  }


  # If 'fill_var' was not found in any layer, check in the base ggplot call
  if (is.null(fill_var) && !is.null(plot$mapping$fill)) {
    fill_var <- plot$mapping$fill
    var_evaluated <- rlang::eval_tidy(fill_var, plot$data)
  }

  # If 'fill_var' is not yet found, returns the graphic without changes
  if (is.null(fill_var)) {
    return(plot)
  }

  # Evaluates whether the variable is numeric.
  # Based on this criterion, we will select whether the palette will be discrete or continuous.
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
