#' qc_graphs UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_qc_graphs_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        column(
          width = 12,
          
          selectInput(
            inputId = ns("seq_y"),
            label = "Show :",
            choices = c("Peak area" = "area",
                        "Retention time" = "ret_time",
                        "Peak width (50%)" = "width50")
          )
        )
      ),
      fluidRow(
        column(
          width = 12, 
          uiOutput(
            outputId = ns("plot_UI")
          )
        )
      )
    )
  )
}

#' qc_graphs Server Functions
#'
#' @noRd 
mod_qc_graphs_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    output$qc_plot <- renderPlot({
      req(r$qc_data,
          input$seq_y)
      
      # make sure the data is not empty
      if (!is.null(r$qc_data)) {
        # make the plot
        switch(
          id,
          "graphs_all_seq" = {
            my_plot <- make_qc_graph(data_df = r$qc_data,
                                     yaxis = input$seq_y,
                                     sequence = "all")
          },
          "graphs_per_seq" = {
            my_plot <- make_qc_graph(data_df = r$qc_data,
                                     yaxis = input$seq_y,
                                     sequence = "per")
          }
        )

      } else {
        my_plot <-  NULL
      }
      
      return(my_plot)
    })
    
    # render the plot as an UI
    output$plot_UI <- renderUI({
      # set the height of the plot
      my_height <- length(unique(r$clean_data$compound))

      tagList(
        # return the UI
        plotOutput(outputId = ns("qc_plot"),
                   height = paste0(my_height * 90, "px"))
      )
    })
    
  })
}
