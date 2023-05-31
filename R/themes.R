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

theme_ipea <- function(axis = c('none','half','full'),box_option = 1,
                       text = T,legend.position, ...){

  # Set the default axis style to "half" if not provided by the user
  axis <- ifelse(missing(axis), 'half', axis)

  # Set the default legend position to "right" if not provided by the user
  legend.position <- ifelse(missing(legend.position), 'right', legend.position)

  if (axis == "half") {
    # Define the axis line and panel border for "half" style
    axis.line.x = element_line(size = 0.5, linetype = "solid", colour = "black")
    axis.line.y = element_line(size = 0.5, linetype = "solid", colour = "black")
    panel.border = element_blank()

  } else if (axis == "full") {
    # Define the axis line and panel border for "full" style
    axis.line.x = element_blank()
    axis.line.y = element_blank()
    panel.border = element_rect(size = 2, colour = "#40c7f4", fill = NA)

  } else {
    # Define the axis line and panel border for other styles
    element_blank = element_blank()
    axis.line.x = element_blank()
    axis.line.y = element_blank()
    panel.border = element_blank()

  }

  if (text) {
    # Define the axis text and ticks styles when text is displayed
    axis.text = element_text(colour = "black")
    axis.ticks = element_line(colour = "black")
  } else {
    # Hide axis text and ticks when text is not displayed
    axis.text = element_blank()
    axis.ticks = element_blank()
  }

  if (box_option == 1) {
    # Define the strip background and text styles for box option 1
    strip.background = element_rect(fill = "#003576")
    strip.text = element_text(colour = 'white')
  } else {
    # Define the strip background and text styles for other box options
    strip.background = element_rect(fill = "white")
    strip.text = element_text(colour = 'black')
  }



  theme(
    # Sets the background color of the panel to white
    panel.background = element_rect(fill = "white", colour = NA),
    # Sets the panel border based on the previous assignment
    panel.border = panel.border,
    # Sets the major grid lines color and size
    panel.grid.major = element_line(colour = "white", size = 0.2),
    # Sets the minor grid lines color and size
    panel.grid.minor = element_line(colour = "white", size = 0.5),
    # Hides the major grid lines on the x-axis
    panel.grid.major.x = element_blank(),
    # Sets the position of the legend based on the previous assignment
    legend.position = legend.position,
    # Sets the appearance of the legend key
    legend.key = element_rect(colour = "transparent", fill = "white"),
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
    axis.title.y = element_text(vjust = 1.5),
    # Adjusts the vertical alignment of the x-axis title
    axis.title.x = element_text(vjust = -0.4),
    # Sets the appearance of the plot title
    plot.title = element_text(
      size = 9, lineheight = 8.4,
      family = "Roboto Condensed", face = "bold", hjust = 0
    ),
    # Sets the appearance of the plot subtitle
    plot.subtitle = element_text(
      size = 9, lineheight = 8.4,
      family = "Roboto Light", hjust = 0
    ),
    # Sets the appearance of the legend text
    legend.text = element_text(size = 7, family = "Roboto Light"),
    # Sets the horizontal alignment of the legend to center
    legend.justification = "center",
    ...
  )

}


