#runPointszrApp.R

#' \code{runPointszrApp} launch the shiny app distributed with this package framework
#'
#' \code{runPointszrApp} launches the shiny app for which the code has been \cr
#' placed in \code{./inst/shiny-scripts/pointszrApp/}. You can also find it \cr
#' online at https://harrig12.shinyapps.io/pointszrApp/
#' @return no return, app side effect
#' @examples
#' \dontrun{
#' runPointszrApp()
#' }
#' @export

runPointszrApp <- function() {
  appDir <- system.file("shiny-scripts", "pointszrApp", package = "pointszr")
  shiny::runApp(appDir, display.mode = "normal")
  return()
}

#[END]

