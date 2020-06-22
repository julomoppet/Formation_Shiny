library(shiny)
library(markdown)


ui <- fluidPage(
    style = "padding-top: 80px;",
    h1("Démo absolutePanel"),
    absolutePanel(
        bottom = 20,
        right = 20,
        width = 300,
        draggable = TRUE,
        wellPanel(
            HTML(markdownToHTML(
                fragment.only = TRUE,
                text = c(
                    "Ceci est un absolutePanel avec l'option `draggable = TRUE`. Vous pouvez y placer tout type d'inputs et d'outputs:"
                )
            )),
            sliderInput(
                "n",
                "",
                min = 3,
                max = 20,
                value = 5
            ),
            plotOutput("plot2", height = "200px")
        ),
        style = "opacity: 0.92"
    ),
    absolutePanel(
        top = 0,
        left = 0,
        right = 0,
        fixed = TRUE,
        div(style = "padding: 8px; border-bottom: 1px solid #CCC; background: #FFFFEE;",
            HTML(
                markdownToHTML(
                    fragment.only = TRUE,
                    text = c(
                        "Cet absolutePanel est ancré en haut de l'écran. Grâce à l'option `fixed=TRUE`, il ne défilera pas avec le reste de la page."
                    )
                )
            ))
    ),
    plotOutput("plot", height = "500px")
)

server <- shinyServer(function(input, output, session) {
    output$plot <- renderPlot({
        mtscaled <- as.matrix(scale(mtcars))
        heatmap(
            mtscaled,
            col = topo.colors(200, alpha = 0.5),
            Colv = F,
            scale = "none"
        )
    })
    
    output$plot2 <- renderPlot({
        plot(head(cars, input$n), main = "Foo")
    }, bg = "#F5F5F5")
})

shinyApp(ui, server)
