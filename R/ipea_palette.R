#' Ipea Color Palette and Scales
#'
#' A 9-color Ipea palette.
#'
#' @importFrom scales manual_pal
#' @export
#' @rdname IpeaColor



ipea_palette <- function(palette = c("crimson","orpheu","cartola","caqui",
                                     "post","wrapper","blue_red","ipea1",
                                     "ipea2",'ipea3')){

  # Palette options. Options following colors of IPEA TDs, others provided by the access to opportunities process (https://github.com/ipeaGIT/acesso_oport)
  ipea_colors <- c(


    ## qualitativas
    `petroleo`        = '#00324a',
    `roxo`            = '#5561A8',
    `lilas`           = '#814681',
    `rosa`            = '#b8446b',
    `laranja`         = '#d25942',
    `amarelo`         = '#ffa600',
    `beje`            = '#c88300',

    #`branco`         = '#f1f1f1',
    `branco`         = '#d9d9d9',

    # cinzas
    `cinza_escuro`   = '#626262',
    `cinza_medio`    = '#808080',
    `cinza_claro`    = '#cccccc',

    # crimson
    `crimson1`       = '#bf7972',
    `crimson2`       = '#9b7a7a',
    `crimson3`       = '#aba091',
    `crimson4`       = '#5F6987',
    `crimson5`       = '#252B4A',

    # orpheus
    `orpheu1`       = '#E69E7A',
    `orpheu2`       = '#AB8E89',
    `orpheu3`       = '#AAACB1',
    `orpheu4`       = '#7E95AB',
    `orpheu5`       = '#2F7590',
    `orpheu6`       = '#013337',


    # cartola
    `cartola1`       = '#D08969',
    `cartola2`       = '#B69186',
    `cartola3`       = '#AAACB1',
    `cartola4`       = '#5E88A0',
    `cartola5`       = '#25677E',
    `cartola6`       = '#003338',

    # caqui
    `caqui1`       = '#764F02',
    `caqui2`       = '#CC9A48',
    `caqui3`       = '#CCBC72',
    `caqui4`       = '#8C91A2',
    `caqui5`       = '#6A79A4',
    `caqui6`       = '#1c2c4a',

    # post
    `post1`       = '#A3553B',
    `post2`       = '#AB9432',
    `post3`       = '#A3A39E',
    `post4`       = '#70937D',
    `post5`       = '#54778A',
    `post6`       = '#032e3f',

    # wrapper
    `wrapper1`       = '#C96526',
    `wrapper2`       = '#FFB330',
    `wrapper3`       = '#BD9F68',
    `wrapper4`       = '#7292D8',
    `wrapper5`       = '#2C578D',

    # ipea_main
    `ipea_main1`       = '#003576',
    `ipea_main2`       = '#006EAB',
    `ipea_main3`       = '#063754',
    `ipea_main4`       = '#2F6280',
    `ipea_main5`       = '#7696AE',
    `ipea_main6`       = '#9CD2EB',
    `ipea_main7`       = '#40c7f4',


    # ipea_second
    `ipea_second1`       = '#9E3A26',
    `ipea_second2`       = '#a15545',
    `ipea_second3`       = '#9e6e68',
    `ipea_second4`       = '#878a97',
    `ipea_second5`       = '#7696AE',
    `ipea_second6`       = '#2F6280',
    `ipea_second7`       = '#063754',

    # ipea_third
    `ipea_third1`       = '#003576',
    `ipea_third2`       = '#006EAB',
    `ipea_third3`       = '#40c7f4',
    `ipea_third4`       = '#9CD2EB',
    `ipea_third5`       = '#000000',
    `ipea_third6`       = '#7D7D7D',
    `ipea_third7`       = '#C8C8C8',
    `ipea_third8`       = '#003F1F',
    `ipea_third9`       = '#009D30',
    `ipea_third10`      = '#97BF0D'

  )

  ipea_cols <- function(...) {
    cols <- c(...)

    if (is.null(cols))
      return (ipea_colors)

    ipea_colors[cols]
  }

  ipea_palettes <- list(

    `original`           = base::rev(ipea_cols('beje','laranja','rosa','lilas','roxo','petroleo')),

    `crimson`            = base::rev(ipea_cols(purrr::map('crimson', ~base::paste0(., 1:5))[[1]])),

    `orpheu`             = base::rev(ipea_cols(purrr::map('orpheu', ~base::paste0(., 1:6))[[1]])),

    `cartola`            = base::rev(ipea_cols(purrr::map('cartola', ~base::paste0(., 1:6))[[1]])),

    `caqui`              = base::rev(ipea_cols(purrr::map('caqui', ~base::paste0(., 1:6))[[1]])),

    `post`               = base::rev(ipea_cols(purrr::map('post', ~base::paste0(., 1:6))[[1]])),

    `wrapper`            = base::rev(ipea_cols(purrr::map('wrapper', ~base::paste0(., 1:5))[[1]])),

    `ipea1`              = base::rev(ipea_cols(purrr::map('ipea_main', ~base::paste0(., 1:7))[[1]])),

    `ipea2`              = base::rev(ipea_cols(purrr::map('ipea_second', ~base::paste0(., 1:7))[[1]])),

    `ipea3`              = base::rev(ipea_cols(purrr::map('ipea_third', ~base::paste0(., 1:7))[[1]]))


  )

  if (palette ==  "ipea1") {
    # Set colours to the ipea1 palette using manual_pal function
    colours <- ipea_palettes$ipea1
  } else if (palette ==  "ipea2") {
    # Set colours to the ipea2 palette using manual_pal function
    colours <- ipea_palettes$ipea2
  } else if (palette ==  "ipea3") {
    # Set colours to the ipea3 palette using manual_pal function
    colours <- ipea_palettes$ipea2
  } else if (palette ==  "crimson") {
    # Set colours to the crimson palette using manual_pal function
    colours <- ipea_palettes$crimson
  } else if (palette ==  "orpheu") {
    # Set colours to the orpheu palette using manual_pal function
    colours <- ipea_palettes$orpheu
  } else if (palette ==  "cartola") {
    # Set colours to the cartola palette using manual_pal function
    colours <- ipea_palettes$cartola
  } else if (palette ==  "caqui") {
    # Set colours to the caqui palette using manual_pal function
    colours <- ipea_palettes$caqui
  } else if (palette ==  "post") {
    # Set colours to the post palette using manual_pal function
    colours <- ipea_palettes$post
  } else if (palette ==  "wrapper") {
    # Set colours to the wrapper palette using manual_pal function
    colours <- ipea_palettes$wrapper
  } else {
    # Stop the execution and display an error message if options is none of the specified values
    stop("Palette options must be 'crimson', 'orpheu', 'top hat', 'khaki', 'post', 'wrapper', 'blue_red', 'ipea1', 'ipea2', 'ipea3'")
  }
  return(colours)

}


