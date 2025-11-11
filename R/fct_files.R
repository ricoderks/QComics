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
check_result_file <- function(file = NULL){
  # check if file is not null
  if(!is.null(file)) {
    # does the file exist
    if(file.exists(file)) {
      # get the column names
      file_cols <- colnames(readr::read_delim(file = file,
                                              n_max = 0,
                                              delim = "\t",
                                              show_col_types = FALSE))
    }  else {
      message("'file' does not exist!")
      file_cols <- NULL
    } 
  } else {
    message("No file specified!")
    file_cols <- NULL
  }
  
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
#' @importFrom stringr str_match
#' 
#' @noRd
read_mq_file <- function(file = NULL) {
  # check if file is not null
  if(!is.null(file)) {
    # does the file exist
    if(file.exists(file)) {
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
        show_col_types = FALSE) |> 
        dplyr::mutate(
          short_filename = str_match(string = .data$`Original Filename`,
                                     pattern = "([a-zA-Z_0-9 _\\-]*)(\\.wiff)")[, 2]) |> 
        dplyr::select(.data$Index, .data$`Original Filename`, .data$`Component Name`, .data$short_filename, .data$Area, .data$`Retention Time`, .data$`Width at 50%`) |> 
        dplyr::rename(
          filename = .data$`Original Filename`,
          compound = .data$`Component Name`,
          area = .data$Area,
          ret_time = .data$`Retention Time`,
          width50 = .data$`Width at 50%`)
    }  else {
      message("'file' does not exist!")
      data_df <- NULL
    } 
  } else {
    message("No file specified!")
    data_df <- NULL
  }
  
  return(data_df)
}



#' @title Check the meta data file
#' 
#' @description Check if the meta data file contains the correct columns
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
# check the meta data file
check_meta_file <- function(file = NULL) {
  # several columns should be present
  # return TRUE if all is fine and FALSE if not
  # check if file is not null
  if(!is.null(file)) {
    # does the file exist
    if(file.exists(file)) {
      file_cols <- colnames(readr::read_delim(file = file,
                                              n_max = 0,
                                              delim = ",",
                                              show_col_types = FALSE))
    } else {
      message("'file' does not exist!")
      file_cols <- NULL
    } 
  } else {
    message("No file specified!")
    file_cols <- NULL
  }
  
  # the column names I want
  my_cols <- c("filename", "sequence", "acq_order")
  
  return(all(my_cols %in% file_cols))
}




#' @title Read meta data file
#' 
#' @description Read a meta data file.
#' 
#' @param file path to the file
#'
#' @return data frame with the meta data
#'
#' @author Rico Derks
#' 
#' @importFrom readr read_delim cols_only col_integer col_character
#' 
#' @noRd
read_meta_file <- function(file = NULL) {
  # check if file is not null
  if(!is.null(file)) {
    # does the file exist
    if(file.exists(file)) {
      data_df <- readr::read_csv(file = file,
                                 col_types = readr::cols_only(filename = readr::col_character(),
                                                              sequence = readr::col_integer(),
                                                              acq_order = readr::col_integer()),
                                 show_col_types = FALSE)
    } else {
      message("'file' does not exist!")
      data_df <- NULL
    }
  } else {
    message("No file specified!")
    data_df <- NULL
  }
  
  return(data_df)
}




#' @title Merge data
#'
#' @description Merge the multiquant data with the meta data
#' 
#' @param mq_data data.frame with multiquant data
#' @param meta_data data.frame with meta data
#'
#' @details 'mq_data' should contain a column named 'short_filename' and 
#'    'meta_data' should contain a column named 'filename'. Both columns contain
#'    the file name of the sample.
#'
#' @return the merge data
#' 
#' @importFrom dplyr left_join group_by filter ungroup
#' @importFrom rlang .data
#' 
#' @author Rico Derks
#'
#' @noRd
merge_data <- function(mq_data = NULL, meta_data = NULL) {
  if(!is.null(mq_data) & !is.null(meta_data)) {
    merge_df <- mq_data |> 
      left_join(y = meta_data,
                by = c("short_filename" = "filename")) |> 
      # remove compounds which have no peaks at all
      group_by(.data$compound) |>
      filter(any(!is.na(.data$area))) |>
      ungroup()
  } else {
    message("'mq_data' or 'meta_data' is NULL!")
    merge_df <- NULL
  }
  
  return(merge_df)
}
