#' files 
#'
#' @title Check the multiquant file
#' 
#' @description Check if the multiquant files contains the correct columns
#'
#' @param file path to file 
#'
#' @return return TRUE or FALSE
#'
#' @author Rico Derks
#'
#' @importFrom readr read_delim
#'
#' @noRd
check_result_file <- function(file){
  # get the column names
  file_cols <- colnames(readr::read_delim(file = file,
                                          n_max = 0,
                                          delim = "\t",
                                          show_col_types = FALSE))
  
  # the column names I want
  my_cols <- c("Index", "Original Filename", "Component Name", "Area", "Retention Time", "Width at 50%")
  
  # return result
  return(all(my_cols %in% file_cols))
}




#' @title Read multiquant file
#' 
#' @description Read a multiquant export file.
#' 
#' @param file path to the file
#'
#' @return data frame with all the results
#'
#' @author Rico Derks
#' 
#' @importFrom readr read_delim cols_only col_integer col_character col_double
#' @importFrom dplyr mutate select rename
#' @importFrom rlang .data
#' @importFrom magrittr %>%
#' @importFrom stringr str_match
#' 
#' @noRd
read_mq_file <- function(file) {
  data_df <- readr::read_delim(
    file = file,
    col_types = readr::cols_only(Index = readr::col_integer(),
                                 `Original Filename` = readr::col_character(),
                                 `Component Name` = readr::col_character(),
                                 Area = readr::col_double(),
                                 `Retention Time` = readr::col_double(),
                                 `Width at 50%` = readr::col_double()),
    delim = "\t",
    na = c("", "NA", "N/A"),
    show_col_types = FALSE) %>% 
    dplyr::mutate(
      short_filename = str_match(string = .data$`Original Filename`,
                                 pattern = "([a-zA-Z_0-9]*)(\\.wiff)")[, 2]) %>% 
    dplyr::select(.data$Index, .data$`Original Filename`, .data$`Component Name`, .data$short_filename, .data$Area, .data$`Retention Time`, .data$`Width at 50%`) %>% 
    dplyr::rename(
      filename = .data$`Original Filename`,
      compound = .data$`Component Name`,
      area = .data$Area,
      ret_time = .data$`Retention Time`,
      width50 = .data$`Width at 50%`)
  
  return(data_df)
}
