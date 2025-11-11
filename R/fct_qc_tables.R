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
        data_df |> 
          dplyr::group_by(.data$compound, .data$parameter) |> 
          dplyr::filter(dplyr::row_number() == 1) |> 
          dplyr::ungroup() |> 
          dplyr::select("compound", "avg_all", "rsd_all", "minmax_all", "parameter") |> 
          tidyr::pivot_wider(values_from = c("avg_all", "rsd_all", "minmax_all"), names_from = "parameter") |> 
          dplyr::select("compound", "avg_all_area", "rsd_all_area", "minmax_all_area", "avg_all_ret_time", "rsd_all_ret_time", "avg_all_width50", "rsd_all_width50") |> 
          dplyr::mutate(avg_all_area = round(avg_all_area),
                        rsd_all_area = format(.data$rsd_all_area, digits = 2, nsmall = 1),
                        minmax_all_area = format(.data$minmax_all_area, digits = 2, nsmall = 1),
                        avg_all_ret_time = format(.data$avg_all_ret_time, digits = 2, nsmall = 2),
                        rsd_all_ret_time = format(.data$rsd_all_ret_time, digits = 2, nsmall = 1),
                        avg_all_width50 = format(.data$avg_all_width50, digits = 2, nsmall = 1),
                        rsd_all_width50 = format(.data$rsd_all_width50, digits = 2, nsmall = 1)) |> 
          dplyr::arrange(.data$compound)
      },
      "per" = {
        data_df |>
          dplyr::group_by(.data$compound, .data$sequence, .data$parameter) |> 
          dplyr::filter(dplyr::row_number() == 1) |> 
          dplyr::ungroup() |> 
          dplyr::select("compound", "sequence", "avg_per", "rsd_per", "minmax_per", "parameter") |> 
          tidyr::pivot_wider(values_from = c("avg_per", "rsd_per", "minmax_per"), names_from = "parameter") |> 
          dplyr::select("compound", "sequence", "avg_per_area", "rsd_per_area", "minmax_per_area", "avg_per_ret_time", "rsd_per_ret_time", "avg_per_width50", "rsd_per_width50") |> 
          dplyr::mutate(avg_per_area = round(avg_per_area),
                        rsd_per_area = format(.data$rsd_per_area, digits = 2, nsmall = 1),
                        minmax_per_area = format(.data$minmax_per_area, digits = 2, nsmall = 1),
                        avg_per_ret_time = format(.data$avg_per_ret_time, digits = 2, nsmall = 2),
                        rsd_per_ret_time = format(.data$rsd_per_ret_time, digits = 2, nsmall = 1),
                        avg_per_width50 = format(.data$avg_per_width50, digits = 2, nsmall = 1),
                        rsd_per_width50 = format(.data$rsd_per_width50, digits = 2, nsmall = 1)) |> 
          dplyr::arrange(.data$sequence, .data$compound)
      })
  } else {
    message("'data_df' is NULL. There is no data!")
    nice_df <- NULL
  }
  
  return(nice_df)
}