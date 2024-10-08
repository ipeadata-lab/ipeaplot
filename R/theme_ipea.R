#' Ggplot theme for Ipea charts and figures
#'
#' @description Applies a custom theme for ggplot figures following the editorial
#' guidelines used by the Institute for Applied Economic Research - Ipea. The
#' function includes standardized formatting of options for axis lines, text,
#'
#' @param axis_lines A character vector specifying the axis style. Valid options are
#'        `"none"` (no axis lines), `"full"` (full-length axis lines), and
#'        `"half"` (half-length axis lines), the default.
#' @param axis_values Logical value indicating whether to show text elements. If `TRUE`,
#'        axis text will be displayed in black; otherwise, they will
#'        be hidden.
#' @param legend.position A character vector specifying the position of the
#'        legend. Valid options are `"right"` (default), `"left"`, `"top"`, and
#'        `"bottom"`.
#' @param grid.adjust Defines whether the grid lines should be `"horizontal"`
#'       (default) or `"vertical"`.
#' @param x_breaks Numeric. The number of breaks on the x-axis
#' @param y_breaks Numeric. The number of breaks on the y-axis
#' @param expand_x_limit Logical value that indicates whether the x-axis
#'        boundary should be expanded. If `TRUE`, the x-axis limits will be
#'        expanded; otherwise there will be no change
#' @param expand_y_limit Logical value that indicates whether the y-axis
#'        boundary should be expanded. If `TRUE`, the x-axis limits will be
#'        expanded; otherwise there will be no change
#' @param x_text_angle Numeric. Angle in degrees of the text in the x-axis.
#' @param include_x_text_title Logical. Whether to include x text title Defaults to `TRUE`.
#' @param include_y_text_title Logical. Whether to include x text title. Defaults to `TRUE`.
#' @param include_ticks Logical. Whether to include ticks. Defaults to `TRUE`.
#' @param ... Additional arguments to be passed to the `theme` function from the
#'        `ggplot2` package.
#'
#' @return A custom theme for IPEA graphics.
#' @import ggplot2 ggthemes rlang
#' @export
#' @family ggplot2 theme functions
#'
#' @examples
#' # Creating theme for ggplot2 graph using default arguments
#' library(ggplot2)
#' fig_raw <- ggplot() +
#'   geom_col(data = mtcars, aes(x = hp , y = mpg, fill = cyl)) +
#'   theme_ipea()
#'




theme_ipea <- function(axis_lines = 'full',
                       axis_values = TRUE,
                       legend.position = 'right',
                       grid.adjust = 'horizontal',
                       x_breaks = NULL, # Valor padrão definido como NULL
                       y_breaks = NULL, # Valor padrão definido como NULL
                       expand_x_limit = TRUE,
                       expand_y_limit = TRUE,
                       x_text_angle = 0,
                       include_x_text_title = TRUE,
                       include_y_text_title = TRUE,
                       include_ticks = TRUE,
                       ...){

  structure(list(axis_lines = axis_lines,
                 axis_values = axis_values,
                 legend.position = legend.position, grid.adjust = grid.adjust,
                 x_breaks = x_breaks, y_breaks = y_breaks,
                 expand_x_limit = expand_x_limit,expand_y_limit = expand_y_limit,
                 x_text_angle = x_text_angle,
                 include_x_text_title = include_x_text_title, include_y_text_title = include_y_text_title,
                 include_ticks = include_ticks, ...), class = "scale_auto_ipea")

}

nicelimits <- function(x) {
  range(scales::extended_breaks(only.loose = TRUE)(x))
}

