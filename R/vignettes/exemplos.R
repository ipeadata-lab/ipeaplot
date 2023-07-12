
## Exemplos de acordo com site
# https://www.ipea.gov.br/sites/manualeditorial/padroes-editoriais/padroes-grafico-visuais/ilustracoes/graficos
#remotes::install_github("ipeadata-lab/ipeaplot")

# library(ipeaplot)
library(ggplot2)
library(dplyr)
## Exemplo 1
graph <- abjData::pnud_uf %>%
  filter(substr(uf,1,1) == "3") %>%
  select(1:4)

# Create a discrete scatter plot with 'mpg' on the x-axis, 'wt' on the y-axis, and filled by 'quantile'
# Use the 'scale_ipea()' function to apply the IPEA discrete fill scale
ggplot(data = graph, aes(x = ufn,
                         y = espvida,
                         fill = as.character(ano))) +
  geom_bar(stat="identity", position=position_dodge()) +
  scale_fill_ipea(discrete = T) +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom')


# Exemplo 2
graph <- abjData::pnud_uf %>%
  filter(substr(uf,1,1) == "2", ano == 2010) %>%
  select(1:3,pop) %>%
  mutate(share = (pop/sum(pop))*100)

library(ggplot2)
# Barplot
bp<- ggplot(graph, aes(x="", y=share, fill=ufn))+
  geom_bar(width = 1, stat = "identity")
bp

pie <- bp + coord_polar("y",start=0) +
  scale_fill_ipea(discrete = T, palette = 'Blues') +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom', axis = 'none')
pie

# Get the positions
df2 <- df %>%
  mutate(csum = rev(cumsum(rev(value))),
         pos = value/2 + lead(csum, 1),
         pos = if_else(is.na(pos), value/2, pos))

ggplot(df, aes(x = "" , y = value, fill = fct_inorder(group))) +
  geom_col(width = 1, color = 1) +
  coord_polar(theta = "y") +
  scale_fill_brewer(palette = "Pastel1") +
  geom_label_repel(data = df2,
                   aes(y = pos, label = paste0(value, "%")),
                   size = 4.5, nudge_x = 1, show.legend = FALSE) +
  guides(fill = guide_legend(title = "Group")) +
  theme_void()
