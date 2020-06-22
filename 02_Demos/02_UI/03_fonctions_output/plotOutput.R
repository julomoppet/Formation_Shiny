library(shiny)
library(tidyverse)

ui <- fluidRow(
    column(width = 6,
           sliderInput(
    "slider",
    label = h3("Choisir le nombre d'observations"),
    min = 1,
    max = 50,
    value = 25
)),
column(width=8,
       plotOutput("plot")))

server <- function(input, output) {
    output$plot <- renderPlot({
        cars2 <- cars %>% sample_n(input$slider)
        plot(cars2,
             pch = 3,
             col = "Orange")
    })
}

shinyApp(ui, server)