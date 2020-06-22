library(shiny)


ui <- flowLayout(
    numericInput("rows", "Combien de lignes?", 5),
    selectInput("letter", "Quelle lettre de l'alphabet?", LETTERS),
    sliderInput("value", "Quelle valeur?", 0, 100, 50)
)
shinyApp(ui, server = function(input, output) { })
