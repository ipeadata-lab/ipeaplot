#' Insert Text into Plot
#'
#' This function adds text labels to a plot at specified positions.
#'
#' @param label The label variable indicating the text to be displayed.
#' @param decimals The number of decimal places to round the label values.
#' @param position A character vector specifying the position of the text. Valid options are "inside"
#'   (default) and "outside".
#' @param ... Additional arguments to be passed to the `geom_text` function from the `ggplot2` package.
#'
#' @return A `geom_text` layer with text labels added to the plot.
#' @import ggplot2
#' @export
insert_text <- function(axis = c('none','half','full'),box_option = 1,
                        text = T,legend.position,
                        type = c('continuous','discrete'),
                        style = c('colour','color','fill'),
                        options = c("crimson","orpheu","cartola","caqui",
                                    "post","wrapper","blue_red","ipea1",
                                    "ipea2",'ipea3',"manual"),low = NULL, mid = NULL,  high = NULL,
                        direction = c('horizontal','vertical'),colours,
                        show.limits = T, pt_br = T ,barheight = 2,barwidth = 50,
                        label = NULL, decimals = 0,
                        show_percents = FALSE,
                        position = c("inside", "outside"), ...) {



  if(is.null(label)){

  } else {

    # Set the default position to "outside" if not provided by the user
    position <- ifelse(missing(position), 'outside', position)

    # Convert the position to numeric values based on "inside" or "outside"
    position <- ifelse(position == "outside", -0.5, 1.5)



    if (show_percents) {
      # Add text labels to the plot using the `geom_text` function
      ggplot2::geom_text(
        aes(
          label = paste0(gsub("\\.", ",", round(get(label), decimals)), "%")
        ),
        color = "black",
        position = position_dodge(width = 1),
        inherit.aes = TRUE,
        vjust = position, ...
      )
    } else {
      # Add text labels to the plot using the `geom_text` function
      ggplot2::geom_text(
        aes(
          label = paste0(gsub("\\.", ",", round(get(label), decimals)))
        ),
        color = "black",
        position = position_dodge(width = 1),
        inherit.aes = TRUE,
        vjust = position, ...
      )
    }


  }


}