my_pretty_breaks <- function(x, n_breaks = NULL, na.rm = TRUE,sd = 0.05,  ...) {


  if(!is.null(n_breaks)){


    # Aplica a expansão
    range_x <- range(x)
    #range_x <- c(0.55, 10.45)

    # Calcula os breaks com o intervalo contraído
    breaks <- seq(from = range_x[1], to = range_x[2], length.out = n_breaks)

    t <- 0
    len <- length(unique(round(breaks, t)))
    while(len != n_breaks && t < 10) {  # Corrigido aqui: n para n_breaks
      t <- t + 1
      len <- length(unique(round(breaks, t)))
    }

    temp <- round(breaks, t)
    intervals <- c(diff(temp))

    while(any(sd(intervals) > sd | is.na(sd(intervals))) && t < 10){
      t <- t + 1
      temp <- round(breaks, t)
      intervals <- c(diff(temp))
    }

    if(max(nchar(x)) >= 3){

      temp <- unique(ceiling(breaks / 5) * 5)

      if(length(temp) != n_breaks){

      } else {
        breaks <- temp
      }

      return(round(breaks, 0))
    } else {
      return(round(breaks, t))
    }

  } else {

    # Aplica a expansão
    range_x <- range(x)

    # Calcula os breaks com o intervalo contraído
    breaks <- seq(from = range_x[1], to = range_x[2], length.out = 5)

    t <- 0
    temp <- round(breaks, t)
    intervals <- c(diff(temp))
    intervals <- summary(intervals)[3]
    breaks <- seq(from = range_x[1], to = range_x[2], by = intervals)
    breaks <- c(breaks,breaks[length(breaks)] + intervals)
  }

}

