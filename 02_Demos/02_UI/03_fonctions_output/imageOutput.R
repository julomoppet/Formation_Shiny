library(shiny)

# download.file("https://upload.wikimedia.org/wikipedia/commons/5/56/Kosaciec_szczecinkowaty_Iris_setosa.jpg",
#               destfile = "img/iris_setosa.jpg")
# download.file("https://upload.wikimedia.org/wikipedia/commons/4/41/Iris_versicolor_3.jpg",
#               destfile = "img/iris_versicolor.jpg")
# download.file("https://upload.wikimedia.org/wikipedia/commons/9/9f/Iris_virginica.jpg",
#               destfile = "img/iris_virginica.jpg")

setwd("D:/01_Soft_Computing/Data_Science/Formation_Shiny/live/02_Demos/02_UI/03_fonctions_output/")

ui <- fluidPage(
  titlePanel("Output Image"),
  fluidRow(
    radioButtons(
      "radio",
      label = h3("Choisir l'espèce pour affichage"),
      choices = list(
        "setosa" = "setosa",
        "versicolor" = "versicolor",
        "virginica" = "virginica"
      ),
      selected = "setosa"),
    column(4,
      imageOutput("image2")
    )
  )
)


server <- function(input, output) {

  output$image2 <- renderImage({
    if(input$radio == "setosa"){
      list(src = "img/iris_setosa.jpg", height = 240, width = 300)
    }
    else if(input$radio == "versicolor"){
      list(src = "img/iris_versicolor.jpg", height = 240, width = 300)
    }
    else if(input$radio == "virginica"){
      list(src = "img/iris_virginica.jpg", height = 240, width = 300)
    }
  }, deleteFile = FALSE)
  }



shinyApp(ui,server)
