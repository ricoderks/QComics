#' raw_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom DT dataTableOutput
mod_raw_data_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        column(
          width = 12,
          p("Click on a row to remove it from the data set. Click again on the row to put it back."),
          actionButton(
            inputId = ns("btnReset"),
            label = "Reset"),
          verbatimTextOutput(
            outputId = ns("rows_removed")
          ),
          hr()
        )
      ),
      
      fluidRow(
        column(
          width = 12,
          div(
            DT::dataTableOutput(
              outputId = ns("tbl_mq_data")
            ), 
            style = "font-size: 80%")
        )
      )
    )
  )
}

#' data Server Functions
#'
#' @importFrom DT renderDataTable datatable
#' 
#' @noRd 
mod_raw_data_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # generate table to show the content of the result files
    output$tbl_mq_data <- DT::renderDataTable({
      req(r$mq_data)
      
      # for now
      r$merge_data <- NULL
      
      # if there is no data don't show table
      if(!is.null(r$merge_data)) {
        # show merged data
        r$merge_data %>%
          # select(Index, filename, compound, short_filename, area, ret_time, width50, sequence, acq_order) %>%
          DT::datatable(options = list(dom = "ltp",
                                       pageLength = 25),
                        colnames = c("Index", "Filename", "Compound", "Short filename", "Area", "Retention time [min]", "Width at 50%", "Sequence", "Acquisition order"))
      } else if (!is.null(r$mq_data)) {
        # show only the mq data
        r$mq_data %>% 
          DT::datatable(options = list(dom = "ltp",
                                       pageLength = 25),
                        selection = "none",
                        colnames = c("Index", "Filename", "Compound", "Short filename", "Area", "Retention time [min]", "Width at 50%"))
      } 
    },
    server = FALSE)
  })
}
