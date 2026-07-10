# Changelog

## ipeaplot (development version)

- [`theme_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/theme_ipea.md):
  axis/tick/border/gridlines now render at exactly 0.5pt, axis and
  legend text at exactly 7pt, and axis labels are spaced 1mm from ticks,
  matching the Ipea Editorial Manual guidelines.
- New function
  [`ipea_label_size()`](https://ipeadata-lab.github.io/ipeaplot/reference/ipea_label_size.md):
  converts a point size (default 6pt) to the mm `size` used by
  [`geom_text()`](https://ggplot2.tidyverse.org/reference/geom_text.html)/[`geom_label()`](https://ggplot2.tidyverse.org/reference/geom_text.html),
  for labeling values on bars/lines per the editorial guidelines.
- Fixed
  [`save_ipeaplot()`](https://ipeadata-lab.github.io/ipeaplot/reference/save_ipeaplot.md)
  errors (“unused argument”) when `use_cairo = FALSE` on `pdf`/`eps`
  formats.
- Fixed
  [`save_ipeaplot()`](https://ipeadata-lab.github.io/ipeaplot/reference/save_ipeaplot.md)
  silently reporting success when a Cairo-based device fails to write a
  file; it now errors with a clear message.
- New palettes `"NT"` and `"TD"`, based on the cover, section-title and
  chart colours of two Ipea editorial series (Nota Tecnica and Texto
  para Discussao).
  [`scale_color_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/scale_color_ipea.md)/[`scale_fill_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/scale_fill_ipea.md)
  switch automatically to their qualitative 12-colour variant for
  discrete data.
- Fixed a color-accuracy bug in
  [`ipea_palette()`](https://ipeadata-lab.github.io/ipeaplot/reference/ipea_palette.md)
  affecting every palette: an incorrect string offset silently forced
  the low nibble of the blue channel to `F` in all generated colours.
- [`theme_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/theme_ipea.md):
  default `legend.position` changed from `"right"` to `"bottom"`,
  matching the Ipea Editorial Manual guidelines.
- [`theme_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/theme_ipea.md):
  [`geom_point()`](https://ggplot2.tidyverse.org/reference/geom_point.html)
  layers in line charts (i.e. plots that also have a
  [`geom_line()`](https://ggplot2.tidyverse.org/reference/geom_path.html)/[`geom_path()`](https://ggplot2.tidyverse.org/reference/geom_path.html)/[`geom_step()`](https://ggplot2.tidyverse.org/reference/geom_path.html)
  layer) now default to a solid square marker (`shape = 15`), per the
  Ipea Editorial Manual guidelines. Does not affect scatter plots or a
  shape already set by the user.
- New function
  [`ipea_contrast_color()`](https://ipeadata-lab.github.io/ipeaplot/reference/ipea_contrast_color.md):
  given one or more fill/background colours, returns `"white"` or
  `"black"`, whichever is more readable, for labels drawn over
  bars/points per the editorial guidelines.
- Fixed
  [`theme_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/theme_ipea.md):
  x-axis category labels could collide with the x-axis title whenever
  some categories wrapped onto two lines (via `"\n"`) and others didn’t
  (a mix of single- and multi-line labels on the same axis) — a stray
  `vjust = -1` on `axis.text.x` misaligned single-line labels.

## ipeaplot 0.5.4

CRAN release: 2026-07-09

- Fixed the vignette to address issues with geobr.

## ipeaplot 0.5.3

CRAN release: 2026-07-06

- Minor fix for ipeaplot vignette build error

## ipeaplot 0.5.2

CRAN release: 2026-05-20

- Minor change to intro vignette to fix conflict with geobr v2.0.0

## ipeaplot 0.5.1

CRAN release: 2026-02-06

- Minor fixes

## ipeaplot 0.5.0

CRAN release: 2025-10-07

- New function
  [`save_ipeaplot()`](https://ipeadata-lab.github.io/ipeaplot/reference/save_ipeaplot.md):
  a unified function to save plots in multiple formats (vector formats
  such as .eps and .pdf, and raster formats such as .png and .jpg), with
  defaults that make it easy to use.

## ipeaplot 0.4.1

CRAN release: 2025-02-26

- Palette ‘Pink’.
- Fixed: Adjust breaks logic to address issue
  [\#60](https://github.com/ipeadata-lab/ipeaplot/issues/60)
- Fixed: Issue with categorical data on the Y-axis, addressed in issue
  [\#61](https://github.com/ipeadata-lab/ipeaplot/issues/61).

## ipeaplot 0.4.0

CRAN release: 2024-09-02

- The Frutiger family has been replaced by the default sans-serif font
  in titles and labels.
- New function `save_pdf()`

## ipeaplot 0.3.1

CRAN release: 2024-04-18

Release of **ipeaplot** v0.3.1 on CRAN with the following functions:

- [`theme_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/theme_ipea.md)
- [`scale_color_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/scale_color_ipea.md)
- [`scale_fill_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/scale_fill_ipea.md)
- `save_eps()`
