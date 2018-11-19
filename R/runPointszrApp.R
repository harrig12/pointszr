#runPointszrApp.R

#' \code{runPointszrApp} launch the shiny app distributed with this package framework
#'
#' \code{runPointszrApp} launches the shiny app for which the code has been \cr
#' placed in \code{./inst/shiny-scripts/pointszrApp/}.
#' @export

runPointszrApp <- function() {
  appDir <- system.file("shiny-scripts", "pointszrApp", package = "pointszr")
  shiny::runApp(appDir, display.mode = "normal")
  return()
}

#[END]

