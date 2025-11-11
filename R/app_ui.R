#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom utils packageVersion
#' 
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    
    # Your application UI logic 
    shiny::navbarPage(
      title = paste0("QC lipidomics / metabolomics | v", utils::packageVersion("QComics")),
      
      # Files
      shiny::tabPanel(
        title = "Files",
        mod_files_ui(id = "files")
      ),
      # end files
      
      # data
      shiny::navbarMenu(
        title = "Data",
        shiny::tabPanel(
          title = "Raw data",
          mod_raw_data_ui(id = "raw_data")
        ),
        shiny::tabPanel(
          title = "Meta data",
          mod_meta_data_ui(id = "meta_data")
        )
      ),
      # end data
      
      # QC overview
      shiny::navbarMenu(
        title = "QC overview",
        "Tables :",
        shiny::tabPanel(
          title = "All sequences",
          mod_qc_tables_ui(id = "table_all_seq")
        ),
        shiny::tabPanel(
          title  = "Per sequence",
          mod_qc_tables_ui(id = "table_per_seq")
        ),
        "----",
        "Graphs :",
        shiny::tabPanel(
          title = "All sequences",
          mod_qc_graphs_ui(id = "graphs_all_seq")
        ),
        shiny::tabPanel(
          title = "Per sequence",
          mod_qc_graphs_ui(id = "graphs_per_seq")
        )
      ),
      # end QC overview
      
      # Help
      shiny::navbarMenu(
        title = "Help",
        shiny::tabPanel(
          title = "Help",
          mod_help_ui(id = "help")
        ),
        "----",
        shiny::tabPanel(
          title = "About",
          mod_about_ui(id = "about")
        )
      )
      # end Help
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  shiny::tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'QComics'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

