# ipeaplot: Creating graphics using Ipea's standard.

<p align="justify">ipeaplot is a computational package designed to facilitate the standardization of colors and graphic formatting for text submissions for discussion (TD) and articles for the journal of the Institute of Applied Economic Research (IPEA). This package provides users with tools and functions that simplify the process of applying consistent color schemes and graphic styles in their work, ensuring conformity to the requirements and guidelines of the IPEA journal. By using ipeaplot, users can easily achieve visually appealing and professionally formatted text submissions for IPEA. (see detailed information below). </p> 

The package is currently available in [**R**](https://CRAN.R-project.org/package=ipeaplot) 

| ***R*** | ***Python*** | ***Repo***|
|-----|-----|----|
| [![CRAN/METACRAN Version](https://www.r-pkg.org/badges/version/ipeaplot)](https://CRAN.R-project.org/package=ipeaplot) <br /> [![CRAN/METACRAN Total downloads](http://cranlogs.r-pkg.org/badges/grand-total/ipeaplot?color=blue)](https://CRAN.R-project.org/package=ipeaplot) <br /> [![CRAN/METACRAN downloads per month](http://cranlogs.r-pkg.org/badges/ipeaplot?color=yellow)](https://CRAN.R-project.org/package=ipeaplot) <br /> [![Codecov test coverage](https://codecov.io/gh/ipea-datalab/ipeaplot/branch/master/graph/badge.svg)](https://app.codecov.io/gh/ipea-datalab/ipeaplot?branch=master)  <br /> [![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable) | [![PyPI version](https://badge.fury.io/py/ipeaplot.svg)](https://badge.fury.io/py/ipeaplot) <br />  [![Downloads](https://pepy.tech/badge/ipeaplot)](https://pepy.tech/project/ipeaplot) <br />  [![Downloads](https://pepy.tech/badge/ipeaplot/month)](https://pepy.tech/project/ipeaplot/month)  <br /> [![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing) |<img alt="GitHub stars" src="https://img.shields.io/github/stars/ipea-datalab/ipeaplot.svg?color=orange"> <br /> [![R build status](https://github.com/ipea-datalab/ipeaplot/workflows/R-CMD-check/badge.svg)](https://github.com/ipea-datalab/ipeaplot/actions) <br />  [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) |

## Installation R

```R
# Development version with latest features
utils::remove.packages('ipeaplot')
devtools::install_github("ipeadata-lab/ipeaplot")
library(ipeaplot)
```

# Basic Usage

The syntax of all `ipeaplot` functions operate on the same logic, making it intuitive to choose palettes or text options for any type of ggplot2 data and graphics using a single line of code. Like this:

## R
```R
library(ipeaplot)
library(ggplot2)

data("mtcars")

mtcars <- mtcars %>%
  mutate(carb = ifelse(carb == 1,"0-1",
                ifelse(carb == 2,"1-2",
                ifelse(carb == 3,"2-3",
                ifelse(carb == 4,"3-4",NA)))))

# continuous scale
ggplot() +
  geom_point(data=mtcars, aes(x=mpg , y=cyl, color=cyl)) +
  scale_color_continuous_ipea()

# discrete scale
ggplot(data=mtcars, aes(x=mpg , y=cyl, color=carb)) +
  geom_point() +
  scale_colour_discrete_ipea()


```
More examples in the [intro Vignette](https://rpubs.com/Pedrojorge7/templatesIpea)
ps: Temporary address subject to change in the future

## Other functions:

| Function | Action|
|-----|-----|
| `ipea_text` | Insert text inside graphics |
|`theme_ipea`| Adjust chart background colors to have IPEA theme and formatting |
| ... | ... |

## Coming soon:

-----

# Credits <img align="right" src="https://github.com/ipeadata-lab/ipeaplot/blob/master/ipea.png?raw=true" alt="ipea" width="300">

The **ipeaplot** package is developed by a team at the Institute for Applied Economic Research (Ipea), Brazil. If you want to cite this package, you can cite it as:

* Pereira, R.H.M.; Mation, L.F.; et. all (2023) **Creating graphics using Ipea's standard.**. GitHub repository - https://github.com/ipea-datalab/ipeaplot.



