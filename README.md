[![rcmdcheck](https://github.com/ipeadata-lab/ipeaplot/workflows/R-CMD-check/badge.svg)](https://github.com/ipeadata-lab/ipeaplot/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)

# ipeaplot: Add Ipea Editorial Standards to 'ggplot2' Graphics

O `ipeaplot` é um pacote em R desenvolvido para facilitar a padronização de gráficos e figuras seguindo a política editorial do Instituto de Pesquisa Econômica Aplicada (Ipea). O pacote traz algumas funções que facilitam o ajuste de formatação e de cores de gráficos criados com o pacote `ggplot2`, garantindo a conformidade com as diretrizes das publicações do Instituto.

# Instalação

Você pode instalar a versão em desenvolvimento do **ipeaplot** direto do Github:

```
# Development version
utils::remove.packages('ipeaplot')
remotes::install_github("ipeadata-lab/ipeaplot")
```
# Visão geral do pacote.

O pacote **ipeaplot** foi desenhado para ser usado em conjunto com o pacote [ggplot2](https://ggplot2.tidyverse.org/), a biblioteca mais popular de visualização de dados em R. Atualmente, o **ipeaplot** inclui três funções principais para ajudar você a alterar o estilo de suas figuras de forma a seguir as diretrizes editoriais do Ipea:

1. `theme_ipea()` - alteração a formatação dos elementos da figura (eixos, título, subtítulo, etc);
2. `scale_color_ipea()` e `scale_fill_ipea()`-  permite selecionar uma paleta de cores dentro de um conjunto de opções utilizadas pelo Ipea;
3. `save_eps()` - salva a figura em formato `.eps`, um formato vetorial de alta resolução utilizado pela equipe do editorial.

Demonstração completa do pacote nas vinhetas:
- [Introdução ao ipeaplot](https://ipeadata-lab.github.io/ipeaplot/articles/intro_ipeaplot.html)
- [Comparativo ipeaplot](https://ipeadata-lab.github.io/ipeaplot/articles/cookbook.html)




# Equipe <img align="right" src="https://github.com/ipeadata-lab/ipeaplot/blob/master/man/figures/ipea.png?raw=true" alt="ipea" width="300">

O pacote **ipeaplot** é desenvolvido pela equipe da Coordenação-Geral de Ciência de Dados e Tecnologia da Informação (CGDTI) do Instituto de Pesquisa Econômica Aplicada (Ipea).
