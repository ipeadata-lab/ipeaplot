#' Insert Text into Plot
#'
#' This function adds text labels to a plot at specified positions.
#'
#' @param label The label variable indicating the text to be displayed.
#' @param decimals The number of decimal places to round the label values.
#' @param show_percents Logical.
#' @param vertical Logical.
#' @param ... Additional arguments to be passed to the `geom_text` function from the `ggplot2` package.
#'
#' @return A `geom_text` layer with text labels added to the plot.
#' @import ggplot2
#' @export
insert_text <- function(label = NULL, decimals = 0,
                        show_percents = FALSE,
                        vertical = TRUE, ...){



  if(is.null(label)){

  } else {

    # Convert the position to numeric values based on "inside" or "outside"
    vjust <- ifelse(vertical == TRUE, -0.5, 0.2)

    # Horizontal position have different position
    hjust <- ifelse(vertical == TRUE, 0.5, -0.1)



    if (show_percents) {
      # Add text labels to the plot using the `geom_text` function
      text <- ggplot2::geom_text(
        aes(
          label = paste0(gsub("\\.", ",", round(get(label), decimals)), "%")
        ),
        color = "black",
        position = position_dodge(width = 1),
        inherit.aes = TRUE,
        vjust = vjust,
        hjust = hjust, ...
      )
    } else {
      # Add text labels to the plot using the `geom_text` function
      text <- ggplot2::geom_text(
        aes(
          label = paste0(gsub("\\.", ",", round(get(label), decimals)))
        ),
        color = "black",
        position = position_dodge(width = 1),
        inherit.aes = TRUE,
        vjust = vjust,
        hjust = hjust, ...
      )
    }
  }


    if(vertical){

    } else{
      text <- list(text,ggplot2::coord_flip())
    }

  return(text)

}


