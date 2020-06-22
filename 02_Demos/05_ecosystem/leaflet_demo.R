library(leaflet)
library(sp)
library(raster)
library(tidyverse)
library(readr)


# données source
ireland <- raster::getData("GADM", country = "IRL", level = 1)
ireland_data <- ireland@data
ireland_data$NAME_1[ireland_data$NAME_1 == "Laoighis"] <- "Laois"
ireland_data <- ireland_data %>% dplyr::rename("COUNTY" = "NAME_1")
# https://en.wikipedia.org/wiki/List_of_Irish_counties_by_population
pop <- read_delim(
    "ireland.csv",
    ";",
    escape_double = FALSE,
    trim_ws = TRUE
)
ireland_data <- inner_join(ireland_data, pop)
ireland@data <- ireland_data

ui <- fluidPage(fluidRow(mainPanel(
    tabsetPanel(
        tabPanel("Population", leafletOutput("population")),
        tabPanel("Km2", leafletOutput("aire")),
        tabPanel("Evolution de la population", leafletOutput("evol"))
    )
)))

server <- function(input, output) {

output$population <- renderLeaflet({
        pal <- colorNumeric(palette = "Blues",
                            domain = ireland$POP)
        labels <- sprintf("<strong>%s</strong><br/>%g  inhabitants",
                          ireland$COUNTY,
                          ireland$POP) %>% lapply(htmltools::HTML)
        leaflet(ireland) %>%
            addProviderTiles(providers$OpenStreetMap) %>%
            addPolygons(
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 0.5,
                fillColor = ~ pal(POP),
                highlightOptions = highlightOptions(
                    color = "white",
                    weight = 2,
                    bringToFront = TRUE
                ),
                label = labels,
                labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto"
                )
            ) %>%
            addLegend(
                "bottomright",
                pal = pal,
                values = ~ POP,
                title = "Population",
                opacity = 1
            )
    })    



output$aire <- renderLeaflet({
        pal <- colorNumeric(palette = "Greens",
                            domain = ireland$AREA)
        labels <- sprintf("<strong>%s</strong><br/>%g  km<sup>2</sup>",
                          ireland$COUNTY,
                          ireland$AREA) %>% lapply(htmltools::HTML)
        leaflet(ireland) %>%
            addProviderTiles(providers$OpenStreetMap) %>%
            addPolygons(
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 0.5,
                fillColor = ~ pal(AREA),
                highlightOptions = highlightOptions(
                    color = "white",
                    weight = 2,
                    bringToFront = TRUE
                ),
                label = labels,
                labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto"
                )
            ) %>%
            addLegend(
                "bottomright",
                pal = pal,
                values = ~ AREA,
                title = "Surface",
                labFormat = labelFormat(suffix = " km2"),
                opacity = 1
            )
    })    
    
    
    
output$evol <- renderLeaflet({
        pal <- colorNumeric(palette = "Oranges",
                            domain = ireland$CHANGE)
        labels <- sprintf("<strong>%s</strong><br/>%g  change",
                          ireland$COUNTY,
                          ireland$CHANGE) %>% lapply(htmltools::HTML)
        leaflet(ireland) %>%
            addProviderTiles(providers$OpenStreetMap) %>%
            addPolygons(
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 0.5,
                fillColor = ~ pal(CHANGE),
                highlightOptions = highlightOptions(
                    color = "white",
                    weight = 2,
                    bringToFront = TRUE
                ),
                label = labels,
                labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto"
                )
            ) %>%
            addLegend(
                "bottomright",
                pal = pal,
                values = ~ CHANGE,
                title = "Population Change",
                labFormat = labelFormat(suffix = "%"),
                opacity = 1
            )
    })
}

shinyApp(ui, server)


