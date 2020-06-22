library("shiny")
library("rbokeh")
library("dplyr")
library("magrittr")

ui <- fluidPage(h1("Démo de RBokeh"),
                fluidRow(
                    column(
                    width = 3,
                    class = "panel",
                    sliderInput("nobs", "Nombre d'observations à afficher",
                                min = 1, max = 50,
                                value = 10)),
                    column(
                        width = 3,
                        class = "panel",
                        sliderInput("taille", "Taille des points",
                                    min = 1, max = 50,
                                    value = 10)),
                    column(
                        width = 2,
                        class = "panel",
                        selectInput("couleur", "Couleur des points",
                                    choices = c("red","green","blue")))
                    ),
                column(width = 10,
                       rbokehOutput("rbokeh")))


server <- function(input, output) {
    output$rbokeh <- renderRbokeh({
        sample_cars <- sample_n(cars,input$nobs)
        figure() %>%
            ly_points(speed, 
                      dist, 
                      data = sample_cars,
                      size = input$taille,
                      color = input$couleur,
                      hover = c(speed, dist))%>%
            tool_box_select() %>%
            tool_lasso_select()
    })
}

shinyApp(ui, server)