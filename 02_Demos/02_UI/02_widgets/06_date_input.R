library(shiny)

ui <- fluidPage(
    
    # Copy the line below to make a date selector 
    dateInput("date", label = h3("Date input"), value = "2014-01-01"),
    
    hr(),
    fluidRow(column(3, verbatimTextOutput("value")))
    
)

server <- function(input, output) {
    
    # You can access the value of the widget with input$date, e.g.
    output$value <- renderPrint({ input$date })
    
}

shinyApp(ui,server)