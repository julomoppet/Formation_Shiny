library(shiny)

ui <- fluidPage(
titlePanel("Sliders"),

  sidebarLayout(

    sidebarPanel(

      # Input: nombre entier  ----
      sliderInput("integer", "Entier:",
                  min = 0, max = 1000,
                  value = 500),

      # Input: décimal ----
      sliderInput("decimal", "Décimal:",
                  min = 0, max = 1,
                  value = 0.5, step = 0.1),

      # Input: intervalle  ----
      sliderInput("range", "Intervalle:",
                  min = 1.0, max = 5.0,
                  value = c(0.5,3.8),step=0.1),

      # Input:  valeur monétaire ----
      sliderInput("format", "Format monétaire:",
                  min = 0, max = 10000,
                  value = 0, step = 2500,
                  pre = "€", sep = ",",
                  animate = TRUE),

      # Input: Animation (intervalle en ms, en boucle)
      sliderInput("animation", "Animation en boucle:",
                  min = 1, max = 2000,
                  value = 1, step = 100,
                  animate =
                    animationOptions(interval = 300, loop = TRUE))

    ),

    mainPanel(

      tableOutput("values")

    )
  )
)

server <- function(input, output) {
  sliderValues <- reactive({

    data.frame(
      Name = c("Integer",
               "Decimal",
               "Range",
               "Custom Format",
               "Animation"),
      Value = as.character(c(input$integer,
                             input$decimal,
                             paste(input$range, collapse = " "),
                             input$format,
                             input$animation)),
      stringsAsFactors = FALSE)

  })

  output$values <- renderTable({
    sliderValues()
  })

}

shinyApp(ui, server)
