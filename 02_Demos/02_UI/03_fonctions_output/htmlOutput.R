library(shiny)
library(maps)
library(mapdata)


# création d'une table de données
x_france<-map("france",
              xlim=c(-15,25), ylim=c(38,52))
france_names <- x_france$names
france_country <- rep("france",length(france_names))
df1 <- data.frame(country = france_country,
                  region = france_names)

x_italy<-map("italy",
             xlim=c(-15,25), ylim=c(38,52))
italy_names <- x_italy$names
italy_country <- rep("italy",length(italy_names))
df2 <- data.frame(country = italy_country,
                  region = italy_names)

df <- rbind(df1,df2)
rm(x_france, france_names, france_country, df1,
   x_italy, italy_names, italy_country, df2)


ui <- fluidPage(
    titlePanel("Démo RenderUI"),
    sidebarPanel(
      htmlOutput("country_selector"),
      htmlOutput("region_selector")
    ),
    
    mainPanel(
      plotOutput("plot1")
    )
  ) 


server <- function(input, output) {
  output$country_selector = renderUI({ 
    selectInput(inputId = "state", 
                label = "Pays:", 
                choices = as.character(unique(df$country)),
                selected = "france") 
  })
  output$region_selector = renderUI({
    data_available = df[df$country==input$state,"region"]
    data_available = sort(data_available)
    selectInput(inputId = "departement", 
                label = "Département:", 
                choices = unique(data_available), 
                selected = unique(data_available)[1])
  })
  
  output$plot1 = renderPlot({
    map("worldHires", region = input$state,
        xlim=c(-15,25), ylim=c(38,52))
    map( input$state, region = input$departement,
    add = T, fill = T, col = 'red')
  })
}

shinyApp(ui = ui, server = server) 
