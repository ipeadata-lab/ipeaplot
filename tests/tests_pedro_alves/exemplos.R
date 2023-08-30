
## Exemplos de acordo com site
# https://www.ipea.gov.br/sites/manualeditorial/padroes-editoriais/padroes-grafico-visuais/ilustracoes/graficos
remotes::install_github("ipeadata-lab/ipeaplot")

devtools::check(pkg = ".",  cran = FALSE, env_vars = c(NOT_CRAN = "true"))

library(ipeaplot)
library(ggplot2)
library(dplyr)
extrafont::fonttable()

# Teste paleta
Green       = paletteer::paletteer_d("ggsci::green_material")
Orange      = paletteer::paletteer_d("ggsci::orange_material")
Blue        = paletteer::paletteer_d("ggsci::blue_material")
Pink        = paletteer::paletteer_d("ggsci::pink_material")
Green_Blue  = paletteer::paletteer_c("ggthemes::Classic Green-Blue", 10)
Orange_Blue = paletteer::paletteer_c("ggthemes::Classic Orange-Blue", 10)
Red_Blue    = paletteer::paletteer_c("ggthemes::Classic Red-Blue", 10)

library(colorblindcheck)
palette_dist(Green_Blue)
palette_check(Green_Blue, plot = TRUE)
palette_check(Orange_Blue, plot = TRUE)
palette_check(Red_Blue, plot = TRUE)

library(showtext)


## Exemplo 1
graph <- abjData::pnud_uf %>%
  filter(substr(uf,1,1) == "3") %>%
  select(1:4)


ggplot(base_graf2, aes(x='', y=percentual, fill=Assunto))+
  geom_bar(width = 1, stat = "identity", color= 'black')+
  coord_polar("y", start=0) +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 2",
       subtitle="Assuntos das manifestações recebidas pela Ouvidoria do Ipea (2004-2014) (Em %)",
       caption = 'Elaboração dos autores.') +
  theme_ipea(legend.position="bottom", axis = 'none', axis_values = F, pie.adjust = 'pie') +
  scale_fill_ipea(discrete = T,palette = 'Orange-Blue') +
  insert_text(label = 'percentual', show_percents = T, pie_plot = T)

# Create a discrete scatter plot with 'mpg' on the x-axis, 'wt' on the y-axis, and filled by 'quantile'
# Use the 'scale_ipea()' function to apply the IPEA discrete fill scale
ggplot(data = graph, aes(x = ufn,
                         y = espvida,
                         fill = ano)) +
  geom_bar(stat="identity", width= 0.5) +
  scale_fill_ipea(discrete = F) +
  ggplot2::geom_text(
    aes(label = paste0(gsub("\\.", ",", round(get(label), decimals)))
    ))

  insert_text(label = 'espvida')
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom', geom = 'bar')


# Exemplo 2
graph <- abjData::pnud_uf %>%
  filter(substr(uf,1,1) == "2", ano == 2010) %>%
  select(1:3,pop) %>%
  mutate(share = (pop/sum(pop))*100)


# Barplot
bp <- ggplot(graph, aes(x="", y=share, fill=ufn))+
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y",start=0) +
  scale_fill_ipea(discrete = T, palette = 'Blue') +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom', axis = 'none')
bp

# Exemplo 3
graph <- abjData::pnud_uf %>% filter(ano == 2010)

ggplot(graph, aes(x = ufn, y = rdpc))+
  geom_bar(stat = "identity", fill = 'blue', width= 0.5) +
  insert_text(label = "rdpc", vertical = F) +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom', geom = 'bar', direction = 'horizontal')



# Exemplo 4
# populacao
options(scipen = 999)
pop <- sidrar::get_sidra(6579, period = c(paste0(2000:2020)), geo = "Brazil")
pop <- janitor::clean_names(pop)
pop <- dplyr::select(pop, ano , pop = valor)



ggplot(pop, aes(x = ano, y = pop/1000000))+
  geom_bar(stat = "identity", fill = 'blue', width= 0.5) +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom', geom = 'bar')


# Exemplo 5
# populacao
options(scipen = 999)
pop <- sidrar::get_sidra(6579, period = c(paste0(2000:2020)), geo = "Brazil")
pop <- janitor::clean_names(pop)
pop <- dplyr::select(pop, ano , pop = valor)

pib <- sidrar::get_sidra(5938, period = c(paste0(2000:2020)), geo = "Brazil")
pib <- janitor::clean_names(pib)
pib <- subset(pib, variavel == "Produto Interno Bruto a preços correntes")
pib <- dplyr::select(pib, ano , pib = valor)

pib_pc <- left_join(pib,pop) %>% mutate(pib_pc = pib/pop) %>% filter(!is.na(pib_pc))

ggplot(pib_pc, aes(x = ano, y = pib_pc))+
  geom_line(fill = 'blue', group = 1) +
  geom_point() +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  insert_text(label = 'pib_pc') +
  theme_ipea(legend.position = 'bottom')

# Exemplo 6
graph <- abjData::pnud_uf %>%
  mutate(reg = ifelse(substr(uf,1,1) == 1,'A - Norte',
               ifelse(substr(uf,1,1) == 2,'B - Nordeste',
               ifelse(substr(uf,1,1) == 3,'C - Sudeste',
               ifelse(substr(uf,1,1) == 4,'D - Sul','E  Centro-Oeste'))))) %>%
  group_by(reg,ano) %>% dplyr::summarise(rdpc = weighted.mean(rdpc, w = pop))

ggplot(graph, aes(x = as.character(ano), y = rdpc))+
  geom_bar(stat = "identity", fill = 'blue', width= 0.5) +
  insert_text(label = "rdpc", vertical = T) +
  facet_wrap(.~reg, scales = 'free') +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom', geom = 'bar')

# Exemplo 7
set.seed(123)
df <- expand.grid(ufn = distinct(abjData::pnud_uf, ufn)$ufn,
                  situacao = c('muito ruim','ruim','mediano','bom','muito bom'))
df$num <- runif(nrow(df))
df <- df %>%
  group_by(ufn) %>%
  mutate(prop = (num/sum(num))*100,
         total = sum(prop))

graph <- arrange(transform(df,
                              Categoria =
                                factor(df$situacao,
                                       levels=c('muito ruim','ruim','mediano','bom','muito bom'))),
                    df$situacao)

graph <- graph %>% mutate(label = paste(round(prop,0)))

ggplot(graph, aes(x = ufn, y = prop, fill = situacao))+
  geom_bar(stat = "identity") +
  insert_text(label = 'label', vertical = F, show_percents = T) +
  scale_fill_ipea(discrete = T) +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom', geom = 'bar')


# Exemplo 8
graph <- abjData::pnud_muni %>%
  filter(substr(codmun6 ,1,2) == "27", ano == 2010) %>%
  select(code_muni = codmun7, espvida)

mun <- geobr::read_municipality(code_muni = 'AL') %>% left_join(graph)

# Create a discrete scatter plot with 'mpg' on the x-axis, 'wt' on the y-axis, and filled by 'quantile'
# Use the 'scale_ipea()' function to apply the IPEA discrete fill scale
ggplot(data = mun, aes(fill = espvida)) +
  geom_sf() +
  scale_fill_ipea(direction = 'horizontal') +
  labs(x="",
       y="",
       fill = "",
       title="GRÁFICO 5",
       subtitle="Indicadores de infraestrutura das escolas - capitais regionais do Nordeste (2018)",
       caption = 'Fonte: ipea') +
  theme_ipea(legend.position = 'bottom', axis = 'none', text = F)
