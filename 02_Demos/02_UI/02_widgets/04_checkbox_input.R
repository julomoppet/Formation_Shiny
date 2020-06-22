library(shiny)
library(shinyWidgets)

ui <- fluidPage(
    checkboxGroupInput(
        inputId = "checkGroup", label = h4("Faites un ou plusieurs choix :"), 
        choices = c("Choix A", "Choix B")),
    hr(),
    fluidRow(column(3, verbatimTextOutput("value")))
)

server <- function(input, output) {
    output$value <- renderPrint({ input$checkGroup })
}

shinyApp(ui,server)