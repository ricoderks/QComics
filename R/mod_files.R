#' files UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_files_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        column(
          width = 12,
          h3("Select MultiQuant result file."),
          p("Select exported result file from MultiQuant.")
        )
      ),
      fluidRow(
        column(
          width = 12,
          inputPanel(
            fileInput(
              inputId = ns("mq_file"),
              label = "Result file:",
              multiple = FALSE,
              accept = c(".txt")
            ),
            
            p(
              strong("File uploaded :")
            ),
            uiOutput(
              outputId = ns("show_result_file")
            )
          )
        )
      ),
      
      fluidRow(
        column(
          width = 12,
          h3("Select meta data file"),
          p("This should be a comma separated file with a header. See help for more information.")
        )
      ),
      
      fluidRow(
        column(
          width = 12,
          inputPanel(
            fileInput(
              inputId = ns("meta_file"),
              label = "Meta data file:",
              multiple = FALSE,
              accept = c(".csv")
            ),
            # show the name of the uploaded file
            p(
              strong("File uploaded :")
            ),
            uiOutput(
              outputId = ns("show_meta_file")
            )
          )
        )
      ),
      
      mod_report_ui(id = "report")
    )
  )
}

#' files Server Functions
#'
#' @noRd 
mod_files_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # add the module for report
    mod_report_server(id = "report")
    
  })
}
