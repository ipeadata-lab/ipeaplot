# ipeaplot: criando graficos no padrão editorial do Ipea

![logo](reference/figures/ipeaplot.png?raw=true)

O **ipeaplot** é um pacote em R desenvolvido para facilitar a
padronização de gráficos e figuras seguindo a política editorial do
Instituto de Pesquisa Econômica Aplicada (Ipea). O pacote traz algumas
funções que facilitam o ajuste de formatação e de cores de gráficos
criados com o pacote `ggplot2`, garantindo a conformidade com boa parte
das diretrizes das publicações do Instituto.

# Instalação

Você pode instalar o **ipeaplot** direto CRAN:

    # CRAN
    install.packages("ipeaplot")

A versão em desenvolvimento está disponível no GitHub:

    # Versão em desenvolvimento (0.5.0.9)
    utils::remove.packages("ipeaplot")
    remotes::install_github("ipeadata-lab/ipeaplot")

# Visão geral do pacote

O pacote **ipeaplot** foi desenhado para ser usado em conjunto com o
pacote [ggplot2](https://ggplot2.tidyverse.org/), a biblioteca mais
popular de visualização de dados em R. Atualmente, o **ipeaplot** inclui
quatro funções principais:

1.  [`theme_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/theme_ipea.md) -
    para formatação de elementos estilísticos da figura (eixos, fontes,
    linhas, grid, etc.);
2.  [`scale_color_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/scale_color_ipea.md)
    e
    [`scale_fill_ipea()`](https://ipeadata-lab.github.io/ipeaplot/reference/scale_fill_ipea.md)-
    selecionam paleta de cores dentro de um conjunto de opções
    utilizadas pelo Ipea;
3.  [`save_ipeaplot()`](https://ipeadata-lab.github.io/ipeaplot/reference/save_ipeaplot.md) -
    uma função unificada para salvar gráficos em múltiplos formatos
    (vetoriais como `.eps` e `.pdf`, e raster como `.png` e `.jpg`), com
    padrões que facilitam o uso.

# Demonstração do pacote

    # Carregue os pacotes
    library(ipeaplot)
    library(ggplot2)

No painel abaixo, à direita, temos a representação de um gráfico no
formato padrão do *ggplot2*. Já à esquerda, destacamos o resultado
obtido após a aplicação de linhas de código com as funções theme_ipea()
e scale_color_ipea().

    # Figura ggplot original
    fig_raw <- ggplot(data = mtcars, aes(x = hp , y = mpg, color = cyl)) +
                  geom_point() +
                  labs(y='Consumo de Combustível',
                       x ='Potência (Número de cavalos)',
                       color='Cilindradas')

    # Adicionando os padrões do Ipea
    fig_ipea <- fig_raw +
          scale_color_ipea() +
          theme_ipea()

    # Salvando o gráfico em múltiplos formatos com a nova função
    save_ipeaplot(fig_ipea, file.name = "meu_grafico_ipea", format = c("png", "pdf"))

![](reference/figures/figura_read_me.png)

Mais detalhes sobre a utilização do **ipeaplot** nas vinhetas:

- [Introdução ao
  ipeaplot](https://ipeadata-lab.github.io/ipeaplot/articles/intro_ipeaplot.html)

- [Cookbook
  ipeaplot](https://ipeadata-lab.github.io/ipeaplot/articles/cookbook.html)

# Fontes

Por limitações de licenciamento, o **ipeaplot** utiliza, em títulos e
rótulos das figuras, a fonte sem serifa padrão do sistema operacional do
usuário e não a tipografia recomendada pelo Editorial do Ipea
(*Frutiger*). Se as figuras forem salvas em formatos vetoriais editáveis
(como `pdf` ou `eps`), usando a função
[`save_ipeaplot()`](https://ipeadata-lab.github.io/ipeaplot/reference/save_ipeaplot.md),
a equipe editorial poderá alterar a fonte no momento da edição de uma
publicação.

# Equipe

![ipea](https://github.com/ipeadata-lab/ipeaplot/blob/master/man/figures/ipea.png?raw=true)

O pacote **ipeaplot** é desenvolvido pela equipe da Coordenação-Geral de
Ciência de Dados e Tecnologia da Informação (CGDTI) do Instituto de
Pesquisa Econômica Aplicada (Ipea).

# Outros pacotes semelhantes

- UNHCR's [unhcrthemes](https://github.com/unhcr-dataviz/unhcrthemes)
- BBC's [bbplot](https://github.com/bbc/bbplot)
