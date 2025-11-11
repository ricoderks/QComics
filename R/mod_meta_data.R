#' meta_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom DT DTOutput
#' 
mod_meta_data_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        width = 12,
        DT::DTOutput(
          outputId = ns("tbl_meta_data")
        )
      )
    )
  )
}

#' meta_data Server Functions
#'
#' @importFrom DT renderDT datatable
#'
#' @noRd 
mod_meta_data_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # show the meta data file content
    output$tbl_meta_data <- DT::renderDT({
      req(r$meta_data)
      
      # if there is no data don't show table
      if (!is.null(r$meta_data)) {
        r$meta_data |>  
          DT::datatable(options = list(dom = "ltp",
                                       pageLength = 25),
                        selection = "none")
      }
    },
    server = FALSE)
  })
}
