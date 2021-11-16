#' qc_tables 
#'
#' @title Make a nice data.frame
#' @description Make a nice data.frame which can be shown as a nice table.
#'
#' @param data_df the data frame
#' @param sequence does the table show hte qc info for all sequences or per sequence
#'
#' @return nice data.frame
#' 
#' @author Rico Derks
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom dplyr group_by filter ungroup select row_number mutate arrange
#' @importFrom tidyr pivot_wider
#'
#' @export
make_nice_table <- function(data_df = NULL, sequence = c("all", "per")) {
  # check if the argument is correct
  sequence <- match.arg(arg = sequence,
                        choices = c("all", "per"))
  
  if(!is.null(data_df)) {
    nice_df <- switch(
      sequence,
      "all" = {
        data_df %>% 
          dplyr::group_by(.data$compound, .data$parameter) %>% 
          dplyr::filter(dplyr::row_number() == 1) %>% 
          dplyr::ungroup() %>% 
          dplyr::select(.data$compound, .data$avg_all, .data$rsd_all, .data$minmax_all, .data$parameter) %>% 
          tidyr::pivot_wider(values_from = c(.data$avg_all, .data$rsd_all, .data$minmax_all), names_from = .data$parameter) %>% 
          dplyr::select(.data$compound, .data$avg_all_area, .data$rsd_all_area, .data$minmax_all_area, .data$avg_all_ret_time, .data$rsd_all_ret_time, .data$avg_all_width50, .data$rsd_all_width50) %>% 
          dplyr::mutate(avg_all_area = round(.data$avg_all_area),
                        rsd_all_area = format(.data$rsd_all_area, digits = 2, nsmall = 1),
                        minmax_all_area = format(.data$minmax_all_area, digits = 2, nsmall = 1),
                        avg_all_ret_time = format(.data$avg_all_ret_time, digits = 2, nsmall = 2),
                        rsd_all_ret_time = format(.data$rsd_all_ret_time, digits = 2, nsmall = 1),
                        avg_all_width50 = format(.data$avg_all_width50, digits = 2, nsmall = 1),
                        rsd_all_width50 = format(.data$rsd_all_width50, digits = 2, nsmall = 1)) %>% 
          dplyr::arrange(.data$compound)
      },
      "per" = {
        data_df %>%
          dplyr::group_by(.data$compound, .data$sequence, .data$parameter) %>% 
          dplyr::filter(dplyr::row_number() == 1) %>% 
          dplyr::ungroup() %>% 
          dplyr::select(.data$compound, .data$sequence, .data$avg_per, .data$rsd_per, .data$minmax_per, .data$parameter) %>% 
          tidyr::pivot_wider(values_from = c(.data$avg_per, .data$rsd_per, .data$minmax_per), names_from = .data$parameter) %>% 
          dplyr::select(.data$compound, .data$sequence, .data$avg_per_area, .data$rsd_per_area, .data$minmax_per_area, .data$avg_per_ret_time, .data$rsd_per_ret_time, .data$avg_per_width50, .data$rsd_per_width50) %>% 
          dplyr::mutate(avg_per_area = round(.data$avg_per_area),
                        rsd_per_area = format(.data$rsd_per_area, digits = 2, nsmall = 1),
                        minmax_per_area = format(.data$minmax_per_area, digits = 2, nsmall = 1),
                        avg_per_ret_time = format(.data$avg_per_ret_time, digits = 2, nsmall = 2),
                        rsd_per_ret_time = format(.data$rsd_per_ret_time, digits = 2, nsmall = 1),
                        avg_per_width50 = format(.data$avg_per_width50, digits = 2, nsmall = 1),
                        rsd_per_width50 = format(.data$rsd_per_width50, digits = 2, nsmall = 1)) %>% 
          dplyr::arrange(.data$sequence, .data$compound)
      })
  } else {
    message("'data_df' is NULL. There is no data!")
    nice_df <- NULL
  }
  
  return(nice_df)
}