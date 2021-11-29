library(shiny)
library(shinydashboard)
library(readr)
library(sf)
library(dplyr)
library(ggplot2)
library(roxygen2)
library(ggiraph)


source("App_functions.R")
source("data_acquisition.R")


ui <- dashboardPage(
  dashboardHeader(title="Game of Thrones data Analysis"),
  
  dashboardSidebar(
    br(),
    selectInput("saison", "Choose a season", 
                choices = c(1, 2, 3, 4, 5, 6, 7, 8),),
  selectInput("episode", "Choose an Episode",
              choices = c(1,2,3,4,5),),
  radioButtons("ds", "See the place of :",
    choices = c("Scenes", "Death people")),
  actionButton("btn1", "Afficher"),
  
  selectInput("names", "Choose character name:",character_name_list),

  selectInput(inputId="df",label="Select datasets",
              choices =  c('appearances', 'characters', 'episodes', 
                           'populations', 'scenes'))
  ),
  
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
    tags$header(
      tags$img(
        src = "ecc.png",
        title = "Ecole Centrale Casablanca",
        width = "70",
        height = "45",
        class = "logo"
      ),
      tags$b("GoT Data Visualisation Application", class = "titre")
    ),

    navbarPage('Game of thrones visulization',
               tabPanel("Got map",
                        h2("title to be added"),
                        plotOutput("displayMap", width = "100%")),
               
               tabPanel("Time series data",
                        h2("title to be added"),
                        plotOutput(outputId="g", width="100%")),
               
               tabPanel("Data", 
                        DT::dataTableOutput('rawtable')),
               
               tabPanel("About", includeHTML("www/a-propos.html"), br()),
               
               tabPanel("Developers", includeHTML("www/Developers.html"), br()),
    )
  )
)


server <- function(input, output){
  
  output$displayMap <- renderPlot({
    got_map()
  })

  output$g <- renderPlot({ get_time_spent_per_character(input$names) })
  
  output$rawtable <- DT::renderDataTable(read_csv(
    file.path('data',paste(input$df,'.csv', sep=''))))
  
}


shinyApp(ui = ui, server = server)
