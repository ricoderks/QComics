#' qc_tables UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom DT DTOutput
mod_qc_tables_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        column(
          width = 12,
          DT::DTOutput(
            outputId = ns("tbl_qc")
          )
        )
      )
    ) 
  )
}

#' qc_tables Server Functions
#'
#' @importFrom DT renderDT datatable styleInterval formatStyle
#'
#' @noRd 
mod_qc_tables_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # table with qc values
    output$tbl_qc <- DT::renderDT({
      req(r$qc_data)
      
      # make the data.frame nice
      nice_df <- switch(
        id,
        "table_all_seq" = make_nice_table(data_df = r$qc_data,
                                          sequence = "all"),
        "table_per_seq" = make_nice_table(data_df = r$qc_data,
                                          sequence = "per")
      )
      
      # determine number of compounds
      num_comp <- length(unique(nice_df$compound))
      
      # define some options for the datatable output
      dt_options <- list(dom = ifelse(id == "table_all_seq",
                                      "t",
                                      "tp"),
                         ordering = FALSE,
                         columnDefs = list(list(className = 'dt-center', 
                                                targets = 1:(ncol(nice_df) - 1))),
                         pageLength = num_comp)
      # set colors for the limits
      limit_colors <- c("black", "black", "red")
      # set the limits for the area
      area_limit_all <- 30
      area_limit_per <- 15
      # set the column names
      col_names_all <- "Compound,Mean peak area,RSD peak area [%],Min/max ratio,Mean retention time [min],RSD retention time [%],Mean peak width at 50% [min],RSD peak width at 50% [%]"
      col_names_per <- "Compound,Sequence,Mean peak area,RSD peak area [%],Min/max ratio,Mean retention time [min],RSD retention time [%],Mean peak width at 50% [min],RSD peak width at 50% [%]"
      
      # what columns we use for highlighting the limits
      area_rsd_col_all <- "rsd_all_area"
      area_rsd_col_per <- "rsd_per_area"
      rt_rsd_col_all <- "rsd_all_ret_time"
      rt_rsd_col_per <- "rsd_per_ret_time"
      
      # show the table
      DT::datatable(data = nice_df,
                    options = dt_options,
                    rownames = FALSE,
                    selection = "none",
                    colnames = strsplit(x = ifelse(id == "table_all_seq",
                                                   col_names_all,
                                                   col_names_per),
                                        split = ",")[[1]]) |>
        DT::formatStyle(columns = ifelse(id == "table_all_seq",
                                         area_rsd_col_all,
                                         area_rsd_col_per),
                        color =  DT::styleInterval(c(0, 
                                                     ifelse(id == "table_all_seq",
                                                            area_limit_all,
                                                            area_limit_per)),
                                                   limit_colors)) |>
        DT::formatStyle(columns = ifelse(id == "table_all_seq",
                                         rt_rsd_col_all,
                                         rt_rsd_col_per),
                        color =  DT::styleInterval(c(0, 1), limit_colors))
    })
    
    
    
  })
}
