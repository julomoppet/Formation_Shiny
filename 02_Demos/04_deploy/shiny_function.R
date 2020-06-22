binner <- function(var) {
    require(shiny)
    require(data.table)
    shinyApp(
        ui <- fluidPage(verticalLayout(
            fileInput("datatab", "Importer les données csv",
                      buttonLabel = "Fichier...")
        ),
        mainPanel(plotOutput("hist"))),
        
        server <- function(input, output) {
            output$hist <- renderPlot({
                req(input$datatab)
                mydata <- fread(input$datatab$datapath)
                names(mydata) <- c("x")
                hist(
                    mydata$x,
                    breaks = var,
                    col = "orange",
                    border = "white",
                    main = paste0("Histogramme avec ",var," barres")
                )
            })
        },
        options = list(height = 600, width = 500)
    )
}

