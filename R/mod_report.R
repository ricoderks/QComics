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
          outputId = "report_download")
      )
    )
  )
}

#' report Server Functions
#'
#' @noRd 
mod_report_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
  })
}
