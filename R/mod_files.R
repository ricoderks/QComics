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
      
      # add the ui for the report
      # ns is needed here because I'am calling a module in a module
      mod_report_ui(id = ns("report"))
    )
  )
}

#' files Server Functions
#'
#' @noRd 
mod_files_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # add the module for report
    mod_report_server(id = "report",
                      r = r)
    
    # upload multiquant file
    observe({
      req(input$mq_file)
      
      # get the info about the file
      r$mq_file <- input$mq_file$name
      r$mq_path <- input$mq_file$datapath
      
      # check if the path exists
      if(check_result_file(r$mq_path)) {
        # if so read the mq file
        r$mq_data <- read_mq_file(file = r$mq_path)
      } else {
        r$mq_file = -1
      }
    })
    
    # show the file name of the multiquant file
    output$show_result_file <- renderUI({
      # check if a file is uploaded
      if (!is.null(r$mq_file)) {
        # if so, check if the file was correct
        if (r$mq_file == -1) {
          "Incorrect file uploaded"
        } else {
          # else show the file name
          r$mq_file
        }
      } 
    })
    
    # read the meta data
    observe({
      req(input$meta_file)
      
      # store the real filename
      r$meta_file <- input$meta_file$name
      r$meta_path <- input$meta_file$datapath
      
      if(check_meta_file(file = r$meta_path) == TRUE) {
        # read the meta file
        r$meta_data <- read_meta_file(file = r$meta_path)
        
      } else {
        r$meta_file <- -1
      }
    })
    
    # merge the mq data with the meta data
    observe({
      req(r$mq_data,
          r$meta_data)
      
      if(!is.null(r$mq_data) & !is.null(r$meta_data)) {
        r$merge_data <- merge_data(mq_data = r$mq_data,
                                   meta_data = r$meta_data)
      }
    })
    
    # show the filenames of the uploaded meta file
    output$show_meta_file <- renderUI({
      if (!is.null(r$meta_file)) {
        if (r$meta_file == -1) {
          "Incorrect file uploaded"
        } else {
          r$meta_file
        }
      }
    })
    
  })
}
