#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  
  # files section
  mod_files_server(id = "files")
  
  # about section
  mod_about_server(id = "about")
  
}
