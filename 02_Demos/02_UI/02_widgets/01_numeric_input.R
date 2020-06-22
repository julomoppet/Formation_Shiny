library(shiny)


ui <- fluidPage(verticalLayout(
    titlePanel("Exemple d'input numérique"),
    wellPanel(numericInput("num", label = h3("Input numérique"), value = 5)),
    plotOutput("plot1")))

server <- shinyServer(function(input, output) {
    v<- function() {return(c(1:input$num))}
    w<- function() {return(v()*v())}
    output$plot1 <- renderPlot( 
            plot(v(), w(), type = "S"))
})

shinyApp(ui, server)