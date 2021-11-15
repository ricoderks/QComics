#' raw_data 
#'
#' @title Remove some rows
#' 
#' @description Remove selected rows
#'
#' @param data_df the data.frame to remove rows from
#' @param rows the index number of the rows to remove
#'
#' @return data.frame with rows removed
#'
#' @importFrom dplyr slice select pull
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
#' @author Rico Derks
#
#' @noRd
remove_rows <- function(data_df = NULL, rows = NULL) {
  # remove the rows
  data_df_new <- data_df %>%
    dplyr::slice(-rows) 
  
  return(data_df_new)
}



#' @title Calculate QC parameters
#' 
#' @description Calculate the QC parameters
#'
#' @param data_df the data.frame to remove rows from
#'
#' @return data.frame with the QC parameters calculate (long format)
#'
#' @importFrom dplyr group_by mutate ungroup
#' @importFrom tidyr pivot_longer
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom stats sd
#'
#' @author Rico Derks
#
#' @noRd
calc_qc <- function(data_df) {
  # get the number of files
  num_files <- length(unique(data_df$short_filename[data_df$sequence == 1]))
  
  qc_df <- data_df %>%
    tidyr::pivot_longer(cols = c(-.data$Index, -.data$filename, -.data$compound, -.data$short_filename, -.data$sequence, -.data$acq_order),
                        names_to = "parameter",
                        values_to = "value") %>% 
    dplyr::group_by(.data$compound, .data$parameter) %>% 
    dplyr:: mutate(avg_all = mean(.data$value, na.rm = TRUE),
                   rsd_all = stats::sd(.data$value, na.rm = TRUE) / .data$avg_all * 100,
                   rsd_all_show = paste(.data$compound, " - ", format(.data$rsd_all, digits = 2, nsmall = 1), "%", sep = ""),
                   minmax_all = min(.data$value, na.rm = TRUE) / max(.data$value, na.rm = TRUE),
                   max_y = max(.data$value, na.rm = TRUE)) %>% 
    dplyr::group_by(.data$compound, .data$sequence, .data$parameter) %>% 
    dplyr::mutate(avg_per = mean(.data$value, na.rm = TRUE),
                  rsd_per = stats::sd(.data$value, na.rm = TRUE) / .data$avg_per * 100,
                  rsd_per_show = paste(format(.data$rsd_per, digits = 2, nsmall = 1), "%", sep = ""),
                  minmax_per = min(.data$value, na.rm = TRUE) / max(.data$value, na.rm = TRUE),
                  max_y = ifelse(.data$value == max(.data$value, na.rm = TRUE), .data$max_y, NA),
                  max_x = ifelse(.data$value == max(.data$value, na.rm = TRUE), num_files, NA)) %>% 
    dplyr::ungroup()
  
  
  return(qc_df)
}