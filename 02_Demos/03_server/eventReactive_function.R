library(shiny)


ui <- fluidPage(column(
    4,
    numericInput("x", "Nombre de valeurs?", 5),
    br(),
    actionButton("button", "Montrer")
),
column(8, tableOutput("table")))

server <- function(input, output) {

    df <- eventReactive(input$button, {
        head(cars, input$x)
    })
    output$table <- renderTable({
        df()
    })
}

shinyApp(ui, server)
