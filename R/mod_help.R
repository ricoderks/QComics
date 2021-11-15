#' help UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_help_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        column = 12,
        h1("Import files"),
        p("There are 2 types of files you need to import:",
          HTML("<ul>
                  <li>MultiQuant result file</li>
               </ul>")
        ),
        h3("MultiQuant"),
        p("This app is tested with results exported from MultiQuant 3.0.2."),
        h3("Meta data"),
        p("The meta data file should be a ", 
          HTML("<i>comma separated</i>"), 
          " file with three columns. The first column should contain the filenames and is named", 
          HTML("<b><i>filename</i></b>."), 
          "The second column contains the sequence number and is named ", 
          HTML("<b><i>sequence</i></b>. the third column contains the acquisition order and is named "),
          HTML("<b><i>acq_order</i></b>."),
          "Example:",
          HTML("<table width=\"50%\">
               <tr><th>filename</th><th>sequence</th><th>acq_order</th></tr>
                <tr><td>QCpool_001</td><td>1</td><td>1</td></tr>
               <tr><td>QCpool_002</td><td>1</td><td>2</td></tr>
               <tr><td>QCpool_003</td><td>1</td><td>3</td></tr>
               <tr><td>QCpool_004</td><td>2</td><td>4</td></tr>
               <tr><td>QCpool_005</td><td>2</td><td>5</td></tr>
               <tr><td>QCpool_006</td><td>2</td><td>6</td></tr>
               </table>")
        ),
        h3("Report"),
        p("A report can be downloaded with all the graphs.", 
          HTML("The <i>Title</i> can be used to add a title to the report. 
               The <i>comment</i> field can be used to add some extra information 
               about the sequence / samples.")
        )
      )
    )
  )
}

#' help Server Functions
#'
#' @noRd 
mod_help_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
  })
}
