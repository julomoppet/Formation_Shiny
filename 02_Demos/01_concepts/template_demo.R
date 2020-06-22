
# Ceci est une application Shiny
# Vous pouvez la lancer en cliquant sur le bouton "Run App"

library(shiny)

# Définition de l'UI
ui <- fluidPage(

    # titre de l'application
    titlePanel("Old Faithful Geyser Data"),

    # sidebar
    sidebarLayout(
        sidebarPanel(
            # input slider pour le choix du nombre de barres
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Affichage du graphique
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Definition du server
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # création des barres sur la base de input$bins en provenance de l'UI
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # on trace l'histogramme avec les nombre de barre qui vient d'être spécifié
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Lancement de l'application
shinyApp(ui = ui, server = server)
