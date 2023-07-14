
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

# Exemplo 3
graph <- abjData::pnud_uf %>% filter(ano == 2010)

ggplot(graph, aes(x = ufn, y = rdpc))+
  geom_bar(stat = "identity", fill = 'blue') +
  insert_text(label = "rdpc", vertical = F) +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom')



# Exemplo 4
# populacao
pop <- sidrar::get_sidra(6579, period = c(paste0(2000:2020)), geo = "Brazil")
pop <- janitor::clean_names(pop)
pop <- dplyr::select(pop, ano , pop = valor)



ggplot(pop, aes(x = ano, y = pop))+
  geom_bar(stat = "identity", fill = 'blue') +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom')


# Exemplo 5
set.seed(123)
df <- expand.grid(ufn = distinct(abjData::pnud_uf, ufn)$ufn,
                  situacao = c('muito ruim','ruim','mediano','bom','muito bom'))
df$num <- runif(nrow(df))
df <- df %>%
  group_by(ufn) %>%
  mutate(prop = round((num/sum(num))*100,0))

graph <- arrange(transform(df,
                              Categoria =
                                factor(df$situacao,
                                       levels=c('muito ruim','ruim','mediano','bom','muito bom'))),
                    df$situacao)

graph <- graph %>% mutate(label = paste(prop,"%"),
                          label = ifelse(prop < 5,"",label))

ggplot(graph, aes(x = ufn, y = prop, fill = situacao))+
  geom_bar(stat = "identity")+
  geom_text(aes(label = label, y = prop),size = 4,
            position = position_stack(vjust = 0.5))+
  coord_flip() +
  scale_fill_ipea(discrete = T) +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom')
