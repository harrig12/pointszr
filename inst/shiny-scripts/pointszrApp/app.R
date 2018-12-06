#pointszrApp.R

#built based on https://shiny.rstudio.com/gallery/file-upload.html
#with reference to
    #https://stackoverflow.com/questions/30991900/avoid-double-refresh-of-plot-in-shiny
    #https://shiny.rstudio.com/tutorial/written-tutorial/lesson5/


library(shiny)
library(stats)

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

      # Input: Select number of rows to display ----
      radioButtons("showHead", "Display",
                   choices = c(Head = "head",
                               All = "all"),
                   selected = "head"),

      # Horizontal line ----
      tags$hr(),

      fluidRow(
        column(width = 4,
               tableOutput("contents")
        )
      )

    ),

    # Main panel for displaying outputs ----
    mainPanel(

      fluidRow(

        # Input: Checkbox whether to invert point selection and add labels ----
        column(width = 4,
               checkboxInput("invertSel", "invert point selection", FALSE),
               checkboxInput("addLab", "add labels to selected points", FALSE)),


        # Input: Slider for selected point size
        column(width = 4, sliderInput("pointSz", "selected point size",
                                      min = 0.5, max = 6, value = 1, step= 0.25)),

        # Input: Select colour ----
        column(width = 4, radioButtons("pointCol", "selected point colour",
                                       choices = c("black" = 1,
                                                   "red" = 2,
                                                   "blue" = 4),
                                       selected = 1))
      ),

      fluidRow(
        plotOutput("plot1", height = 600,
           # Equivalent to: click = clickOpts(id = "plot_click")
           click = "plot1_click",
           brush = brushOpts(
             id = "plot1_brush"
           )
        )
      ),

      fluidRow(
        column(width = 12,
               h4("Brushed points"),
               verbatimTextOutput("brush_info")
        )
      )

    )
  )

)



# Define server logic to read selected file ----
pointszrServer <- function(input, output) {

  output$contents <- renderTable({

    req(input$file1)

    tryCatch({
      userData <- read.csv(input$file1$datapath,
                           header = input$header,
                          sep = input$sep,
                          quote = input$quote)
      },

      error = function(e) {
        # return a safeError if a parsing error occurs
        stop(safeError(e))
      }
    )

    if(input$showHead == "head") {
      return(head(userData))
    }
    else {
      return(userData)
    }

  })

  #Create buffer for point selection
  brushSet <- reactiveValues(brush = NULL)

  #Observe point selection
  observeEvent(eventExpr = input$plot1_brush,
               handlerExpr = {brushSet$brush <- input$plot1_brush})

  pointSel <- reactive({

    source(system.file("shiny-scripts/prepRes.R", package = "pointszr"), local = T)

      return(brushedPoints(resPoints, brushSet$brush,
                           xvar = "log2FoldChange",
                           yvar = "negative_log10_pvalue"))
  })

  #Plot
  output$plot1 <- renderPlot({

    source(system.file("shiny-scripts/prepRes.R", package = "pointszr"), local = T)

    #base plot
    pointszr::vplot(res)

    #overlay subset layers if some selection has been made
    if(is.null(brushSet$brush) == FALSE){

      if (input$invertSel){ #invert the point selection
        sel <- BiocGenerics::subset(res, !(rownames(res) %in% rownames(pointSel())))
        pointszr::overlay(sel, col=input$pointCol, szMod = input$pointSz,
                          labelPoints = input$addLab)
      }
      else {
        sel <- BiocGenerics::subset(res, rownames(res) %in% rownames(pointSel()))
        pointszr::overlay(sel, col=input$pointCol, szMod = input$pointSz,
                          labelPoints = input$addLab)
      }
    }
  })

  output$brush_info <- renderPrint({
    pointSel()
  })

}

#Define app ----
shinyApp(ui = pointszrUI, server = pointszrServer)

#[END]
