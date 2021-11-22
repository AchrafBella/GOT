library(shiny)
library(readr)
library(dplyr)
library(sf)
library(ggplot2)

character_name_list = appearances %>% pull(name) %>% unique()

ui <- fluidPage(
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
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("saison", "Choose a season",
                            choices = c(1, 2, 3, 4, 5, 6, 7, 8),
                          ),
                          selectInput("episode", "Choose an Episode",
                            choices = c(1,2,3,4,5),
                          ),
                          radioButtons(
                            "ds",
                            "See the place of :",
                            choices = c("Scenes", "Death people")
                          ),
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          plotOutput("distPlot")
                        )
                      )
                      ),
             
             tabPanel("Time series data", sidebarPanel(
               selectInput("names", "Choose character name:",character_name_list)),
             mainPanel(
                 h2("Line graph of time spend per episode by a character",
                    style='background-color:coral;padding-left: 15px'),
                 plotOutput(outputId="g", width="300px",height="300px"),)),
             
             
             tabPanel("Data", fluidRow(
               column(2,
                      selectInput(inputId="df",label="Select datasets",
                      choices =  c('appearances', 'characters', 'episodes', 
                      'populations', 'scenes')),
               ),
               column(10,  DT::dataTableOutput('rawtable'))
             ) ),
             
             tabPanel("About", includeHTML("www/a-propos.html"),br()),
             tabPanel("Developers", includeHTML("www/Developers.html"),br()),
  )            
)

server <- function(input, output){
  
  output$rawtable <- DT::renderDataTable(read_csv(
    file.path('data',paste(input$df,'.csv', sep=''))))
  
  output$g <- renderPlot({
    
    character_duration= appearances %>% filter(name==input$names) %>% 
      left_join(scenes) %>%
      group_by(location) %>% 
      summarize(duration= sum(duration/60)) %>% 
      left_join(scenes_loc) %>% 
      st_as_sf()
    
    ggplot() + geom_sf(data=land,fill=colland,col=borderland,size=0.1)+
      geom_sf(data=islands,fill=colland,col="ivory3") +
      geom_sf(data=character_duration,aes(size=duration), color='red')+
      scale_size_area("Time on screen",breaks = c(0,30,60,120,240))+
      theme_minimal()+coord_sf(expand = 0,ndiscr = 0)+
      theme(panel.background = element_rect(fill = colriver,color=NA)) +
      labs(title = paste(input$names1,"time on screen per location"),x="",y="")
    
  })
  
}


shinyApp(ui = ui, server = server)
