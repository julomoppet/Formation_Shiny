library(shiny)

ui <- fluidPage(verbatimTextOutput("renderprint"),
    verbatimTextOutput("rendertext"),
    textOutput("rendertext1"))

server <- function(input, output, session) {
    output$renderprint <- renderPrint({
        print("Ceci est un output avec renderPrint + verbatimTextOutput")})  
    output$rendertext <- renderText({
        "Ceci est un output avec renderText + verbatimTextOutput"})
    output$rendertext1 <- renderText({
        "Ceci est un output avec renderText + textOutput"})}

shinyApp(ui, server)