# Ipea Color Palette and Scales

This function creates a vector of n equally spaced colors along the
selected color map.

## Usage

``` r
ipea_palette(
  palette = c("Blue", "Green", "Orange", "Pink", "Pink-Deep", "Green-Blue",
    "Green-Blue-White", "Red-Blue", "Red-Blue-White", "Orange-Blue", "Orange-Blue-White",
    "Viridis", "Inferno", "Magma", "Plasma", "Cividis"),
  n,
  alpha = 1,
  begin = 0,
  end = 1,
  palette_direction = 1
)
```

## Arguments

- palette:

  A character string indicating the color map option to use. These
  options are available:'Blue', 'Green', 'Orange', 'Pink', 'Pink-Deep',
  'Red-Blue' 'Orange-Blue', 'Green-Blue', 'Red-Blue-White',
  'Orange-Blue-White', 'Green-Blue-White', 'Viridis', 'Inferno',
  'Magma', 'Plasma', 'Cividis'.

- n:

  The number of colors (\\\ge 1\\) used in the palette.

- alpha:

  The alpha transparency in a number between `0` and `1`.

- begin:

  The (corrected) hue in a number between `0` and `1` at which the color
  map begins.

- end:

  The (corrected) hue in a number between `0` and `1` at which the color
  map ends.

- palette_direction:

  Sets the order of colors in the scale. If `1`, the default, colors are
  ordered from darkest to lightest. If `-1`, the order of colors is
  reversed.

## Value

`ipea_palette` produces a character vector, `cv`, containing color hex
codes. This vector can be utilized to establish a custom color scheme
for future graphics using `palette(cv)`, or it can be applied directly
as a `col =` parameter in graphic functions or within `par`.

## Details

A 9-color Ipea palette.

## References

'Blue','Green','Orange','Pink','Pink-Deep','Green-Blue','Green-Blue-White','Red-Blue','Red-Blue-White',
'Orange-Blue','Orange-Blue-White', 'Viridis','Inferno', 'Magma','Plasma'
and 'Cividis': https://pmassicotte.github.io/paletteer_gallery/