#' @export
#' @method ggplot_add scale_auto_ipea
# Método ggplot_add para a classe 'scale_auto_ipea'
ggplot_add.scale_auto_ipea <- function(object, plot, object_name, ...) {
  # Extração de argumentos do objeto
  args <- object
  axis_lines <- args$axis_lines
  axis_values <- args$axis_values
  legend.position <- args$legend.position
  grid.adjust <- args$grid.adjust
  x_breaks <- args$x_breaks
  y_breaks <- args$y_breaks
  expand_x_limit <- args$expand_x_limit
  expand_y_limit <- args$expand_y_limit
  x_text_angle <- args$x_text_angle
  include_x_text_title <- args$include_x_text_title
  include_y_text_title <- args$include_y_text_title
  include_ticks <- args$include_ticks




  hjust <- ifelse(x_text_angle == 0,0.5, 0.8)
  vjust <- ifelse(x_text_angle == 0,0, 0.5)
  vjust_angle <- ifelse(x_text_angle == 0,-1, 0.5)


  ### check inputs
  checkmate::assert_number(x = x_text_angle)
  checkmate::assert_string(x = axis_lines, pattern = c('none|half|full'))
  checkmate::assert_string(x = grid.adjust, pattern = c('vertical|horizontal'))
  checkmate::assert_string(x = legend.position, pattern = c('right|left|bottom|top|none'))

  color = "gray75"

  if(grid.adjust == 'horizontal'){
    panel.grid.major.x = ggplot2::element_blank()
    panel.grid.major.y = ggplot2::element_line(colour = color, linewidth = 0.25)

  } else if (grid.adjust == 'vertical'){
    panel.grid.major.x = ggplot2::element_line(colour = color, linewidth = 0.25)
    panel.grid.major.y = ggplot2::element_blank()
  }


  if (axis_lines == "half") {
    # Define the axis line and panel border for "half" style
    axis.line.x = ggplot2::element_line(linewidth = 0.25, linetype = "solid", colour = "black")
    axis.line.y = ggplot2::element_line(linewidth = 0.25, linetype = "solid", colour = "black")
    axis.ticks.x = ggplot2::element_line(colour = "black", linewidth = 0.25)
    axis.ticks.y = ggplot2::element_line(colour = "black", linewidth = 0.25)
    panel.border = ggplot2::element_blank()

  } else if (axis_lines == "full") {
    # Define the axis line and panel border for "full" style
    axis.line.x = ggplot2::element_line(linewidth = 0.25, linetype = "solid", colour = "black")
    axis.line.y = ggplot2::element_line(linewidth = 0.25, linetype = "solid", colour = "black")
    axis.ticks.x = ggplot2::element_line(colour = "black", linewidth = 0.25)
    axis.ticks.y = ggplot2::element_line(colour = "black", linewidth = 0.25)
    panel.border = ggplot2::element_rect(linewidth = 0.25, colour = "black", fill = NA)

  } else if (axis_lines == "none") {
    # Define the axis line and panel border for other styles
    axis.line.x  = ggplot2::element_blank()
    axis.line.y  = ggplot2::element_blank()
    axis.ticks.x = ggplot2::element_blank()
    axis.ticks.y = ggplot2::element_blank()
    axis.text.x  = ggplot2::element_blank()
    axis.text.y  = ggplot2::element_blank()
    panel.grid.major.x = ggplot2::element_blank()
    panel.grid.major.y = ggplot2::element_blank()
    panel.border = ggplot2::element_blank()

  } else {
    stop("Argument axis_lines must be 'half', 'full' or 'none'.")
  }


  if(isFALSE(include_ticks)){
    axis.ticks.x = ggplot2::element_blank()
    axis.ticks.y = ggplot2::element_blank()
    hjust <- ifelse(x_text_angle == 0,0.5, 0.8)
    vjust <- ifelse(x_text_angle == 0,3, 0.5)
    vjust_angle <- ifelse(x_text_angle == 0,-1, 0)
  }

  if(axis_values == T){
    axis.text.y  = ggplot2::element_text()
    # axis.text.x  = ggplot2::element_text(angle = x_text_angle,  hjust= hjust, margin = margin(b = vjust,unit = 'mm'))
    axis.text.x  = ggplot2::element_text(family = "sans", angle = x_text_angle,color = 'black',
                                         hjust = hjust, vjust = vjust_angle,margin = margin(b = vjust,unit = 'mm'))
  } else if(axis_values == F){
    axis.text.x  = ggplot2::element_blank()
    axis.text.y  = ggplot2::element_blank()
  } else {
    stop("Argument axis_values must be TRUE or FALSE")
  }


  if(include_x_text_title == T){
    axis.title.x  = ggplot2::element_text(family = "sans",margin = margin(t = 4, r = 0, b = 0, l = 0, unit = 'mm'))
  } else if(include_x_text_title == F){
    axis.title.x  = ggplot2::element_blank()
  } else {
    stop("Argument include_x_text_title must be TRUE or FALSE")
  }

  if(include_y_text_title == T){
    axis.title.y  = ggplot2::element_text(family = "sans",margin = margin(t = 0, r = 4, b = 0, l = 0, unit = 'mm'))
  } else if(include_y_text_title == F){
    axis.title.y  = ggplot2::element_blank()
  } else {
    stop("Argument include_y_text_title must be TRUE or FALSE")
  }

  if(legend.position == 'bottom'){
    # legend.box.spacing = unit(-1, "mm")
    # legend.box.margin=margin(r = -10,l = -10,b = -10,t = -10)
    # legend.text = ggplot2::element_text(margin = margin(r = 4, l = 1, b = 0, t = 0,  unit = 'mm'))
    legend.box.spacing = unit(0.2, "cm")  # Valor padrão para legend.box.spacing
    legend.text        = ggplot2::element_text(size = 10, color = "black")  # Valor padrão para legend.text
    legend.box.margin  = margin(0, 0, 0, 0)  # Valor padrão para legend.box.margin
  } else{
    legend.box.spacing = unit(0.2, "cm")  # Valor padrão para legend.box.spacing
    legend.text        = ggplot2::element_text(size = 10, color = "black")  # Valor padrão para legend.text
    legend.box.margin  = margin(0, 0, 0, 0)  # Valor padrão para legend.box.margin
  }


  # Define the strip background and text styles for other box options
  strip.background = ggplot2::element_rect(fill = "white")
  strip.text       = ggplot2::element_text(colour = 'black',hjust=0)




  theme <- ggplot2::theme(
    text = ggplot2::element_text(family = "sans"),
    #text = ggplot2::element_text(family = "sans",size = unit(6, unit = 'mm')),
    # Sets the background color of the panel to white
    panel.background = ggplot2::element_rect(fill = "white", colour = NA),
    # Sets the panel border based on the previous assignment
    panel.border = panel.border,
    # Sets the major grid lines color and size
    #panel.grid.major = ggplot2::element_line(colour = color, linewidth = 0.25),
    # Sets the minor grid lines color and size
    panel.grid.minor = ggplot2::element_line(colour = "white", linewidth = 1),
    # Hides the major grid lines on the x-axis
    panel.grid.major.x = panel.grid.major.x,
    # Hides the major grid lines on the x-axis
    panel.grid.major.y = panel.grid.major.y,
    # Sets the position of the legend based on the previous assignment
    legend.position = legend.position,
    # Sets the appearance of the legend key
    legend.key = ggplot2::element_rect(colour = "transparent", fill = "white"),
    # Sets the background color of the facet strip based on the previous assignment
    strip.background = strip.background,
    # Sets the text color of the facet strip based on the previous assignment
    strip.text = strip.text,
    # Sets the appearance of the x-axis line based on the previous assignment
    axis.line.x = axis.line.x,
    # Sets the appearance of the y-axis line based on the previous assignment
    axis.line.y = axis.line.y,
    axis.line.y.right = ggplot2::element_line(colour = color, linewidth = 0.25),
    # Sets the appearance of the axis text based on the previous assignment
    axis.text.x = axis.text.x,
    axis.text.y = axis.text.y,
    # Change title x
    axis.title.x = axis.title.x,
    axis.title.y = axis.title.y,
    # Sets the appearance of the axis ticks based on the previous assignment
    axis.ticks.x = axis.ticks.x,
    axis.ticks.y = axis.ticks.y,
    # Sets the appearance of the plot title
    plot.title = ggplot2::element_text(
      # FullName (Frutiger LT 47 Light Condensed). FamillyName (Frutiger LT 47 LightCn)
      family = "sans",
      hjust = 0,  lineheight = .5,
      margin = margin(0,0,1,0, unit = 'mm')
    ),
    # Sets the appearance of the plot subtitle
    plot.subtitle = ggplot2::element_text(
      # FullName (Frutiger LT Std 57 Condensed). FamillyName (Frutiger LT Std)
      family = "sans",
      face = "bold", hjust = 0,  lineheight = 1,
      margin = margin(0,0,2,0, unit = 'mm'),
    ),
    # axis.text = ggplot2::element_text(family = "sans", size = unit(6, "pt")),
    plot.margin=unit(c(.2,.5,.2,.2),"cm"),
    # Spacing between faceted plots
    panel.spacing = unit(4, "mm"),
    # Sets the appearance of the legend text
    #legend.text = ggplot2::element_text(size = 7),
    # Set caption position
    plot.caption = ggplot2::element_text(family = "sans", hjust = 0, vjust = 0,  lineheight = 1.25),
    # Set the horizontal alignment of the legend to center
    legend.justification = "center",
    # Set legend spacing y
    # Set horizontal and vertical spacing between legend keys (2 right,2 bottom,1 left)
    #legend.spacing = margin(t = 1,4,4,1, unit = 'mm'),
    # Set Margin spacing
    legend.box.spacing = legend.box.spacing,
    #legend.margin  = margin(t = 0,r = 15, b= 0,l = 1, unit = 'mm'),
    #change legend key size
    # legend.key.size = unit(1, 'mm'),
    legend.box.margin =  legend.box.margin,
    # Set key size
    # legend.spacing.x = unit(4, 'mm'),
    # legend.spacing.y = unit(4, 'mm'),
    legend.text = legend.text,
    legend.key.size = unit(4,"mm","linewidth"),
    # Adjust haste length
    axis.ticks.length = unit(2, "mm"),
    ...
  )

  # Verificação do tipo de dados para x_var no plot
  x_var <- plot$mapping$x
  x_var <- rlang::eval_tidy(x_var, plot$data)

  # Verificação do tipo de dados para y_var no plot
  y_var <- plot$mapping$y
  y_var <- rlang::eval_tidy(y_var, plot$data)

  for (i in seq_along(plot$layers)) {
    if ("x" %in% names(plot$layers[[i]]$mapping) & !is.null(nrow(plot$layers[[i]]$data))) {

      x_var_temp <- plot$layers[[i]]$mapping$x
      x_var_temp <- rlang::eval_tidy(x_var_temp, plot$layers[[i]]$data)
      break

    } else if("x" %in% names(plot$layers[[i]]$mapping) & is.null(nrow(plot$layers[[i]]$data))){

      x_var_temp <- plot$layers[[i]]$mapping$x
      x_var_temp <- rlang::eval_tidy(x_var_temp, plot$data)
      break

    } else {
      x_var_temp <- plot$mapping$x
      x_var_temp <- rlang::eval_tidy(x_var_temp, plot$data)
    }

  }


  for (i in seq_along(plot$layers)) {
    if ("y" %in% names(plot$layers[[i]]$mapping) & !is.null(nrow(plot$layers[[i]]$data))) {

      y_var_temp <- plot$layers[[i]]$mapping$y
      y_var_temp <- rlang::eval_tidy(y_var_temp, plot$layers[[i]]$data)
      break

    } else if("y" %in% names(plot$layers[[i]]$mapping) & is.null(nrow(plot$layers[[i]]$data))){

      y_var_temp <- plot$layers[[i]]$mapping$y
      y_var_temp <- rlang::eval_tidy(y_var_temp, plot$data)
      break

    } else {
      y_var_temp <- plot$mapping$y
      y_var_temp <- rlang::eval_tidy(y_var_temp, plot$data)
    }

  }

  if(is.null(x_var)){
    x_var <- x_var_temp
  } else{
    x_var <- x_var
  }

  if(is.null(y_var)){
    y_var <- y_var_temp
  } else{
    y_var <- y_var
  }



  test <- NULL
  for (i in seq_along(plot$layers)) {
    temp <- ifelse(grepl('bar',plot$layers[[i]]$constructor),'Bar chart',
                   ifelse(grepl('ribbon',plot$layers[[i]]$constructor),'Ribbon',
                          ifelse(grepl('area',plot$layers[[i]]$constructor),'Area',
                                 ifelse(grepl('histogram',plot$layers[[i]]$constructor),'Histogram',
                                        ifelse(grepl('density',plot$layers[[i]]$constructor),'Density',NA)))))
    temp <- temp[!is.na(temp)]
    test <- rbind(test,temp)


  }

  test <- unique(test)

  if(length(test) == 1){
    if(grepl('Bar',test)){

    } else {
      test = paste0(test,' graph')
    }

  } else if(length(test) > 1){
    test[length(test)] <- paste0('and ',test[length(test)],' graph')

    if(grepl('Bar',test)){
      test <- gsub(' Chart','',test)
    }

  } else {
    test <- NULL
  }


  if(expand_y_limit == TRUE & length(test) > 0){
    message(gsub(", and "," and ",paste0('Warning message:\n  Due to the existence of a ',paste(test, collapse = ", "),', the `expand_y_limit` argument will be converted to FALSE')))
    expand_y_limit = FALSE
  }

  if(!is.null(x_breaks) & length(test[grepl('Bar',test)]) > 0){
    message(gsub(", and "," and ",paste0('Warning message:\n  Due to the existence of a Bar chart the `x_breaks` argument will be converted to the number of options available')))
    x_breaks = length(unique(x_var))
  }

  if(!is.null(x_breaks) & length(test) > 0 & length(test[grepl('Bar',test)]) == 0 & length(unique(x_var)) <= 20){
    message(gsub(", and "," and ",paste0('Warning message:\n  Due to the existence of a ',paste(test, collapse = ", "),'and the number of values on the x-axis is small the `x_breaks` argument will be converted to the number of options available')))
    x_breaks = length(unique(x_var))
  }

  # Aplicação condicional das escalas
  # Escala para x_var
  if (!is.null(x_breaks) && is.numeric(x_var)) {
    plot <- plot + scale_x_continuous(
      breaks = my_pretty_breaks(x_var,x_breaks),
      expand = expansion(mult = c(ifelse(expand_x_limit == TRUE, 0.03, 0),
                                  ifelse(expand_x_limit == TRUE, 0.03, 0))),
      labels = scales::label_comma(decimal.mark = ",", big.mark = "")
    )
  } else if(is.null(x_breaks) && is.numeric(x_var)) {
    plot <- plot + scale_x_continuous(
      breaks = my_pretty_breaks(x_var),
      expand = expansion(mult = c(ifelse(expand_x_limit == TRUE, 0.03, 0),
                                  ifelse(expand_x_limit == TRUE, 0.03, 0))),
      labels = scales::label_comma(decimal.mark = ",", big.mark = "")
    )
  } else {

  }


  # Escala para y_var
  if (!is.null(args$y_breaks) && is.numeric(y_var)) {
    plot <- plot + scale_y_continuous(
      breaks = my_pretty_breaks(y_var,y_breaks),
      labels = scales::label_comma(decimal.mark = ",", big.mark = "."),
      expand = expansion(mult = c(ifelse(expand_y_limit == TRUE, 0.03, 0),  0.1)),
    )
  } else {
    plot <- plot + scale_y_continuous(
      labels = scales::label_comma(decimal.mark = ",", big.mark = "."),
      expand = expansion(mult = c(ifelse(expand_y_limit == TRUE, 0.03, 0), 0.1)),
    )
  }

  plot <- plot + theme



  return(plot)
}
