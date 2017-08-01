#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source(file = 'EDA.R')

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "bootstrap.css",
                  titlePanel("Titanic Diaster Explortary"),
                  tabsetPanel(
                          tabPanel("DataView", 
                                   sidebarLayout(
                                           sidebarPanel(
                                                   numericInput(inputId='show_rows', 
                                                                label='Row you want to see', 
                                                                value=30,
                                                                min=1,
                                                                max=nrow(traindf1)),
                                                   helpText('You could select the number of row to see the dataset'),
                                                   submitButton('Go')
                                           ),
                                           mainPanel(
                                                   tableOutput('dataview')
                                           )
                                   )),
                          tabPanel("SingleVariable", 
                                   sidebarLayout(
                                           sidebarPanel(
                                                   sliderInput("bins","histogram bin Change:",
                                                               min = 1,max = 50,value = 30),
                                                   submitButton('Submit')
                                           ),
                                           mainPanel(
                                                   plotOutput("agePlot"),
                                                   br(),
                                                   plotOutput('fareplot')
                                           ))),
                          tabPanel("MultiVaraible", 
                                   sidebarPanel(
                                           radioButtons(inputId='method', 
                                                        label='Which Model you want to use as prediction',
                                                        choices=c('Logistic','Random Forest','Boosting')) ,
                                           submitButton('Submit'),
                                           textOutput('model')
                                   ),
                                   mainPanel(
                                           plotOutput('agevss'),
                                           plotOutput('farevss'),
                                           plotOutput('pclassvss'),
                                           plotOutput('sexvss')
                        )))
                  )
)
