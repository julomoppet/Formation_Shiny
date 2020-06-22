library(mapview)
library(raster)
library(tidyverse)
library(rgeos)


# données source
# https://gadm.org/download_country_v3.html
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
        tabPanel("Population", mapviewOutput("population")),
        tabPanel("Km2", mapviewOutput("aire")),
        tabPanel("Evolution de la population", mapviewOutput("evol"))
    )
)))

server <- function(input, output) {
    
    output$population <- renderMapview({
        mapview(ireland, zcol="POP")})    
    output$aire <- renderMapview({
        mapview(ireland, zcol="AREA")})    
    output$evol <- renderMapview({
        mapview(ireland, zcol="CHANGE")})    

}

shinyApp(ui, server)



