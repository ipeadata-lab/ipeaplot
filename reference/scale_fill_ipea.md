# Scale fill IPEA

Generate a fill palette (continuous or discrete) in the formatting of
texts published by the Institute for Applied Economic Research (IPEA)

## Usage

``` r
scale_fill_ipea(
  palette = c("Blue", "Green", "Orange", "Pink", "Pink-Deep", "Green-Blue",
    "Green-Blue-White", "Red-Blue", "Red-Blue-White", "Orange-Blue", "Orange-Blue-White",
    "Viridis", "Inferno", "Magma", "Plasma", "Cividis"),
  palette_direction = 1,
  decimal.mark = ",",
  barheight = NULL,
  barwidth = NULL,
  title.hjust = NULL,
  label.hjust = NULL,
  ...
)
```

## Arguments

- palette:

  A character vector specifying the available palette for the color
  palette. The default palette are `"Blue"`, but we can also change to
  `'Green'`, `'Orange'`, `'Pink'`, `'Pink-Deep'`, `'Red-Blue'`,
  `'Orange-Blue'`, `'Green-Blue'`, `'Red-Blue-White'`,
  `'Orange-Blue-White'`, `'Green-Blue-White'`, `'Viridis'`, `'Inferno'`,
  `'Magma'`, `'Plasma'`, `'Cividis'`.

- palette_direction:

  A logical argument specifying if the ordering of the colors will
  follow the default of the palette (when the argument is 1) or if it
  will have an inverted ordering (for cases where it is 0).

- decimal.mark:

  The character to be used to indicate the numeric decimal point and
  Character used between every 3 digits to separate thousands. By
  default, the function uses a comma `","`, following the format used in
  Brazilian Portuguese.

- barheight:

  The height of the color gradient bar. This parameter is used when the
  direction is set to "horizontal".

- barwidth:

  The width of the color gradient bar. This parameter is used when the
  direction is set to "horizontal".

- title.hjust:

  A number specifying horizontal justification of the title text.

- label.hjust:

  A number specifying vertical justification of the title text.

- ...:

  Additional arguments to be passed to the scale_fill_gradientn,
  scale_color_gradientn, scale_fill_distiller or scale_color_distiller
  function from the ggplot2 package

## Value

A list object be added to a ggplot object to change color pallete.

## See also

Other ggplot2 theme functions:
[`scale_color_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/scale_color_ipea.md),
[`theme_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/theme_ipea.md)

## Examples

``` r
# Creating scale for ggplot2 graph using default arguments
library(ggplot2)
fig_raw <- ggplot() +
  geom_col(data = mtcars, aes(x = hp , y = mpg, fill = cyl)) +
  scale_fill_ipea()

# Creating scale for ggplot2 graph using green sequential palette
fig_raw <- ggplot() +
  geom_col(data = mtcars, aes(x = hp , y = mpg, fill = cyl)) +
  scale_fill_ipea(palette = "Green")
```
