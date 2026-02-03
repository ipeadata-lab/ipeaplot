# Ggplot theme for Ipea charts and figures

Applies a custom theme for ggplot figures following the editorial
guidelines used by the Institute for Applied Economic Research - Ipea.
The function includes standardized formatting of options for axis lines,
text,

## Usage

``` r
theme_ipea(
  axis_lines = "full",
  axis_values = TRUE,
  legend.position = "right",
  grid.adjust = "horizontal",
  x_breaks = NULL,
  y_breaks = NULL,
  expand_x_limit = TRUE,
  expand_y_limit = TRUE,
  x_text_angle = 0,
  include_x_text_title = TRUE,
  include_y_text_title = TRUE,
  include_ticks = TRUE,
  ...
)
```

## Arguments

- axis_lines:

  A character vector specifying the axis style. Valid options are
  `"none"` (no axis lines), `"full"` (full-length axis lines), and
  `"half"` (half-length axis lines), the default.

- axis_values:

  Logical value indicating whether to show text elements. If `TRUE`,
  axis text will be displayed in black; otherwise, they will be hidden.

- legend.position:

  A character vector specifying the position of the legend. Valid
  options are `"right"` (default), `"left"`, `"top"`, and `"bottom"`.

- grid.adjust:

  Defines whether the grid lines should be `"horizontal"` (default) or
  `"vertical"`.

- x_breaks:

  Numeric. The number of breaks on the x-axis

- y_breaks:

  Numeric. The number of breaks on the y-axis

- expand_x_limit:

  Logical value that indicates whether the x-axis boundary should be
  expanded. If `TRUE`, the x-axis limits will be expanded; otherwise
  there will be no change

- expand_y_limit:

  Logical value that indicates whether the y-axis boundary should be
  expanded. If `TRUE`, the x-axis limits will be expanded; otherwise
  there will be no change

- x_text_angle:

  Numeric. Angle in degrees of the text in the x-axis.

- include_x_text_title:

  Logical. Whether to include x text title Defaults to `TRUE`.

- include_y_text_title:

  Logical. Whether to include x text title. Defaults to `TRUE`.

- include_ticks:

  Logical. Whether to include ticks. Defaults to `TRUE`.

- ...:

  Additional arguments to be passed to the `theme` function from the
  `ggplot2` package.

## Value

A custom theme for IPEA graphics.

## See also

Other ggplot2 theme functions:
[`scale_color_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/scale_color_ipea.md),
[`scale_fill_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/scale_fill_ipea.md)

## Examples

``` r
# Creating theme for ggplot2 graph using default arguments
library(ggplot2)
fig_raw <- ggplot() +
  geom_col(data = mtcars, aes(x = hp , y = mpg, fill = cyl)) +
  theme_ipea()
```
