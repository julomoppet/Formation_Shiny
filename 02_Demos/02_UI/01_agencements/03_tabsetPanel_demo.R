library(shiny)

species_vec <- as.character(unique(iris$Species))

ui <- fluidPage(
    titlePanel("Exemple de TabsetPanel"),
    sidebarLayout(
        sidebarPanel(
            selectInput("species","Sélectionnez une espèce:",
                       species_vec)),
            mainPanel(
                tabsetPanel(
                    tabPanel("Stats descriptives", tableOutput("table")),
                    tabPanel("Graphiques", plotOutput("plot"))
                ))))


server <- shinyServer(function(input, output) {
    sset <- reactive({subset(iris, Species == input$species)[,-5]})
    output$table <- renderTable({summary(sset())})
    output$plot <- renderPlot({plot(sset())})
})

shinyApp(ui, server)
