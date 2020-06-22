library(shiny)


ui <- fluidPage(fileInput(
  "fichier",
  label = h3("Fichier csv (delimiteur ;)"),
  multiple = FALSE,
  accept = c("text/csv",
             "text/comma-separated-values,text/plain",
             ".csv"),
  buttonLabel = "Chemin...",
  placeholder = "cliquez"
  
),
hr(),
fluidRow(column(3, tableOutput("fichier_up"))))


server <- function(input, output) {
  output$fichier_up <- renderTable({
    req(input$fichier)
    mydata <- read.csv(input$fichier$datapath,
                       sep = ";", encoding = "UTF-8")
    print(mydata)
  })
}



shinyApp(ui, server)
