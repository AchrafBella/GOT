library(shiny)
library(shinyWidgets)
library(dplyr)
library(sf)
library(ggplot2)
library(DT)
library(ggcorrplot)

source("data_acquisition.R")


colforest="#c0d7c2"
colriver="#7ec9dc"
colland="ivory"
borderland = "ivory3"

datasets = c('appearances', 'characters', 'episodes', 'populations', 'scenes')
character_name_list = appearances %>% pull(name) %>% unique()
colors =  c('red', 'blue', 'green')


# The application

ui <- fluidPage(
  setBackgroundImage("background.jpg"),
  useShinyalert(),
  tags$audio(src = "got_opning.mp3", type = "audio/mp3", autoplay = T, controls = F),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css") 
  ),
  
  tags$header(
    tags$img(
      src = "ecc.png",
      title = "Ecole Centrale Casablanca",
      width = "70",
      height = "55",
      class = "logo"
    ),
    tags$b("GoT Data Visualisation Application", class = "titre")
  ),

  navbarPage('GOT visulization',
             
             tabPanel('GOT map', sidebarPanel(
               selectInput("names", "Character name:",character_name_list),
               selectInput("color", "Choose Color", colors,),
             ), 
             mainPanel(
               h2("Spatial distribution of the selected person's scenes",
               style='background-color:coral;padding-left: 15px'),
               plotOutput(outputId = "map1", width = "100%"),
             ) ),
             
             tabPanel("Data Visualization", sidebarPanel(
               selectInput("names1", "Character name:",character_name_list),
               selectInput("color1", "Choose Color", colors,),
               sliderInput("ep", "Episode number :",
                           min = 2,
                           max = 500,
                           value = 5),
             ), 
             mainPanel(
               basicPage(
                 h2("Time spend per episode by a character",
                                  style='background-color:coral;padding-left: 15px'),
                        plotOutput(outputId="map2", width="300px",height="300px"),
                 
                 h2("Time spend per episode by a character",
                              style='background-color:coral;padding-left: 15px'),
                 plotOutput(outputId="map3", width="300px",height="300px")),
               ),
               

             ),
             
             tabPanel("Descriptive statistics",),
             tabPanel("Correlation",),
             
             tabPanel("Data",  fluidRow(
               column(2,
                      selectInput(inputId="df",label="Select datasets",
                                  choices = datasets),
               ),
               column(10,  DT::dataTableOutput('rawtable'))
             ) ),
  )
)


server <- function(input, output){
  
  output$rawtable <- DT::renderDataTable(read_csv(
    file.path('data',paste(input$df,'.csv', sep=''))))
  
  output$map1 <- renderPlot({
    
    character_duration= appearances %>% filter(name==input$names) %>% 
      left_join(scenes) %>%
      group_by(location) %>% 
      summarize(duration= sum(duration/60)) %>% 
      left_join(scenes_loc) %>% 
      st_as_sf()
    
    ggplot() + geom_sf(data=land,fill=colland,col=borderland,size=0.1)+
      geom_sf(data=islands,fill=colland,col="ivory3") +
      geom_sf(data=character_duration,aes(size=duration), color=input$color)+
      scale_size_area("Time on screen",breaks = c(0,30,60,120,240))+
      theme_minimal()+coord_sf(expand = 0,ndiscr = 0)+
      theme(panel.background = element_rect(fill = colriver,color=NA)) +
      labs(title = paste(input$names1,"time on screen per location"),x="",y="")
    
  })
  
  output$map2 <- renderPlot({
    
    jstime = appearances %>% filter(name==input$names1) %>% 
      left_join(scenes) %>% 
      group_by(episodeId) %>% 
      summarise(time=sum(duration))
    
    ggplot(jstime) + 
      geom_line(aes(x=episodeId,y=time), color = input$color1, size = 1)+
      theme_bw()
  
  })
  
  
  output$map3 <- renderPlot({
    
    scenes_stats=scenes %>% left_join(episodes) %>% 
      group_by(episodeTitle,seasonNum) %>% 
      summarize(nb_scenes=n(),duration_max=max(duration),nbdeath=sum(nbdeath))
    
    labels = scenes_stats %>% filter(duration_max>400|nb_scenes>200)
    
    ggplot(scenes_stats,aes(x=nb_scenes,y=duration_max,col=factor(seasonNum)))+
      geom_point(aes(size=nbdeath))+
      geom_text(data=labels,aes(label=episodeTitle),vjust=-0.6)+
      scale_x_continuous("Number of scene",limits = c(0,280))+
      scale_y_continuous("The duration of the longest scene",limits = c(100,800))+
      scale_color_brewer("season",palette ="Spectral")+
      guides(colour = "legend", size = "legend")+
      theme_bw()    
    
  })
  
}

shinyApp(ui = ui, server = server)
