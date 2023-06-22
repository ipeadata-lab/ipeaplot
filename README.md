# ipeaplot: ggplot graphics in Ipea standard.

 ``ipeaplot`` creates ggplot graphics following the editorial guidelines of the Institute of Applied Economic Research (IPEA). It provides users with tools and functions that simplify the application of consistent color schemes and graphic styles, ensuring compliance with IPEA's publication standards.

## Installation

```R
# Development version with latest features
utils::remove.packages('ipeaplot')
devtools::install_github("ipeadata-lab/ipeaplot")
library(ipeaplot)
```

# Basic Usage

The syntax of all ``ipeaplot`` functions operate on the same logic, making it intuitive to choose palettes or text options for any type of ggplot2 data and graphics using a single line of code. Like this:

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
More in [intro Vignette](https://rpubs.com/Pedrojorge7/templatesIpea) (temporary url).

-----

# Credits <img align="right" src="https://github.com/ipeadata-lab/ipeaplot/blob/master/ipea.png?raw=true" alt="ipea" width="300">

The **ipeaplot** package is developed by a team at the Institute for Applied Economic Research (Ipea), Brazil. If you want to cite this package, you can cite it as:

* Pereira, R.H.M.; Mation, L.F.; et. all (2023) **Creating graphics using Ipea's standard.**. GitHub repository - https://github.com/ipea-datalab/ipeaplot.



