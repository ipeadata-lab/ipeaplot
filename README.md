[![rcmdcheck](https://github.com/ipeadata-lab/ipeaplot/workflows/R-CMD-check/badge.svg)](https://github.com/ipeadata-lab/ipeaplot/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)

# ipeaplot: Add Ipea Editorial Standards to 'ggplot2' Graphics

O `ipeaplot` é um pacote em R desenvolvido para facilitar a padronização de gráficos e figuras seguindo a política editorial do Instituto de Pesquisa Econômica Aplicada (IPEA). O pacote traz algumas funções que facilitam o ajuste de formatação e de cores de gráficos criados com o pacote `ggplot2`, garantindo a conformidade com as diretrizes editoriais para a publicação de Textos para Discussão (TD) do Ipea.

 Esta vinheta apresenta introdução rápida ao **ipeaplot**.





de cores e de formatação de

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
