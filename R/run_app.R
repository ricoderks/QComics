#' Run the Shiny Application
#' @title Run the app
#'
#' @description Run the app 
#'
#' @param ... arguments to pass to golem_opts. 
#' See `?golem::get_golem_options` for more details.
#' @inheritParams shiny::shinyApp
#'
#' @export
#' 
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options 
run_app <- function(
  onStart = NULL,
  options = list(), 
  enableBookmarking = NULL,
  uiPattern = "/",
  ...
) {
  with_golem_options(
    app = shinyApp(
      ui = app_ui,
      server = app_server,
      onStart = onStart,
      options = options, 
      enableBookmarking = enableBookmarking, 
      uiPattern = uiPattern
    ), 
    golem_opts = list(...)
  )
}


#' run_in_browser - shortcut to launch in_browser
#' @title Run the app in the broweser
#'
#' @description Run the app in the browser when started manually from Rstudio
#'
#' @export
#'
run_in_browser <- function(){
  run_app(options = list(launch.browser = TRUE))
}