#' Ggplot theme for IPEA graphics
#'
#' This function defines a custom theme for IPEA graphics, which provides standardized formatting
#' options for axis lines, text, legends, and panel borders.
#'
#' @param axis A character vector specifying the axis style. Valid options are "none" (no axis lines),
#'   "half" (half-length axis lines), and "full" (full-length axis lines).
#' @param geom A character vector specifying some particularities of geom plot. Valid options are "bar","line", "point", "sf".
#' @param text Logical value indicating whether to show text elements. If TRUE, axis text and ticks
#'   will be displayed in black; otherwise, they will be hidden.
#' @param legend.position A character vector specifying the position of the legend. Valid options are
#'   "right" (default), "left", "top", and "bottom".
#' @param direction Argument that defines whether the graphic specifications will be in the standard horizontal or vertical legend
#' @param ... Additional arguments to be passed to the `theme` function from the `ggplot2` package.
#'
#' @return A custom theme for IPEA graphics.
#' @import ggplot2
#' @export

theme_ipea <- function(axis = c('none','half','full'),
                       geom = c('bar','line','point','sf'),
                       text = T,legend.position,
                       direction = c('horizontal','vertical'),
                       ...){

  if(length(extrafont::fonts()) == 0){
    .onLoad()
  } else {

  }
  geom <- ifelse(missing(geom), 'line', geom)

  # Set the default axis style to "half" if not provided by the user
  axis <- ifelse(missing(axis), 'half', axis)

  # Set the default direction style to "vertical" if not provided by the user
  direction <- ifelse(missing(direction), 'vertical', direction)

  # Set the default legend position to "right" if not provided by the user
  legend.position <- ifelse(missing(legend.position), 'right', legend.position)

  if (axis == "half") {
    # Define the axis line and panel border for "half" style
    axis.line.x = ggplot2::element_line(linewidth = 0.5, linetype = "solid", colour = "black")
    axis.line.y = ggplot2::element_line(linewidth = 0.5, linetype = "solid", colour = "black")
    panel.border = ggplot2::element_blank()
    axis.text.x  = element_text()
    axis.ticks.x = element_line()
    axis.text.y  = element_text()
    axis.ticks.y = element_line()
    # Define the axis text and ticks styles when text is displayed
    axis.text = ggplot2::element_text(colour = "black")
    axis.ticks = ggplot2::element_line(colour = "black")

  } else if (axis == "full") {
    # Define the axis line and panel border for "full" style
    axis.line.x  = ggplot2::element_blank()
    axis.line.y  = ggplot2::element_blank()
    axis.text.x  = element_blank()
    axis.ticks.x = element_blank()
    axis.text.y  = element_blank()
    axis.ticks.y = element_blank()
    panel.border = ggplot2::element_rect(linewidth = 0.5, colour = "black", fill = NA)

  } else {
    # Define the axis line and panel border for other styles
    element_blank = ggplot2::element_blank()
    axis.line.x  = ggplot2::element_blank()
    axis.line.y  = ggplot2::element_blank()
    axis.text.x  = element_blank()
    axis.ticks.x = element_blank()
    axis.text.y  = element_blank()
    axis.ticks.y = element_blank()
    axis.text    = element_blank()
    panel.border = ggplot2::element_blank()

  }

  if (text) {
    # Define the axis text and ticks styles when text is displayed
    axis.text = ggplot2::element_text(colour = "black")
    axis.ticks = ggplot2::element_line(colour = "black")
  } else {
    # Hide axis text and ticks when text is not displayed
    axis.text = ggplot2::element_blank()
    axis.ticks = ggplot2::element_blank()
  }


    # Define the strip background and text styles for other box options
    strip.background = ggplot2::element_rect(fill = "white")
    strip.text = ggplot2::element_text(colour = 'black',hjust=0)

    if(direction == 'vertical'){
      panel.grid.major.x = ggplot2::element_blank()
      panel.grid.major.y = ggplot2::element_line(colour = "#F4F5F6", linewidth = 1)
    }else if (direction == 'horizontal'){
      panel.grid.major.x = ggplot2::element_line(colour = "#F4F5F6", linewidth = 1)
      panel.grid.major.y = ggplot2::element_blank()
    }


    theme <- ggplot2::theme(
    # Sets the background color of the panel to white
    panel.background = ggplot2::element_rect(fill = "white", colour = NA),
    # Sets the panel border based on the previous assignment
    panel.border = panel.border,
    # Sets the major grid lines color and size
    panel.grid.major = ggplot2::element_line(colour = "#F4F5F6", linewidth = 1),
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
    axis.line.y.right = ggplot2::element_line(colour = "#F4F5F6", linewidth = 1),
    # Sets the appearance of the axis text based on the previous assignment
    axis.text = axis.text,
    axis.ticks.x = axis.ticks.x,
    axis.ticks.y = axis.ticks.y,
    # Sets the appearance of the axis ticks based on the previous assignment
    axis.ticks = axis.ticks,
    # Adjusts the vertical alignment of the y-axis title
    axis.title.y = ggplot2::element_text(family = "Frutiger-LT-47-LightCn",vjust = 1.5, size = 8, lineheight = 9.6),
    # Adjusts the vertical alignment of the x-axis title
    axis.title.x = ggplot2::element_text(family = "Frutiger-LT-47-LightCn",vjust = -0.4, size = 8, lineheight = 9.6),
    # Sets the appearance of the plot title
    plot.title = ggplot2::element_text(
      # FullName (Frutiger LT 47 Light Condensed). FamillyName (Frutiger LT 47 LightCn)
      family = "Frutiger-LT-47-LightCn",
      size = 10, lineheight = 12, hjust = 0,
      margin = margin(0,0,0,0, unit = 'mm')
    ),
    # Sets the appearance of the plot subtitle
    plot.subtitle = ggplot2::element_text(
      # FullName (Frutiger LT Std 57 Condensed). FamillyName (Frutiger LT Std)
      family = "Frutiger-LT-Std",
      size = 9, lineheight = 10.8, face = "bold", hjust = 0,
      margin = margin(0,0,3,0, unit = 'mm'),
    ),
    # Spacing between faceted plots
    panel.spacing = unit(4, "mm"),
    # Sets the appearance of the legend text
    legend.text = ggplot2::element_text(size = 7),
    # Set caption position
    plot.caption = element_text(family = "Frutiger-LT-Std", hjust = 0),
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

    if(axis %in% c('none','full')){
      list(ggplot2::theme_gray(base_family = "Frutiger-LT-55-Roman"),
           theme,
           annotate(geom = 'segment', y = -Inf, yend = Inf, color = '#F4F5F6',x = Inf, xend = Inf, linewidth = 1))

    } else if(axis == 'half' & geom == 'bar') {
      list(ggplot2::theme_gray(base_family = "Frutiger-LT-55-Roman"),
           theme,
           scale_y_continuous(expand = expansion(mult = c(0, .1)), breaks = scales::pretty_breaks(n = 10)),
           annotate(geom = 'segment', y = -Inf, yend = Inf, color = '#F4F5F6',x = Inf, xend = Inf, linewidth = 1))
    } else {
      list(ggplot2::theme_gray(base_family = "Frutiger-LT-55-Roman"),
           theme,
           scale_y_continuous(breaks = scales::pretty_breaks(n = 10)),
           annotate(geom = 'segment', y = -Inf, yend = Inf, color = '#F4F5F6',x = Inf, xend = Inf, linewidth = 1))
    }



}


