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
#' @importFrom DT renderDataTable datatable dataTableProxy selectRows
#' 
#' @noRd 
mod_raw_data_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # generate table to show the content of the result files
    output$tbl_mq_data <- DT::renderDataTable({
      req(r$mq_data)
      
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
    
    
    observeEvent(input$btnReset, {
      req(r$merge_data)
      
      proxy <- DT::dataTableProxy("tbl_mq_data")
      
      # remove row selection
      proxy %>% 
        DT::selectRows(NULL)
      
      # empty the global storage of rows
      r$s <- NULL
    })
    
    output$rows_removed <- renderPrint({
      req(r$clean_data)
      
      # r$s <- input$tbl_mq_data_rows_selected
      
      if (!is.null(r$s)) {
        # show which rows are removed
        cat("These rows will be removed from the data set :\n\n")
        cat(r$s, sep = ", ")
      } else {
        # no row selected
        cat("")
        # r$clean_data <- r$merge_data
      }
    })
    
    observe({
      req(r$merge_data)
      
      r$s <- input$tbl_mq_data_rows_selected
      
      if (!is.null(r$s)) {
        # remove the rows
        r$clean_data <- remove_rows(data_df = r$merge_data,
                                    rows = r$s)
      } else {
        # no row selected
        r$clean_data <- r$merge_data
      }
      
      # calculate the QC values
      r$qc_data <- calc_qc(data_df = r$clean_data)
    })
    
  })
}
