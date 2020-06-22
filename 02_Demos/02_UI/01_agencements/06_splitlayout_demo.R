library(shiny)

ui <- splitLayout(
    
    cellWidths = c("25%", "25%", "50%"),
    ,
    plotOutput("plot1"),
    plotOutput("plot2"),
    plotOutput("plot3"),
    
)

server <- function(input, output) {
    output$plot1 <- renderPlot(plot(cars))
    output$plot2 <- renderPlot(plot(pressure))
    output$plot3 <- renderPlot(plot(AirPassengers))
}

shinyApp(ui, server)
