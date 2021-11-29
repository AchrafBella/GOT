main_char= c("Jon Snow", "Tyrion Lannister","Daenerys Targaryen",
             "Sansa Stark","Cersei Lannister","Arya Stark")


function1 <- function(season){
  
  screenTimePerSeasons = appearances %>% left_join(scenes) %>% 
    left_join(episodes) %>% 
    group_by(name,seasonNum) %>%  filter(name %in% main_char)%>%  
    filter(seasonNum %in% season)%>% 
    summarise(screenTime=sum(duration)) %>% 
    arrange(desc(screenTime)) 
  screenTimeTotal = screenTimePerSeasons %>% 
    group_by(name) %>% 
    summarise(screenTimeTotal=sum(screenTime))
  
  mainCharacters = screenTimeTotal %>% 
    filter(screenTimeTotal>60*60) %>% 
    arrange(screenTimeTotal) %>% 
    mutate(nameF=factor(name,levels = name))
  data = screenTimePerSeasons %>% left_join(mainCharacters) %>% 
    filter(!is.na(nameF))
  ggplot(data)+
    geom_bar(aes(y=nameF,x=screenTime/60,fill=factor(seasonNum,level=8:1)),
             stat="identity")+
    scale_fill_brewer("Saison",palette = "Spectral")+theme_bw()+
    geom_text(data=mainCharacters,aes(y=nameF,x=screenTimeTotal/60+5,
                label=paste(round(screenTimeTotal/60),'min')),hjust = "left")+
    scale_x_continuous("Appearance time (min)",
                       breaks = seq(0,750,by=120),limits = c(0,780),expand = 
                         c(0,1))+
    ylab("")+ggtitle("The time of appearance for the main characters per season")
}



function2 <- function(season){
  
  labels = scenes %>% filter(duration>400)
  ggplot(scenes %>% left_join(episodes)%>% filter(seasonNum %in% season))+
    geom_boxplot(aes(x=factor(episodeId),y=duration,fill=factor(seasonNum)))+
    geom_text(data=labels ,aes(x=factor(episodeId),y=duration,
                               label=subLocation),hjust = "right",vjust="top")+
    scale_x_discrete("N° épisode",as.character(seq(1,73, by=5)))+
    scale_fill_brewer(palette="Spectral",guide="none")+
    ylab("Scenes duration (min)")+
    ggtitle("Dispatching of duration pear season and episode ")+
    theme_bw()
  
}

function3 <- function(season){
  
  scenes_stats=scenes %>% left_join(episodes) %>% 
    group_by(episodeTitle,seasonNum) %>% filter(seasonNum %in% season) %>% 
    summarize(nb_scenes=n(),duration_max=max(duration),nbdeath=sum(nbdeath))
  
  labels = scenes_stats %>% filter(duration_max>400|nb_scenes>200|seasonNum==1)
  ggplot(scenes_stats,aes(x=nb_scenes,y=duration_max,col=factor(seasonNum)))+
    geom_point(aes(size=nbdeath))+
    geom_text(data=labels,aes(label=episodeTitle),vjust=-0.6)+
    scale_x_continuous("Nombre of scene",limits = c(0,280))+
    scale_y_continuous("Time of the longest scences",limits = c(100,300))+
    scale_color_brewer("Saison",palette ="Spectral")+
    guides(colour = "legend", size = "legend")+
    ggtitle("Information about the season and the number of deaths")+
    theme_bw()
}


function4 <- function(char_name){
  
  jstime = appearances %>% filter(name==char_name) %>% 
    left_join(scenes) %>% 
    group_by(episodeId) %>% 
    summarise(time=sum(duration))
  
  ggplot(jstime) + 
    geom_line(aes(x=episodeId,y=time), color = "blue", size = 1)+
    theme_bw()
}