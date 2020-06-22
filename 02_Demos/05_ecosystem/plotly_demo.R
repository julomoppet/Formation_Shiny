library(plotly)
library(shiny)

ui <- fluidPage(
    plotlyOutput("plot"),
    verbatimTextOutput("brush")
)

server <- function(input, output, session) {
    
    output$plot <- renderPlotly({
    key <- row.names(mtcars)
       plot_ly(mtcars, x = ~mpg, y = ~wt, key = ~key) %>%
                layout(dragmode = "select")
        })

    
    output$brush <- renderPrint({
        d <- event_data("plotly_selected")
        if (is.null(d)) "Sélectionnez une zone (double-clic pour initialiser)" else d
    })
}

shinyApp(ui, server)

# https://plotly-r.com/