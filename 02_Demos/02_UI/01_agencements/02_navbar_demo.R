library(shiny)

ui <- fluidPage(navbarPage(
    "Le dataset cars",
    tabPanel("Graphiques",
             icon = icon("shapes"),
             sidebarLayout(
                 sidebarPanel(radioButtons(
                     "plotType", "Type de graphique",
                     c("Scatter" = "p", "Line" =
                           "l")
                 )),
                 mainPanel(plotOutput("plot"))
             )),
    tabPanel("Stats descriptives",
             verbatimTextOutput("summary"),
             icon = icon("calculator")),
    navbarMenu(
        "Plus",
        tabPanel("Tableau",
                 DT::dataTableOutput("table"),
                 icon = icon("tablets")),
        tabPanel(
            "Image",
            img(
                class = "img-polaroid",
                src = paste0(
                    "http://upload.wikimedia.org/",
                    "wikipedia/",
                    "fr/b/bc/Logo_cars.png"
                )
            ),
            icon = icon("image")
        )
    )
))

server <- shinyServer(function(input, output, session) {
    output$plot <- renderPlot({
        plot(cars, type = input$plotType)
    })
    
    output$summary <- renderPrint({
        summary(cars)
    })
    
    output$table <- DT::renderDataTable({
        DT::datatable(cars)
    })
})

shinyApp(ui, server)