library(shiny)
library(tidyverse)


ui <- fluidPage(fluidRow(column(
    6,
    radioButtons(
        "radio",
        label = h3("Choisir l'espèce pour afficher 5 observations"),
        choices = list(
            "setosa" = "setosa",
            "versicolor" = "versicolor",
            "virginica" = "virginica"
        ),
        selected = "setosa"
    )
),
column(12,
       tableOutput('table'))))

server <- function(input, output) {
    output$table <- renderTable({
        iris2 <- iris %>% 
            dplyr::filter(Species == input$radio) %>%
            dplyr::select(-Species) %>%
            sample_n(5)
        iris2
    })
}

shinyApp(ui, server)
