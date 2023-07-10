#' Ipea Color Palette and Scales
#'
#' A 9-color Ipea palette.
#'
#' @importFrom scales manual_pal
#' @export
#' @rdname IpeaColor



ipea_palette <- function(palette = c('ipeatd','ipea2','ipea3')){

  # Palette options. Options following colors of IPEA TDs, others provided by the access to opportunities process (https://github.com/ipeaGIT/acesso_oport)
  ipea_colors <- c(


    # ipeatd
    `ipeatd1`       = '#003576',
    `ipeatd2`       = '#006EAB',
    `ipeatd3`       = '#063754',
    `ipeatd4`       = '#2F6280',
    `ipeatd5`       = '#7696AE',
    `ipeatd6`       = '#9CD2EB',
    `ipeatd7`       = '#40c7f4',


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

    `ipeatd`              = base::rev(ipea_cols(purrr::map('ipeatd', ~base::paste0(., 1:7))[[1]])),

    `ipea2`              = base::rev(ipea_cols(purrr::map('ipea_second', ~base::paste0(., 1:7))[[1]])),

    `ipea3`              = base::rev(ipea_cols(purrr::map('ipea_third', ~base::paste0(., 1:7))[[1]]))


  )

  if (palette ==  "ipeatd") {
    # Set colours to the ipea1 palette using manual_pal function
    colours <- ipea_palettes$ipeatd
  } else if (palette ==  "ipea2") {
    # Set colours to the ipea2 palette using manual_pal function
    colours <- ipea_palettes$ipea2
  } else if (palette ==  "ipea3") {
    # Set colours to the ipea3 palette using manual_pal function
    colours <- ipea_palettes$ipea3
  }  else {
    # Stop the execution and display an error message if options is none of the specified values
    stop("Palette options must be 'ipeatd', 'ipea2', 'ipea3'")
  }
  return(colours)

}


