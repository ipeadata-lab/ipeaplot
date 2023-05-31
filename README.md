# templatesIpea: Download Official Spatial Data Sets of Brazil 

<p align="justify">templatesIpea is a computational package designed to facilitate the standardization of colors and graphic formatting for text submissions for discussion (TD) and articles for the journal of the Institute of Applied Economic Research (IPEA). This package provides users with tools and functions that simplify the process of applying consistent color schemes and graphic styles in their work, ensuring conformity to the requirements and guidelines of the IPEA journal. By using templatesIpea, users can easily achieve visually appealing and professionally formatted text submissions for IPEA. (see detailed information below). </p> 




The package is currently available in [**R**](https://CRAN.R-project.org/package=templatesIpea) and [**Python**](https://pypi.org/project/templatesIpea/).

| ***R*** | ***Python*** | ***Repo***|
|-----|-----|----|
| [![CRAN/METACRAN Version](https://www.r-pkg.org/badges/version/templatesIpea)](https://CRAN.R-project.org/package=templatesIpea) <br /> [![CRAN/METACRAN Total downloads](http://cranlogs.r-pkg.org/badges/grand-total/templatesIpea?color=blue)](https://CRAN.R-project.org/package=templatesIpea) <br /> [![CRAN/METACRAN downloads per month](http://cranlogs.r-pkg.org/badges/templatesIpea?color=yellow)](https://CRAN.R-project.org/package=templatesIpea) <br /> [![Codecov test coverage](https://codecov.io/gh/ipea-datalab/templatesIpea/branch/master/graph/badge.svg)](https://app.codecov.io/gh/ipea-datalab/templatesIpea?branch=master)  <br /> [![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable) | [![PyPI version](https://badge.fury.io/py/templatesIpea.svg)](https://badge.fury.io/py/templatesIpea) <br />  [![Downloads](https://pepy.tech/badge/templatesIpea)](https://pepy.tech/project/templatesIpea) <br />  [![Downloads](https://pepy.tech/badge/templatesIpea/month)](https://pepy.tech/project/templatesIpea/month)  <br /> [![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing) |<img alt="GitHub stars" src="https://img.shields.io/github/stars/ipea-datalab/templatesIpea.svg?color=orange"> <br /> [![R build status](https://github.com/ipea-datalab/templatesIpea/workflows/R-CMD-check/badge.svg)](https://github.com/ipea-datalab/templatesIpea/actions) <br />  [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) |



## Installation R

```R
# From CRAN
install.packages("templatesIpea")
library(templatesIpea)

# or use the development version with latest features
utils::remove.packages('templatesIpea')
devtools::install_github("ipeadata-lab/templatesIpea", subdir = "r-package")
library(templatesIpea)
```




## Installation Python


# Basic Usage

The syntax of all `templatesIpea` functions operate on the same logic, making it intuitive to choose palettes or text options for any type of ggplot2 data and graphics using a single line of code. Like this:

## R
```R
library(templatesIpea)
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
More examples in the [intro Vignette](https://cran.r-project.org/web/packages/templatesIpea/vignettes/intro_to_templatesIpea.html)

## Python
```python

```
More examples [here](https://github.com/ipea-datalab/templatesIpea/tree/master/python-package/examples) 

# Available palletes:




## Other functions:

| Function | Action|
|-----|-----|
| `ipea_text` | Insert text inside graphics |
|`theme_ipea`| Adjust chart background colors to have IPEA theme and formatting |
| ... | ... |

## Coming soon:








-----

# Credits <img align="right" src="[https://github.com/ipea-datalab/templatesIpea/blob/master/r-package/man/figures/ipea_logo.png](https://github.com/ipeadata-lab/ipea_templates/blob/master/ipea.png)" alt="ipea" width="300">

The **templatesIpea** package is developed by a team at the Institute for Applied Economic Research (Ipea), Brazil. If you want to cite this package, you can cite it as:

* Pereira, R.H.M.; Mation, L.F.; et. all (2023) **templatesIpea: Standardization of structure and palettes in the text format for IPEA discussion**. GitHub repository - https://github.com/ipea-datalab/templatesIpea.



