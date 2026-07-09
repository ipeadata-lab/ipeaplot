# ipeaplot (development version)
  * `theme_ipea()`: axis/tick/border/gridlines now render at exactly 0.5pt, axis and legend text at exactly 7pt, and axis labels are spaced 1mm from ticks, matching the Ipea Editorial Manual guidelines.
  * New function `ipea_label_size()`: converts a point size (default 6pt) to the mm `size` used by `geom_text()`/`geom_label()`, for labeling values on bars/lines per the editorial guidelines.
  * Fixed `save_ipeaplot()` errors ("unused argument") when `use_cairo = FALSE` on `pdf`/`eps` formats.
  * Fixed `save_ipeaplot()` silently reporting success when a Cairo-based device fails to write a file; it now errors with a clear message.
  * New palettes `"NT"` and `"TD"`, based on the cover, section-title and chart colours of two Ipea editorial series (Nota Tecnica and Texto para Discussao). `scale_color_ipea()`/`scale_fill_ipea()` switch automatically to their qualitative 12-colour variant for discrete data.
  * Fixed a color-accuracy bug in `ipea_palette()` affecting every palette: an incorrect string offset silently forced the low nibble of the blue channel to `F` in all generated colours.

# ipeaplot 0.5.4
  * Fixed the vignette to address issues with geobr.

# ipeaplot 0.5.3
  * Minor fix for ipeaplot vignette build error

# ipeaplot 0.5.2
  * Minor change to intro vignette to fix conflict with geobr v2.0.0

# ipeaplot 0.5.1
  * Minor fixes

# ipeaplot 0.5.0
  * New function `save_ipeaplot()`: a unified function to save plots in multiple formats (vector formats such as .eps and .pdf, and raster formats such as .png and .jpg), with defaults that make it easy to use.
    
# ipeaplot 0.4.1
  * Palette 'Pink'.
  * Fixed: Adjust breaks logic to address issue #60
  * Fixed: Issue with categorical data on the Y-axis, addressed in issue #61.
    
# ipeaplot 0.4.0
  * The Frutiger family has been replaced by the default sans-serif font in titles and labels.
  * New function `save_pdf()`

# ipeaplot 0.3.1

Release of **ipeaplot** v0.3.1 on CRAN with the following functions:

  * `theme_ipea()`
  * `scale_color_ipea()`
  * `scale_fill_ipea()`
  * `save_eps()`
  

