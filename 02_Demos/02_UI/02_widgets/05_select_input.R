library(shiny)

ui <- fluidPage(
    # Copy the line below to make a select box
    selectInput(
        "select",
        label = h3("Select box"),
        choices = list(
            "Choice 1" = 1,
            "Choice 2" = 2,
            "Choice 3" = 3
        ),
        selected = 1
    ),
    
    hr(),
    fluidRow(column(3, verbatimTextOutput("value")))
    
)


server <- shinyServer(function(input, output) {
    output$value <- renderPrint({
        input$select
    })
})

shinyApp(ui, server)