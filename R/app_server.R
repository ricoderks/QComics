#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  
  # hold all data for this app
  r <- reactiveValues(merge_data = NULL)
  
  # files section
  mod_files_server(id = "files",
                   r = r)
  
  # data section
  mod_raw_data_server(id = "raw_data",
                      r = r)
  mod_meta_data_server(id = "meta_data",
                       r = r)
  
  # about section
  mod_about_server(id = "about")
  
}
