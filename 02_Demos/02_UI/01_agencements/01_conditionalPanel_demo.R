library(shiny)

ui <- fluidPage(
    
    titlePanel("Conditional panels"),
    
    column(1, wellPanel(
        sliderInput("n", "Nombre de points:",
                    min = 10, max = 100, value = 50, step = 10)
    )),
    
    column(5,
           "Le graphique ne sera affiché que si le nombre de points",
           "est supérieur à 50.",
           conditionalPanel("input.n >= 50",
                            plotOutput("scatterPlot", height = 300)
           )
    )
)

server <- shinyServer(function(input, output) {
    
    output$scatterPlot <- renderPlot({
        x <- rnorm(input$n)
        y <- rnorm(input$n)
        plot(x, y)
    })
    
})

shinyApp(ui, server)