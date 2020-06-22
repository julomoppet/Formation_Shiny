library(shiny)
library(shinythemes)

ui <- tagList(
    shinythemes::themeSelector(),
    navbarPage(
        "Démo shinythemes",
        tabPanel(
            "Navbar 1",
            sidebarPanel(
                fileInput("file", "Fichier input:"),
                textInput("txt", "Input Texte:", "general"),
                sliderInput("slider", "Slider :", 1, 100, 30),
                tags$h5("actionButton par défaut:"),
                actionButton("action", "Search"),
                
                tags$h5("actionButton avec CSS:"),
                actionButton("action2", "Action button", class = "btn-primary")
            ),
            mainPanel(tabsetPanel(
                tabPanel(
                    "Tab 1",
                    h4("Table"),
                    tableOutput("table"),
                    h4("Verbatim text output"),
                    verbatimTextOutput("txtout"),
                    h1("Header 1"),
                    h2("Header 2"),
                    h3("Header 3"),
                    h4("Header 4"),
                    h5("Header 5")
                ),
                tabPanel("Tab 2", "A remplir"),
                tabPanel("Tab 3", "A remplir")
            ))
        ),
        tabPanel("Navbar 2", "A remplir"),
        tabPanel("Navbar 3", "A remplir")
    )
)
server <- function(input, output) {
    output$txtout <- renderText({
        paste(input$txt, input$slider, format(input$date), sep = ", ")
    })
    output$table <- renderTable({
        head(cars, 4)
    })
}

shinyApp(ui, server)