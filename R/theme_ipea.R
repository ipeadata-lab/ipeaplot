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
#'        expanded; otherwise there will be no change.
#' @param x_text_angle Numeric. Angle in degrees of the text in the x-axis.
#' @param include_ticks Logical. Whether to include ticks. Defaults to `TRUE`.
#' @param ... Additional arguments to be passed to the `theme` function from the
#'        `ggplot2` package.
#'
#' @return A custom theme for IPEA graphics.
#' @import ggplot2
#' @export

theme_ipea <- function(axis_lines = 'half',
                       axis_values = T,
                       legend.position = 'right',
                       grid.adjust = 'horizontal',
                       x_breaks , y_breaks,
                       expand_x_limit = T,
                       x_text_angle = 0,
                       include_ticks = T,
                       ...){

  hjust <- ifelse(x_text_angle == 0,0.5, 1)
  vjust <- ifelse(x_text_angle == 0,0, 0.5)


  ### check inputs
  checkmate::assert_number(x = x_text_angle)
  checkmate::assert_string(x = axis_lines, pattern = c('none|half|full'))
  checkmate::assert_string(x = grid.adjust, pattern = c('vertical|horizontal'))
  checkmate::assert_string(x = legend.position, pattern = c('right|left|bottom|top|none'))

  color = "#b7bdb7"

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
    axis.text.x  = ggplot2::element_text(angle = x_text_angle,  vjust = vjust, hjust= hjust)
  } else {
    axis.text.x  = ggplot2::element_blank()
    axis.text.y  = ggplot2::element_blank()
  }


    # Define the strip background and text styles for other box options
    strip.background = ggplot2::element_rect(fill = "white")
    strip.text = ggplot2::element_text(colour = 'black',hjust=0)




    theme <- ggplot2::theme(
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
    # Sets the appearance of the axis ticks based on the previous assignment
    axis.ticks.x = axis.ticks.x,
    axis.ticks.y = axis.ticks.y,
    # Adjusts the vertical alignment of the y-axis title
    axis.title.y = ggplot2::element_text(family = "Frutiger-LT-47-LightCn",vjust = 1.5,  lineheight = .6),
    # Adjusts the vertical alignment of the x-axis title
    axis.title.x = ggplot2::element_text(family = "Frutiger-LT-47-LightCn",vjust = -0.4,  lineheight = .6),
    # Sets the appearance of the plot title
    plot.title = ggplot2::element_text(
      # FullName (Frutiger LT 47 Light Condensed). FamillyName (Frutiger LT 47 LightCn)
      family = "Frutiger-LT-47-LightCn",
       hjust = 0,  lineheight = .6,
      margin = margin(0,0,0.5,0, unit = 'mm')
    ),
    # Sets the appearance of the plot subtitle
    plot.subtitle = ggplot2::element_text(
      # FullName (Frutiger LT Std 57 Condensed). FamillyName (Frutiger LT Std)
      family = "Frutiger-LT-Std",
       face = "bold", hjust = 0,  lineheight = .6,
      margin = margin(0,0,2,0, unit = 'mm'),
    ),
    plot.margin=unit(c(.2,.5,.2,.2),"cm"),
    # Spacing between faceted plots
    panel.spacing = unit(4, "mm"),
    # Sets the appearance of the legend text
    #legend.text = ggplot2::element_text(size = 7),
    # Set caption position
    plot.caption = element_text(family = "Frutiger-LT-Std", hjust = 0,  lineheight = .6),
    # Set the horizontal alignment of the legend to center
    legend.justification = "center",
    # Set legend spacing y
    #legend.spacing.y = unit(2, 'mm'),
    # Set horizontal and vertical spacing between legend keys (2 right,2 bottom,1 left)
    legend.spacing = margin(0,2,2,1, unit = 'mm'),
    # Set Margin spacing
    legend.margin= margin(t= unit(3, 'mm')),
    #change legend key size
    #legend.key.size = unit(2, 'mm'),
    # Set key size
    legend.key.size = unit(5,"mm","linewidth"),
    # Adjust haste length
    axis.ticks.length = unit(2, "mm"),
    ...
  )

    nicelimits <- function(x) {
      range(scales::extended_breaks(only.loose = TRUE)(x))
    }

    # breaksFUN <- function(x){
    #   round(seq(min(x), max(x), length.out = x_breaks), 0)
    # }

    if(isTRUE(expand_x_limit)){
      limit = 0.03
    } else{
      limit = 0
    }

    if(missing(y_breaks)){
      scale_y = scale_y_continuous(limits = nicelimits, expand = c( 0, 0 ), labels = scales::label_comma(decimal.mark = ",", big.mark = "."),  ...)
    } else {
      scale_y = scale_y_continuous(limits = nicelimits, expand = c( 0, 0 ), labels = scales::label_comma(decimal.mark = ",", big.mark = "."), breaks = scales::pretty_breaks(n = y_breaks),...)
    }

    if(axis_lines %in% c('none','full')){
      suppressWarnings({
        list(ggplot2::theme_gray(base_family = "Frutiger-LT-55-Roman"),
           theme)
      })

    } else {
      suppressWarnings({list(ggplot2::theme_gray(base_family = "Frutiger-LT-55-Roman"),
           theme,
           scale_y,
           scale_x,
           annotate(geom = 'segment',  y = -Inf, yend = Inf,x = Inf, xend = Inf, color = color, linewidth = 0.25),
           annotate(geom = 'segment', y = Inf, yend = Inf,x = -Inf, xend = Inf, color = color, linewidth = 0.25))
     })
    }



}


