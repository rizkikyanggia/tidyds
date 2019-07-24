#' Run datavis app
#'
#' Launch shiny application.
#' @importFrom shiny runApp
#' @export
run_datavis <- function() {
  app_dir <- system.file("datavis", package = "tidyds")
  shiny::runApp(app_dir, display.mode = "normal")
}
