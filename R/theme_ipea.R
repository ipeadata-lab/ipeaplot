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
#'        boundary should be expanded. If `TRUE`, the x-axis text will be
#'        expanded; otherwise there will be no change
#' @param x_text_angle Numeric. Angle in degrees of the text in the x-axis.
#' @param include_x_text_title Logical. Whether to include x text title Defaults to `TRUE`.
#' @param include_y_text_title Logical. Whether to include x text title. Defaults to `TRUE`.
#' @param include_ticks Logical. Whether to include ticks. Defaults to `TRUE`.
#' @param ... Additional arguments to be passed to the `theme` function from the
#'        `ggplot2` package.
#'
#' @return A custom theme for IPEA graphics.
#' @import ggplot2
#' @export

theme_ipea <- function(axis_lines = 'full',
                       axis_values = T,
                       legend.position = 'right',
                       grid.adjust = 'horizontal',
                       x_breaks , y_breaks,
                       expand_x_limit = T,
                       x_text_angle = 0,
                       include_x_text_title = T,
                       include_y_text_title = T,
                       include_ticks = T,
                       ...){

  hjust <- ifelse(x_text_angle == 0,0.5, 1)
  vjust <- ifelse(x_text_angle == 0,0, 0.5)


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
    hjust <- ifelse(x_text_angle == 0,0.5, 1)
    vjust <- ifelse(x_text_angle == 0,3, 0.5)
  }

  if(axis_values == T){
    axis.text.y  = ggplot2::element_text()
    #axis.text.x  = ggplot2::element_text(angle = x_text_angle,  hjust= hjust, margin = margin(b = vjust,unit = 'mm'))
    axis.text.x  = ggplot2::element_text(family = "Frutiger-LT-47-LightCn", angle = x_text_angle,  hjust = hjust, vjust = margin(b = vjust,unit = 'mm'))
  } else if(axis_values == F){
    axis.text.x  = ggplot2::element_blank()
    axis.text.y  = ggplot2::element_blank()
  } else {
    stop("Argument axis_values must be TRUE or FALSE")
  }


  if(include_x_text_title == T){
    axis.title.x  = ggplot2::element_text(family = "Frutiger-LT-47-LightCn",margin = margin(t = 4, r = 0, b = 0, l = 0, unit = 'mm'))
  } else if(include_x_text_title == F){
    axis.title.x  = ggplot2::element_blank()
  } else {
    stop("Argument include_x_text_title must be TRUE or FALSE")
  }

  if(include_y_text_title == T){
    axis.title.y  = ggplot2::element_text(family = "Frutiger-LT-47-LightCn",margin = margin(t = 0, r = 4, b = 0, l = 0, unit = 'mm'))
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
    text = ggplot2::element_text(family = "Frutiger-LT-55-Roman"),
    #text = ggplot2::element_text(family = "Frutiger-LT-55-Roman",size = unit(6, unit = 'mm')),
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
      family = "Frutiger-LT-47-LightCn",
      hjust = 0,  lineheight = .5,
      margin = margin(0,0,1,0, unit = 'mm')
    ),
    # Sets the appearance of the plot subtitle
    plot.subtitle = ggplot2::element_text(
      # FullName (Frutiger LT Std 57 Condensed). FamillyName (Frutiger LT Std)
      family = "Frutiger-LT-55-Roman",
      face = "bold", hjust = 0,  lineheight = 1,
      margin = margin(0,0,2,0, unit = 'mm'),
    ),
    # axis.text = ggplot2::element_text(family = "Frutiger-LT-47-LightCn", size = unit(6, "pt")),
    plot.margin=unit(c(.2,.5,.2,.2),"cm"),
    # Spacing between faceted plots
    panel.spacing = unit(4, "mm"),
    # Sets the appearance of the legend text
    #legend.text = ggplot2::element_text(size = 7),
    # Set caption position
    plot.caption = ggplot2::element_text(family = "Frutiger-LT-Std", hjust = 0, vjust = 0,  lineheight = 1.25),
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




}

