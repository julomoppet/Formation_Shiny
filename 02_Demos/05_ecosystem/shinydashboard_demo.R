library(shinydashboard)
library(leaflet)
library(sp)
library(tidyverse)
library(raster)

# données

belgique <- raster::getData("GADM", country = "BEL", level = 2)
belgique.data <- belgique@data

choix.provinces <-
    belgique.data %>% dplyr::select(NAME_2) %>% arrange(NAME_2) %>%
    t() %>% as.character()

france <- raster::getData("GADM", country = "FRA", level = 2)
france.data <- france@data

choix.depart <-
    france.data %>% dplyr::select(NAME_2) %>% arrange(NAME_2) %>%
    t() %>% as.character()

# dashboard
ui <- dashboardPage(
    skin = "green",
    dashboardHeader(title = "Exemple de Shiny Dashboard", titleWidth = 400),
    dashboardSidebar(sidebarMenu(
        menuItem("Belgique",
                 tabName = "belgique",
                 icon = icon("beer")),
        menuItem("France",
                 tabName = "france",
                 icon = icon("wine-glass-alt"))
        
    )),
    dashboardBody(tabItems(
        tabItem(tabName = "belgique",
                fluidRow(
                    leafletOutput("map1"),
                    selectInput(
                        "provname",
                        label = "Quelle province?",
                        choices = choix.provinces,
                        selected = "Bruxelles"
                    )
                    
                )),
        tabItem(tabName = "france",
                fluidRow(
                    leafletOutput("map2"),
                    selectInput(
                        "depname",
                        label = "Quel département?",
                        choices = choix.depart,
                        selected = "Paris"
                    )
                    
                ))
    ))
)

server <- function(input, output) {
    output$map1 <- renderLeaflet({
        mymap <- subset(belgique, NAME_2 == input$provname)
        leaflet(mymap) %>%
            addProviderTiles(providers$OpenStreetMap.France) %>%
            addPolygons(color = "#E3122A")
    })
    output$map2 <- renderLeaflet({
        mymap <- subset(france, NAME_2 == input$depname)
        leaflet(mymap) %>%
            addProviderTiles(providers$OpenStreetMap.France) %>%
            addPolygons(color = "#E3122A")
    })
}

shinyApp(ui, server)
