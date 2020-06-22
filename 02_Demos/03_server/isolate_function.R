library(shiny)

ui <- fluidPage(
    titlePanel("Fonction réactive"),
    sidebarLayout(
            sidebarPanel(
            numericInput(inputId = "obs",
                         label = "Nombre d'observations à afficher:",
                         value = 5),
            actionButton(inputId = "goButton",
                         label = "Clique!")
            
        ),
    mainPanel(
    plotOutput("distPlot")
        )
    )
)

server <- function(input, output) {
    output$distPlot <- renderPlot({
        dist <- rnorm(input$obs)
        input$goButton
        isolate(hist(dist))
    })}

shinyApp(ui, server)
