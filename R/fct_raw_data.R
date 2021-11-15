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
