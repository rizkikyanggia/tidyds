#' Run air quality app
#'
#' Launch shiny application.
#' @importFrom shiny runApp
#' @export
run_aq <- function() {
  app_dir <- system.file("aq", package = "tidyds")
  shiny::runApp(app_dir, display.mode = "normal")
}
