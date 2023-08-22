#' Ggplot theme for Ipea charts and figures
#'
#' @description Applies a custom theme for ggplot figures following the editorial
#' guidelines used by the Institute for Applied Economic Research - Ipea. The
#' function includes standardized formatting of options for axis lines, text,
#'
#' @param axis A character vector specifying the axis style. Valid options are
#'        `"none"` (no axis lines), `"half"` (half-length axis lines), and
#'        `"full"` (full-length axis lines).
#' @param geom A character vector specifying some particularities of geom plot.
#'        Valid options are `"bar"`,`"line"`, `"point"`, `"sf"`.
#' @param text Logical value indicating whether to show text elements. If `TRUE`,
#'        axis text and ticks will be displayed in black; otherwise, they will
#'        be hidden.
#' @param legend.position A character vector specifying the position of the
#'        legend. Valid options are `"right"` (default), `"left"`, `"top"`, and
#'        `"bottom"`.
#' @param grid.adjust Argument that defines whether the graphic specifications
#'        will be in the standard horizontal or vertical legend.
#' @param x Manually set the initial x-axis value
#' @param y Manually set the initial y-axis value
#' @param yend Manually set the y-axis threshold value
#' @param xend Manually set the x-axis threshold value
#' @param x_breaks Specify values break amounts on the x-axis
#' @param y_breaks Specify values break amounts on the y-axis
#' @param bar_adjust Specific x-axis tweak for bar charts that should stick to the border.
#' @param angle Arrange x-axis angle
#' @param adjust_ticks Option to remove ticks and adjust chart.
#' @param ... Additional arguments to be passed to the `theme` function from the
#'        `ggplot2` package.
#'
#' @return A custom theme for IPEA graphics.
#' @import ggplot2
#' @export

