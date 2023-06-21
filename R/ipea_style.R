#' Theme for IPEA graphics
#'
#' This function defines a custom theme for IPEA graphics, which provides standardized formatting
#' options for axis lines, text, legends, and panel borders.
#'
#' @param axis A character vector specifying the axis style. Valid options are "none" (no axis lines),
#'   "half" (half-length axis lines), and "full" (full-length axis lines).
#' @param box_option An integer indicating the box style. Use 1 for a dark background with white text
#'   (default), and any other value for a white background with black text.
#' @param text Logical value indicating whether to show text elements. If TRUE, axis text and ticks
#'   will be displayed in black; otherwise, they will be hidden.
#' @param legend.position A character vector specifying the position of the legend. Valid options are
#'   "right" (default), "left", "top", and "bottom".
#' @param ... Additional arguments to be passed to the `theme` function from the `ggplot2` package.
#'
#' @return A custom theme for IPEA graphics.
#' @import ggplot2
#' @export

ipea_style <- function(axis = c('none','half','full'),box_option = 1,
                       text = T,legend.position,
                       type = c('continuous','discrete'),
                       style = c('colour','color','fill'),
                       options = c("crimson","orpheu","cartola","caqui",
                                   "post","wrapper","blue_red","ipea1",
                                   "ipea2",'ipea3',"manual"),low = NULL, mid = NULL,  high = NULL,
                       direction = c('horizontal','vertical'),colours,
                       show.limits = T, pt_br = T ,barheight = 2,barwidth = 50,name = NULL,
                       label = NULL, decimals = 0,
                       show_percents = FALSE,
                       position = c("inside", "outside"), ...){

  # Set the default axis style to "half" if not provided by the user
  axis <- ifelse(missing(axis), 'half', axis)

  # Set the default legend position to "right" if not provided by the user
  legend.position <- ifelse(missing(legend.position), 'right', legend.position)

  if (axis == "half") {
    # Define the axis line and panel border for "half" style
    axis.line.x = ggplot2::element_line(size = 0.5, linetype = "solid", colour = "black")
    axis.line.y = ggplot2::element_line(size = 0.5, linetype = "solid", colour = "black")
    panel.border = ggplot2::element_blank()

  } else if (axis == "full") {
    # Define the axis line and panel border for "full" style
    axis.line.x = ggplot2::element_blank()
    axis.line.y = ggplot2::element_blank()
    panel.border = ggplot2::element_rect(size = 2, colour = "black", fill = NA)

  } else {
    # Define the axis line and panel border for other styles
    element_blank = ggplot2::element_blank()
    axis.line.x = ggplot2::element_blank()
    axis.line.y = ggplot2::element_blank()
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

  if (box_option == 1) {
    # Define the strip background and text styles for other box options
    strip.background = ggplot2::element_rect(fill = "white")
    strip.text = ggplot2::element_text(colour = 'black')

  } else {
    # Define the strip background and text styles for box option 1
    strip.background = ggplot2::element_rect(fill = "#003576")
    strip.text = ggplot2::element_text(colour = 'white')
  }



  ggplot2::theme(
    # Sets the background color of the panel to white
    panel.background = ggplot2::element_rect(fill = "white", colour = NA),
    # Sets the panel border based on the previous assignment
    panel.border = panel.border,
    # Sets the major grid lines color and size
    panel.grid.major = ggplot2::element_line(colour = "white", size = 0.2),
    # Sets the minor grid lines color and size
    panel.grid.minor = ggplot2::element_line(colour = "white", size = 0.5),
    # Hides the major grid lines on the x-axis
    panel.grid.major.x = ggplot2::element_blank(),
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
    # Sets the appearance of the axis text based on the previous assignment
    axis.text = axis.text,
    # Sets the appearance of the axis ticks based on the previous assignment
    axis.ticks = axis.ticks,
    # Adjusts the vertical alignment of the y-axis title
    axis.title.y = ggplot2::element_text(vjust = 1.5),
    # Adjusts the vertical alignment of the x-axis title
    axis.title.x = ggplot2::element_text(vjust = -0.4),
    # Sets the appearance of the plot title
    plot.title = ggplot2::element_text(
      size = 9, lineheight = 8.4,
      family = "Roboto Condensed", face = "bold", hjust = 0
    ),
    # Sets the appearance of the plot subtitle
    plot.subtitle = ggplot2::element_text(
      size = 9, lineheight = 8.4,
      family = "Roboto Light", hjust = 0
    ),
    # Sets the appearance of the legend text
    legend.text = ggplot2::element_text(size = 7, family = "Roboto Light"),
    # Sets the horizontal alignment of the legend to center
    legend.justification = "center",
    ...
  )

}


