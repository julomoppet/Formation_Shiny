library(shiny)
library(dygraphs)
library(datasets)

ui <- fluidPage(
    
    titlePanel("Prédiction de mortalité en raison de maladie pulmonaire"),
    
    sidebarLayout(
        sidebarPanel(
            numericInput("months", label = "Mois à prédire", 
                         value = 72, min = 12, max = 144, step = 12),
            selectInput("interval", label = "Intervalle de confiance",
                        choices = c("0.80", "0.90", "0.95", "0.99"),
                        selected = "0.95"),
            checkboxInput("showgrid", label = "Grille", value = TRUE)
        ),
        mainPanel(
            dygraphOutput("dygraph")
        )
    )
)



server <- function(input, output) {
    
    predicted <- reactive({
        hw <- HoltWinters(ldeaths)
        predict(hw, n.ahead = input$months, 
                prediction.interval = TRUE,
                level = as.numeric(input$interval))
    })
    
    output$dygraph <- renderDygraph({
        dygraph(predicted(), main = "Décès / mois") %>%
            dySeries(c("lwr", "fit", "upr"), label = "Décès") %>%
            dyOptions(drawGrid = input$showgrid)
    })
    
}


shinyApp(ui, server)
