[![rcmdcheck](https://github.com/ipeadata-lab/ipeaplot/workflows/rcmdcheck/badge.svg)](https://github.com/ipeadata-lab/ipeaplot/actions)
[![Codecov test
coverage](https://codecov.io/gh/ipeadata-lab/ipeaplot/branch/main/graph/badge.svg)](https://app.codecov.io/gh/ipeadata-lab/ipeaplot?branch=main)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)

# ipeaplot: ggplot graphics in Ipea standard.

 ``ipeaplot`` creates ggplot graphics following the editorial guidelines of the Institute of Applied Economic Research (IPEA). It provides users with tools and functions that simplify the application of consistent color schemes and graphic styles, ensuring compliance with IPEA's publication standards.

## Installation

To install the Ipeaplot package, you can use the following code:

``` r
# install.packages("devtools")
devtools::install_github("ipeadata-lab/ipeaplot")
```

## Usage

### `theme_ipea`

The `theme_ipea` function allows you to define graphical attributes such
as axes, fonts, grid, and legends according to the editorial guidelines
of Ipea. It can be used as follows:

``` r
library(ipeaplot)
library(ggplot2)

data("mtcars")
ggplot() +
  geom_point(data=mtcars, aes(x=mpg , y=cyl, color=cyl)) +
  theme_ipea() +
  labs(title = "Relationship between Fuel Efficiency and Cylinders",
       subtitle = "Cars from the mtcars dataset")
```

The `theme_ipea` function will automatically apply the graphic settings
defined by Ipea to the ggplot-created plot.

## Contribution

If you encounter any problem or have suggestions for improvements to the
``ipeaplot`` package, feel free to open an issue.
