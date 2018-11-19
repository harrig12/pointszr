#pointszrApp.R

#built based on https://shiny.rstudio.com/gallery/file-upload.html
#with reference to

library(shiny)

# Define UI for data upload app ----
pointszrUI <- fluidPage(

  # App title ----
  titlePanel("Let's explore differential expression with volcano plots"),

  # Sidebar layout with input and output definitions ----
  #contains file upload info
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Select a file ----
      fileInput("file1", "Choose CSV File",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),

      # Horizontal line ----
      tags$hr(),

      # Input: Checkbox if file has header ----
      checkboxInput("header", "file has a header", TRUE),

      # Input: Select separator ----
      radioButtons("sep", "file separator",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = ","),

      # Input: Select quotes ----
      radioButtons("quote", "Quote",
                   choices = c(None = "",
                               "Double Quote" = '"',
                               "Single Quote" = "'"),
                   selected = '"'),

      # Horizontal line ----
      tags$hr(),

      # Input: Select number of rows to display ----
      radioButtons("showHead", "Display",
                   choices = c(Head = "head",
                               All = "all"),
                   selected = "head")

    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Data file ----
      tableOutput("contents")

    )
  ),

  fluidRow(
    column(width = 4,
           plotOutput("plot1", height = 300,
                      # Equivalent to: click = clickOpts(id = "plot_click")
                      click = "plot1_click",
                      brush = brushOpts(
                        id = "plot1_brush"
                      )
           )
    )
  ),
  fluidRow(
    column(width = 6,
           h4("Points near click"),
           verbatimTextOutput("click_info")
    ),
    column(width = 6,
           h4("Brushed points"),
           verbatimTextOutput("brush_info")
    )
  )
)

# Define server logic to read selected file ----
pointszrServer <- function(input, output) {

    intermediate <- NULL

    output$contents <- renderTable({

      req(input$file1)

      tryCatch(
        {
          #        df <- read.csv(input$file1$datapath,
          #                       header = input$header,
          #                       sep = input$sep,
          #                       quote = input$quote)
          userDDS <- pointszr:::fileToDESeq2(input$file1$datapath,
                                             header = input$header,
                                             sep = input$sep)
        },
        error = function(e) {
          # return a safeError if a parsing error occurs
          stop(safeError(e))
        }
      )

      intermediate$userDDS <- DESeq2::DESeq(userDDS)
      res <- DESeq2::results(intermediate$userDDS)
      intermediate$userRes <- res

      if(input$showHead == "head") {
        return(head(res))
      }
      else {
        return(res)
      }

  })

  output$designInfo <- renderText({
    designParse <- base::strsplit(intermediate$userRes@elementMetadata$description[2])
    designParse <- unlist(designParse)[2]
    retText <- sprintf("Contrast used for log2 fold change and Wald test p-value:
                       %s", designParse)
    return(retText)
  })

#  output$plot1 <- renderPlot({
#    #base plot
#    pointszr::vplot(intermediate$userRes)
#    #overlay subset layers
#    #pointszr::overlay()
#  })
#
#  output$click_info <- renderPrint({
#    # Because it's a ggplot2, we don't need to supply xvar or yvar; if this
#    # were a base graphics plot, we'd need those.
#    nearPoints(df, input$plot1_click, addDist = TRUE)
#  })
#
#  output$brush_info <- renderPrint({
#    brushedPoints(mtcars2, input$plot1_brush)
#  })

}

shinyApp(ui = pointszrUI, server = pointszrServer)

#[END]
