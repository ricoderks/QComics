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
    navbarPage(
      title = paste0("QC lipidomics / metabolomics | v", utils::packageVersion("QComics")),
      
      # Files
      tabPanel(
        title = "Files",
        mod_files_ui(id = "files")
      ),
      # end files
      
      # data
      navbarMenu(
        title = "Data",
        tabPanel(
          title = "Raw data",
          mod_raw_data_ui(id = "raw_data")
        ),
        tabPanel(
          title = "Meta data",
          mod_meta_data_ui(id = "meta_data")
        )
      ),
      # end data
      
      # QC overview
      navbarMenu(
        title = "QC overview",
        "Tables :",
        tabPanel(
          title = "All sequences"
        ),
        tabPanel(
          title  = "Per sequence"
        ),
        "----",
        "Graphs :",
        tabPanel(
          title = "All sequences"
        ),
        tabPanel(
          title = "Per sequence"
        )
      ),
      # end QC overview
      
      # Help
      navbarMenu(
        title = "Help",
        tabPanel(
          title = "Help",
          mod_help_ui(id = "help")
        ),
        "----",
        tabPanel(
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
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'QComics'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

