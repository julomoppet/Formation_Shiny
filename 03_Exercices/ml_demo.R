library(shiny)
library(shinythemes)
library(scales)
library(tidyverse)
library(readr)

setwd("D:/01_Soft_Computing/Data_Science/Formation_Shiny/live/03_Exercices")

# # https://www.kaggle.com/arjunbhasin2013/ccdata
# source <- read_csv("German_Credit/sources/CC GENERAL.csv")
# mydata <- source %>% dplyr::select(-CUST_ID) %>% na.omit()
# saveRDS(mydata,"German_Credit/credit_card.rds")

mydata <- readRDS("German_Credit/credit_card.rds")

ui <- fluidPage(theme = shinytheme("spacelab"),
    column(
        width = 12,
        numericInput(
            "slider",
            label = h3("Nombre de segments"),
            value = 1)
        
    ),
    column(width = 6,
           plotOutput("plot"))
)

server <- function(input, output) {
    output$plot <- renderPlot({
        km.source <- kmeans(mydata, input$slider,iter.max = 100)
        mydata_cl <- bind_cols(mydata, SEGMENT = km.source$cluster)
        mydata_sc <- mydata_cl %>%
            dplyr::select(BALANCE, PURCHASES, SEGMENT) %>%
            mutate(
                BALANCE = rescale(BALANCE, to = c(0, 1000)),
                PURCHASES = rescale(PURCHASES, to = c(0, 1000))
            ) %>%
            mutate(BALANCE = log(BALANCE),
                   PURCHASES = log(PURCHASES))
        ggplot(mydata_sc,
               aes(x = BALANCE,
                   y = PURCHASES,
                   col = SEGMENT)) +
            geom_point() +
            scale_color_gradientn(colours = rainbow(input$slider))
    })
}

shinyApp(ui, server)


