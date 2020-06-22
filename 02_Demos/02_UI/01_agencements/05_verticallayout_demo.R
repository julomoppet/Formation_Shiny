library(shiny)

ui <- fluidPage(verticalLayout(
    titlePanel(tags$h2("Titre 1")),
    plotOutput("plot1"),
    wellPanel(sliderInput(
        "n",
        "Nombre de points",
        10,
        200,
        value = 50,
        step = 10
    ))
))

server <- shinyServer(function(input, output) {
    v<- function() {
        return(seq(-4,4,length = input$n))  
    }
    w<- function() {
        return(dnorm(v()))  
    }
    output$plot1 <- 
        renderPlot( 
            plot(v(),w(),pch=3, col="#FF4500"))
})

shinyApp(ui, server)
