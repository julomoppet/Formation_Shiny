library(shiny)

ui <- fluidPage(
    radioButtons(
        "radio",
        label = h3("Exemple de boutons radio"),
        choices = list(
            "Choix 1" = 1,
            "Choix 2" = 2,
            "Choix 3" = 3
        ),
        selected = 1
    ),
    
    hr(),
    fluidRow(column(3, textOutput("value")))
    
)

server <- function(input, output) {
    output$value <- renderText({ 
        paste("Vous avez fait le choix",input$radio) })
}

shinyApp(ui, server)

