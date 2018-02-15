#' Ipea Color Palette (Discrete) and Scales
#'
#' A 9-color Ipea palette.
#'
#'
#' @inheritParams ggplot2::scale_color_hue
#' @param axis logical, whether the plot should keed the axis line or not.
#' @param only.color logical, whether there is more than one factor in the plot.
#'
#' @family colour
#' @import ggplot2
#' @importFrom scales manual_pal
#' @export
#' @rdname IpeaColor
ipea_pal <- function() {
  manual_pal(c('#003576','#006EAB','#9CD2EB','#000000','#7D7D7D',
             '#C8C8C8','#003F1F','#009D30','#97BF0D'))
}

#' @rdname IpeaColor
#' @export
scale_colour_ipea <- function(...){
  discrete_scale("colour", "ipea", ipea_pal(), ...)
}

#' @rdname IpeaColor
#' @export
scale_color_ipea <- scale_colour_ipea

#' @rdname IpeaColor
#' @export
scale_fill_ipea <- function(...){
  discrete_scale("fill", "ipea", ipea_pal(), ...)
}
