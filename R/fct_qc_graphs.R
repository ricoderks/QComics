#' qc_graphs 
#'
#' @title Make the QC graph
#'
#' @description Make the QC graph
#'
#' @param data_df data.frame with the data
#' @param yaxis what to show on the y-axis
#' @param sequence show qc results for all sequences summarised or per sequence
#' 
#' @return a gpplot2 object
#'
#' @author Rico Derks
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom dplyr filter mutate
#' @importFrom forcats fct_reorder
#' @importFrom ggplot2 ggplot aes_string geom_point geom_line geom_label aes guides labs expand_limits theme element_text scale_y_continuous facet_grid guide_legend labeller facet_wrap
#' @importFrom ggCPM theme_cpm
#'
#' @export
#'
make_qc_graph <- function(data_df = NULL, yaxis = NULL, sequence = c("all", "per")) {
  
  y_label <- switch(
    yaxis,
    "area" = "Peak area",
    "ret_time" = "Retention time [min]",
    "width50" =  "Peak width at 50% [min]"
  )
  
  if(sequence == "all") {
    # create labels for the faceting strip, should be a named vector
    my_labels <- unique(data_df %>%
                          filter(.data$parameter == yaxis) %>% 
                          select(.data$rsd_all_show) %>%
                          pull())
    names(my_labels) <- unique(data_df %>%
                                 filter(.data$parameter == yaxis) %>% 
                                 select(.data$compound) %>%
                                 pull())
  }
  
  my_plot <- data_df %>%
    filter(.data$parameter == yaxis) %>% 
    mutate(short_filename = fct_reorder(.data$short_filename, .data$acq_order),
           sequence = factor(.data$sequence)) %>% 
    ggplot(aes(x = .data$short_filename,
               y = .data$value,
               colour = .data$sequence,
               group = .data$compound)) +
    geom_point(size = 3) +
    geom_line()
  
  if(sequence == "all") {
    my_plot <- my_plot + 
      guides(colour = guide_legend(title = "Sequence")) + 
      facet_wrap(~ .data$compound,
                 scales = "free_y",
                 ncol = 2,
                 labeller = labeller(compound = my_labels))
  } else {
    my_plot <- my_plot +
      geom_label(aes(label = .data$rsd_per_show,
                     x = .data$max_x,
                     y = .data$max_y,
                     vjust = "inward",
                     hjust = "inward"),
                 colour = "black") +
      guides(colour = "none") +
      facet_grid(.data$compound ~ .data$sequence,
                 scales = "free")
  }
  
  my_plot <- my_plot +
    labs(x = "Filename",
         y = y_label) +
    expand_limits(y = 0) +
    theme_cpm() +
    theme(axis.text.x = element_text(angle = 45,
                                     hjust = 1,
                                     size = 9),
          axis.text.y = element_text(size = 10),
          axis.title = element_text(size = 14),
          strip.text = element_text(size = 12),
          legend.position = "bottom")
  
  # use scientific scale when peak area is selected
  if (yaxis == "area") {
    my_plot <- my_plot +
      scale_y_continuous(labels = function(x) format(x, scientific = TRUE, digits = 2, nsmall = 1))
  }
  
  # return the plot
  return(my_plot)
}
