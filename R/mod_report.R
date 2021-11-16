#' report UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_report_ui <- function(id){
  ns <- NS(id)
  
  tagList(
    fluidRow(
      column(
        width = 12,
        uiOutput(
          outputId = ns("report_UI")
        )
      )
    )
  )
}

#' report Server Functions
#'
#' @importFrom rmarkdown render
#'
#' @noRd 
mod_report_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # create the UI
    output$report_UI <- renderUI({
      # req(r$clean_data)
      
      if(!is.null(r$clean_data)) {
        tagList(
          h3("Report"),
          inputPanel(
            verticalLayout(
              downloadButton(
                outputId = ns("btn_report"),
                label = "Generate report"
              ),
              br(),
              textInput(
                inputId = ns("title_text"),
                label = "Title:"
              ),
              br(),
              textAreaInput(
                inputId = ns("info_text"),
                label = "Additional info / comments:",
                width = "400px",
                height = "150px",
                resize = "none"
              )
            )
          )
        )
      }
    })
    
    # download the report
    output$btn_report <- downloadHandler(
      # define the filename for download
      filename = "QC_report.html",
      
      # make the content
      content = function(file) {
        # get the text input fields
        r$info[1] <- input$title_text
        r$info[2] <- input$info_text
        
        # create copy of Rmd document in temp location
        # here you should have write permission
        temp_report <- file.path(tempdir(), "QC_report.Rmd")
        # create the location of the original Rmd file
        report_file <- system.file("report_templates", "QC_report.Rmd",
                                   package = "QComics")
        file.copy(from = report_file, 
                  to = temp_report,
                  overwrite = TRUE)
        
        # setup parameters to pass to Rmd document
        params <- list(my_data = r$qc_data,
                       info = r$info)
        
        # show progress
        withProgress(message = "Downloading....",
                     value = 0,
                     { # first mimmick some progress
                       incProgress(1/10)
                       Sys.sleep(1)
                       incProgress(5/10)
                       # create the document
                       rmarkdown::render(input = temp_report,
                                         output_file = file,
                                         params = params,
                                         envir = new.env(parent = globalenv()))
                     })
      } # end content
    )
    
    
    
  })
}

