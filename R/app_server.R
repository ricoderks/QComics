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
  
  # QC tables
  # all sequences together
  mod_qc_tables_server(id = "table_all_seq",
                       r = r)
  # per sequence
  mod_qc_tables_server(id = "table_per_seq",
                       r = r)
  
  # QC graphs
  # all sequences together
  mod_qc_graphs_server(id = "graphs_all_seq",
                       r = r)
  # per sequence
  mod_qc_graphs_server(id = "graphs_per_seq",
                       r = r)
  
  # about section
  mod_about_server(id = "about")
  
}