nicelimits <- function(x) {
  range(scales::extended_breaks(only.loose = TRUE)(x))
}


my_pretty_breaks <- function(n_breaks = 5, na.rm = TRUE,current_expand = 0.05, sd = 0.05,  ...) {
  function(x) {
    if (na.rm) {
      x <- na.omit(x)
    }
    if (length(unique(x)) == 1) {
      return(unique(x))
    }

    # Aplica a expansão
    range_x <- range(x)
    range_x <- c(0.55, 10.45)

    # Calcula o valor de expansão atual
    current_expand_amount <- diff(range_x) * current_expand / (1 + 2 * current_expand)

    # Contração do intervalo para remover a expansão
    contracted_range <- c(range_x[1] + current_expand_amount, range_x[2] - current_expand_amount)

    # Calcula os breaks com o intervalo contraído
    breaks <- seq(from = contracted_range[1], to = contracted_range[2], length.out = n_breaks)


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

    round(breaks, t)
  }

  # Definição da função auxiliar de escala
  scale_auto_ipea <- function() {
    structure(list(), class = c("scale_y_auto_ipea", "scale_y_auto", "scale"))
  }

  # Adiciona a função auxiliar ao tema para execução via ggplot_add
  list(theme = list(...), scale_y_auto = scale_y_auto_ipea())
}

# Método ggplot_add para a classe 'scale_y_auto_ipea'
ggplot_add.scale_auto_ipea <- function(object, plot, name, ...) {
  # Detecção do tipo de dados de 'y' e aplicação da escala apropriada
  data <- plot$data
  y_var <- eval(plot$mapping$y, envir = data)
  x_var <- eval(plot$mapping$x, envir = data)

  scale_x <- if(is.numeric(x_var)) {
    if(is.null(object$x_breaks)) {
      scale_x_continuous()
    } else {
      #scale_x_continuous(limits = nicelimits(data[[as.character(plot$mapping$y)]]), expand = c(0, 0), labels = scales::label_comma(decimal.mark = ",", big.mark = "."), breaks = my_pretty_breaks(n = object$x_breaks))
      scale_x_continuous(expand = expansion(mult = c(ifelse(object$expand_x_limit, 0.05, 0), 0.05)), labels = scales::label_comma(decimal.mark = ",", big.mark = ""), breaks = my_pretty_breaks(n_breaks = object$x_breaks))
    }
  } else {
    scale_x_discrete(labels = scales::label_comma(decimal.mark = ",", big.mark = "."))
  }

  scale_y <- if(is.numeric(y_var)) {
    if(is.null(object$y_breaks)) {
      scale_y_continuous()
    } else {
      scale_y_continuous(limits = nicelimits(data[[as.character(plot$mapping$y)]]), expand = c(0, 0), labels = scales::label_comma(decimal.mark = ",", big.mark = "."), breaks = my_pretty_breaks(n = object$y_breaks))
    }
  } else {
    scale_y_discrete(labels = scales::label_comma(decimal.mark = ",", big.mark = "."))
  }

  # Aplica a escala 'y' ao plot
  plot <- plot + scale_y + scale_x

  # # Configuração e aplicação da escala 'x', se necessário
  # if(!is.null(object$x_breaks)) {
  #   scale_x <- scale_x_continuous(expand = expansion(mult = c(ifelse(object$expand_x_limit, 0.05, 0), 0.05)), labels = scales::label_comma(decimal.mark = ",", big.mark = ""), breaks = my_pretty_breaks(n_breaks = object$x_breaks))
  #   plot <- plot + scale_x
  # }

  # Anotações baseadas em 'axis_lines'
  if(object$axis_lines %in% c('none', 'full')) {
    plot <- plot + annotate("segment", x = -Inf, xend = Inf, y = -Inf, yend = Inf, colour = "black", size = 0.5) +
      annotate("segment", x = -Inf, xend = Inf, y = Inf, yend = Inf, colour = "black", size = 0.5)
  }
  # Retorna o plot modificado
  return(plot)
}
