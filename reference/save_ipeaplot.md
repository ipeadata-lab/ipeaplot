# Save ggplot in multiple formats

Unified function to save ggplot objects in one or more formats.

## Usage

``` r
save_ipeaplot(
  gplot = ggplot2::last_plot(),
  file.name,
  format = NULL,
  width = 6.3,
  height = 3.94,
  units = c("in", "mm", "cm", "px"),
  dpi = 300,
  background = "white",
  quality = 95,
  path = ".",
  scale = 1,
  overwrite = TRUE,
  include_date = FALSE,
  date_format = "%Y%m%d",
  use_cairo = TRUE,
  use_ragg = TRUE,
  quiet = TRUE,
  ...
)
```

## Arguments

- gplot:

  ggplot object. Default: ggplot2::last_plot().

- file.name:

  Base name of the file (without extension). E.g.,
  "results/figs/my_plot".

- format:

  Vector with one or more of: "eps", "jpg", "pdf", "png", "svg". If
  NULL, uses getOption("ipea.plot.default_format", "eps").

- width, height:

  Plot dimensions (default 160 x 100).

- units:

  Units: "mm", "cm", "in", "px" (default "in").

- dpi:

  DPI for raster formats (default 300).

- background:

  Background color; use NA for transparent PNGs. For JPEG (no
  transparency), NA becomes "white".

- quality:

  JPEG quality (0 to 100) (default 95).

- path:

  Output directory (default ".").

- scale:

  Scale factor passed to ggsave (default 1).

- overwrite:

  If FALSE, does not overwrite existing files: creates suffixes \_1,
  \_2, ... (default TRUE).

- include_date:

  If TRUE, appends the date to the file name: \_YYYYMMDD (default
  FALSE).

- date_format:

  Date format (default "%Y%m%d").

- use_cairo:

  Prefer using Cairo for PDF/EPS (default TRUE).

- use_ragg:

  Prefer using ragg for PNG/JPG when available (default TRUE).

- quiet:

  Suppress messages from ggsave when supported (default TRUE).

- ...:

  Passed to ggplot2::ggsave() (and therefore to the underlying graphics
  devices when applicable).

## Value

Named (invisible) vector with the paths of the saved files.
