library(shiny)
library(DT)

cars2 <- cars %>% dplyr::mutate(temps = round(speed / dist, 2)) %>%
    rename(vitesse = speed,
           distance = dist)

ui <- fluidPage(h1('Tableau'),
                fluidRow(column(6, DT::dataTableOutput('x1')),
                         column(6, plotOutput('x2', height = 500))))

server <- shinyServer(function(input, output, session) {
    output$x1 = DT::renderDataTable(
        datatable(
            cars2,
            rownames = FALSE,
            colnames = c('Vitesse', 'Distance', 'Temps'),
            extensions = 'Buttons',
            options = list(dom = 'Bfrtip', buttons = c('copy'))
        ),
        server = FALSE
    )
    output$x2 = renderPlot({
        s = input$x1_rows_selected
        
        par(mar = c(4, 4, 1, .1))
        plot(cars)
        if (length(s))
            points(cars[s, , drop = FALSE],
                   pch = 19, cex = 2)
    })
})

shinyApp(ui, server)