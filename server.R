#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
#This is the server stuff
library(shiny)
library(plotly)
source(file = 'EDA.R')
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        #first tab1
        output$dataview <- renderTable(traindf1%>%filter(row_number()<=input$show_rows))
        #second tab2
        output$agePlot <- renderPlot({
                ggplot(traindf1,aes(Age))+
                        geom_histogram(bins = input$bins, color='white',fill='red')+
                        labs(title='Age Distribution')
        })
        
        output$fareplot <- renderPlot({
                ggplot(traindf1,aes(Fare))+
                        geom_histogram(bins = input$bins, color='white',fill='blue')+
                        labs(title='fare Distribution')
        })
        #third tab3
        output$agevss <- renderPlot({
                ggplot(traindf1,aes(x=Survived,y=Age))+
                        geom_boxplot()
        })
        output$farevss <- renderPlot({
                ggplot(traindf1,aes(x=Survived,y=Fare))+
                        geom_boxplot()
        })
        output$pclassvss <- renderPlot({
                ggplot(traindf1,aes(x=Pclass,fill=Survived))+
                               geom_bar(position='fill')
        })
        output$sexvss <- renderPlot({
                ggplot(traindf1,aes(x=Sex,fill=Survived))+
                               geom_bar(position='fill')
        })
        output$model <- renderPrint({
                if (input$method =='Logistic'){
                        confusionMatrix(predict(logfit,valid),valid$Survived)
                }else if (input$method == 'Random Forest'){
                        confusionMatrix(predict(rffit,valid),valid$Survived)
                }else if (input$method =='Boosting'){
                        confusionMatrix(predict(gbmfit,valid),valid$Survived)
                }
        })
        
})