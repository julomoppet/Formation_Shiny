library(shiny)
library(caret)
library(tidyverse)

# http://archive.ics.uci.edu/ml/datasets/Statlog+%28German+Credit+Data%29
data("GermanCredit")
df <- GermanCredit

ui <- fluidPage(titlePanel(div(h3("Comparaison de modèles"),style = "color: steelblue")),
                fluidRow(
                    column(6,
                           titlePanel(h4("Modèle 1")),
                        selectInput("mod1",
                                    "Modèle",
                            choices = c("rpart", "glm"),
                            selected = "rpart"),
                        sliderInput("ech1",
                                    "Taille de l'échantillon d'apprentissage en %",
                            min = .5,  max = .9, value = .7, step = .05),
                        numericInput("cv1",
                            "Nombre de validations croisées",
                            value = 5, min = 2, max = 10, step = 1),
                        br(div(h3("Résultats"),style = "color: steelblue")),
                        tableOutput("answer1"),
                        plotOutput("implot1")
                    ),
                    column(6,
                           titlePanel(h4("Modèle 2")),
                           selectInput("mod2",
                                       "Modèle",
                                       choices = c("rpart", "glm"),
                                       selected = "rpart"),
                           sliderInput("ech2",
                                       "Taille de l'échantillon d'apprentissage en %",
                                       min = .5,  max = .9, value = .7, step = .05),
                           numericInput("cv2",
                                        "Nombre de validations croisées",
                                        value = 5, min = 2, max = 10, step = 1),
                           br(div(h3("Résultats"),style = "color: steelblue")),
                           tableOutput("answer2"),
                           plotOutput("implot2")
                    )
                    ))



server <- shinyServer(function(input, output) {
    
    #### Modèle 1
    partition1 <-
        reactive({
            set.seed(1234)
            in.train <- createDataPartition(as.factor(df$Class),
                                            p = input$ech1,
                                            list = FALSE)
        })
    
    train1 <- reactive({
        in.train <- partition1()
        dTrain <- df[in.train, ]
    })
    
    test1 <- reactive({
        in.train <- partition1()
        dTest <- df[-in.train, ]
    })
    
    control1 <-
        reactive({
            ctrl <- trainControl(method = "cv", number = input$cv1)
        })
    
    model1 <- reactive({
        dTrain <- train1()
        ctrl <- control1()
        mode1 <- train(
            Class ~ .,
            data = dTrain,
            method = input$mod1,
            trControl = ctrl
        )
    })
    
    output$answer1 <- renderTable({
        model <- model1()
        dTest <- test1()
        pred.Class <- predict(model,
                              newdata = dTest)
        confMat <- table(dTest$Class, pred.Class)
        accu <- sum(diag(confMat)) / sum(confMat)
        fneg <- confMat[1, 2] / (confMat[1, 1] + confMat[1, 2])
        fpos <- confMat[2, 1] / (confMat[2, 1] + confMat[2, 2])
        dfres <- data.frame(
            PRECISION = 100 * accu,
            FAUX_NEGATIFS = 100 * fneg,
            FAUX_POSITIFS = 100 * fpos
        )
    })
    
    output$implot1 <- renderPlot({
        model <- model1()
        varimp <- varImp(model)
        temp <- varimp$importance
        temp$Variable <- rownames(temp)
        temp <- temp %>% arrange(desc(Overall)) %>% head(10) %>%
            dplyr::select(Variable, Importance = Overall)
        ggplot(data = temp,
               aes(x = reorder(Variable, Importance),
                   y = Importance))+ 
            geom_bar(stat = "identity", fill="steelblue") + coord_flip() +
            theme_minimal()
    })
    #### Modèle 2
    partition2 <-
        reactive({
            set.seed(1234)
            in.train <- createDataPartition(as.factor(df$Class),
                                            p = input$ech2,
                                            list = FALSE)
        })
    
    train2 <- reactive({
        in.train <- partition2()
        dTrain <- df[in.train, ]
    })
    
    test2 <- reactive({
        in.train <- partition2()
        dTest <- df[-in.train, ]
    })
    
    control2 <-
        reactive({
            ctrl <- trainControl(method = "cv", number = input$cv2)
        })
    
    model2 <- reactive({
        dTrain <- train2()
        ctrl <- control2()
        mode1 <- train(
            Class ~ .,
            data = dTrain,
            method = input$mod2,
            trControl = ctrl
        )
    })
    
    output$answer2 <- renderTable({
        model <- model2()
        dTest <- test2()
        pred.Class <- predict(model,
                              newdata = dTest)
        confMat <- table(dTest$Class, pred.Class)
        accu <- sum(diag(confMat)) / sum(confMat)
        fneg <- confMat[1, 2] / (confMat[1, 1] + confMat[1, 2])
        fpos <- confMat[2, 1] / (confMat[2, 1] + confMat[2, 2])
        dfres <- data.frame(
            PRECISION = 100 * accu,
            FAUX_NEGATIFS = 100 * fneg,
            FAUX_POSITIFS = 100 * fpos
        )
    })
    
    output$implot2 <- renderPlot({
        model <- model2()
        varimp <- varImp(model)
        temp <- varimp$importance
        temp$Variable <- rownames(temp)
        temp <- temp %>% arrange(desc(Overall)) %>% head(10) %>%
            dplyr::select(Variable, Importance = Overall)
        
        ggplot(data = temp,
                        aes(x = reorder(Variable, Importance),
                            y = Importance))+ 
            geom_bar(stat = "identity", fill="steelblue") + coord_flip() +
            theme_minimal()
    })
    
})

shinyApp(ui, server)
