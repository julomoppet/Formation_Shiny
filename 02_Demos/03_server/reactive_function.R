library(shiny)

ui <- fluidPage(
    titlePanel("Fonction réactive"),
    sidebarLayout(
            sidebarPanel(
            selectInput(inputId = "dataset",
                        label = "Choisir un dataset:",
                        choices = c("rock", "pressure", "cars")),
            numericInput(inputId = "obs",
                         label = "Nombre d'observations à afficher:",
                         value = 5)
            
        ),
    mainPanel(
    tableOutput("view")
        )
    )
)

server <- function(input, output) {
    datasetInput <- reactive({
        switch(input$dataset,
               "rock" = rock,
               "pressure" = pressure,
               "cars" = cars)
    })
    output$view <- renderTable({
        head(datasetInput(), n = input$obs)
    })
 }

shinyApp(ui, server)
