#' meta_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_meta_data_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        width = 12,
        DT::dataTableOutput(
          outputId = ns("tbl_meta_data")
        )
      )
    )
  )
}

#' meta_data Server Functions
#'
#' @noRd 
mod_meta_data_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    
  })
}
