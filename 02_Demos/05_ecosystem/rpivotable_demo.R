library(shiny)
library(gapminder)
library(rpivotTable)
library(tidyverse)

glimpse(gapminder)

# données source
source <- gapminder
source <- source %>% filter(year>=1977)
continents <- source %>%
    distinct(continent) %>% 
    arrange(continent) %>%
    t() %>% 
    as.character()

ui <- fluidPage(fluidRow(
    sidebarPanel(
    selectInput(
        inputId = "continent",
        label = "Choisissez un continent:",
        choices = continents,
        selected = "Europe"
    ), width = 4
),
mainPanel(rpivotTableOutput("pivot"))))

server <- function(input, output) {
    output$pivot <- renderRpivotTable({
        continent.choice <- input$continent
        mydata <- source %>%
            filter(continent == continent.choice) %>%
            dplyr::select(-continent)
        
        rpivotTable(
            mydata,
            rows = "country",
            cols = "year",
            aggregatorName = "Sum",
            vals = "pop",
            rendererName = "Table",
            width = "30%",
            height = "400px"
        )
    })
}

shinyApp(ui, server)