theme_ipea <- function(axis = c('none','half','full'),
                       geom = c('bar','line','point','sf','pie'),
                       text = T,legend.position,
                       grid.adjust = c('horizontal','vertical'),
                       x, y, yend,xend,
                       x_breaks , y_breaks,
                       bar_adjust = F,angle,
                       adjust_ticks = F,
                       ...){

  y <- ifelse(missing(y), -Inf, y)
  x <- ifelse(missing(x), Inf, x)
  yend <- ifelse(missing(yend), Inf, yend)
  xend <- ifelse(missing(xend), Inf, xend)
  y_breaks <- ifelse(missing(y_breaks), 10, y_breaks)
  bar_adjust <- ifelse(bar_adjust == T,.1,Inf)

  angle <- ifelse(missing(angle),0, angle)
  hjust <- ifelse(angle == 0,0.5, 1)
  vjust <- ifelse(angle == 0,0, 0.5)



  geom <- ifelse(missing(geom), 'line', geom)

  # Set the default axis style to "half" if not provided by the user
  axis <- ifelse(missing(axis), 'half', axis)

  # Set the default grid.adjust style to "vertical" if not provided by the user
  grid.adjust <- ifelse(missing(grid.adjust), 'vertical', grid.adjust)

  # Set the default legend position to "right" if not provided by the user
  legend.position <- ifelse(missing(legend.position), 'right', legend.position)

  if(geom == 'pie'){
    color = NA
  } else {
    color = "#b7bdb7"
  }

  if (axis == "half") {
    # Define the axis line and panel border for "half" style
    axis.line.x = ggplot2::element_line(linewidth = 0.25, linetype = "solid", colour = "black")
    axis.line.y = ggplot2::element_line(linewidth = 0.25, linetype = "solid", colour = "black")
    panel.border = ggplot2::element_blank()
    axis.text.x  = ggplot2::element_text(angle = angle,  vjust = vjust, hjust= hjust)
    axis.ticks.x = ggplot2::element_line()
    axis.text.y  = ggplot2::element_text()
    axis.ticks.y = ggplot2::element_line()
    axis.ticks =   ggplot2::element_line()
    panel.grid   = ggplot2::element_line()
    # Define the axis text and ticks styles when text is displayed
    axis.text = ggplot2::element_text(colour = "black")
    axis.ticks = ggplot2::element_line(colour = "black", linewidth = 0.25)

  } else if (axis == "full") {
    # Define the axis line and panel border for "full" style
    axis.line.x  = ggplot2::element_blank()
    axis.line.y  = ggplot2::element_blank()
    axis.text.x  = ggplot2::element_blank()
    axis.ticks.x = ggplot2::element_blank()
    axis.text.y  = ggplot2::element_blank()
    axis.ticks.y = ggplot2::element_blank()
    axis.ticks =   ggplot2::element_line()
    panel.grid   = ggplot2::element_line()
    panel.border = ggplot2::element_rect(linewidth = 0.25, colour = "black", fill = NA)

  } else if (axis == "none") {
    # Define the axis line and panel border for other styles
    element_blank = ggplot2::element_blank()
    axis.line.x  = ggplot2::element_blank()
    axis.line.y  = ggplot2::element_blank()
    axis.ticks.x = ggplot2::element_blank()
    axis.ticks.y = ggplot2::element_blank()
    axis.ticks   = ggplot2::element_blank()
    axis.text.x  = ggplot2::element_blank()
    axis.text.y  = ggplot2::element_blank()
    axis.text    = ggplot2::element_blank()
    panel.grid   = ggplot2::element_blank()
    panel.border = ggplot2::element_blank()

  }

  if (text) {
    # Define the axis text and ticks styles when text is displayed
    axis.text = ggplot2::element_text(colour = "black")
    axis.ticks = ggplot2::element_line(colour = "black", linewidth = 0.25)
  } else {
    # Hide axis text and ticks when text is not displayed
    axis.text = ggplot2::element_blank()
    axis.ticks = ggplot2::element_blank()
  }

  if(adjust_ticks == T){
    axis.ticks.x = ggplot2::element_blank()
    hjust <- ifelse(angle == 0,0.5, -4)
    vjust <- ifelse(angle == 0,4, 0.5)
    axis.text.x  = ggplot2::element_text(angle = angle,  vjust = vjust, hjust= hjust)
  }


    # Define the strip background and text styles for other box options
    strip.background = ggplot2::element_rect(fill = "white")
    strip.text = ggplot2::element_text(colour = 'black',hjust=0)

    if(grid.adjust == 'vertical'){
      panel.grid.major.x = ggplot2::element_blank()
      panel.grid.major.y = ggplot2::element_line(colour = color, linewidth = 0.25)
    }else if (grid.adjust == 'horizontal'){
      panel.grid.major.x = ggplot2::element_line(colour = color, linewidth = 0.25)
      panel.grid.major.y = ggplot2::element_blank()
    }


    theme <- ggplot2::theme(
    # Sets the background color of the panel to white
    panel.background = ggplot2::element_rect(fill = "white", colour = NA),
    # Sets the panel border based on the previous assignment
    panel.border = panel.border,
    # Sets the major grid lines color and size
    panel.grid.major = ggplot2::element_line(colour = color, linewidth = 0.25),
    # Sets the minor grid lines color and size
    panel.grid.minor = ggplot2::element_line(colour = "white", linewidth = 1),
    # Hides the major grid lines on the x-axis
    panel.grid.major.x = panel.grid.major.x,
    # Hides the major grid lines on the x-axis
    panel.grid.major.y = panel.grid.major.y,
    #
    panel.grid = panel.grid,
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
    axis.text = axis.text,
    axis.text.x = axis.text.x,
    axis.text.y = axis.text.y,
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

    if(missing(x_breaks)){
      scale_x = NULL
    } else {
      if(axis %in% c('none','full')){
        scale_x = scale_x_continuous(breaks = scales::pretty_breaks(n = x_breaks))
        } else if(axis == 'half' & geom == 'bar'){
          scale_x = scale_x_continuous(expand = expansion(mult = c(0, 0)), breaks = scales::pretty_breaks(n = x_breaks))
          } else{
            scale_x = scale_x_continuous(breaks = scales::pretty_breaks(n = x_breaks))
          }
      }

    if(axis %in% c('none','full')){
      list(ggplot2::theme_gray(base_family = "Frutiger-LT-55-Roman"),
           theme,
           scale_y_continuous(labels = scales::label_comma(decimal.mark = ",", big.mark = "."), breaks = scales::pretty_breaks(n = y_breaks)),
           scale_x,
           annotate(geom = 'segment', y = y, yend = yend, color = color,x = x, xend = xend, linewidth = 0.25))

    } else if(axis == 'half' & geom == 'bar') {
      list(ggplot2::theme_gray(base_family = "Frutiger-LT-55-Roman"),
           theme,
           scale_y_continuous(labels = scales::label_comma(decimal.mark = ",", big.mark = "."), expand = expansion(mult = c(0, bar_adjust)), breaks = scales::pretty_breaks(n = y_breaks), ...),
           scale_x,
           annotate(geom = 'segment', y = y, yend = yend, color = color,x = x, xend = xend, linewidth = 0.25),...)
    } else {
      list(ggplot2::theme_gray(base_family = "Frutiger-LT-55-Roman"),
           theme,
           scale_y_continuous(labels = scales::label_comma(decimal.mark = ",", big.mark = "."), breaks = scales::pretty_breaks(n = y_breaks), expand = expansion(mult = c(0, 0))),
           scale_x,
           annotate(geom = 'segment', y = y, yend = yend, color = color,x = x, xend = xend, linewidth = 0.25))
    }



}


