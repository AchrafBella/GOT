
get_time_spent_per_character <- function(char_name){
  
  jstime = appearances %>% filter(name==char_name) %>% 
    left_join(scenes) %>% 
    group_by(episodeId) %>% 
    summarise(time=sum(duration))
  
  ggplot(jstime) + 
    geom_line(aes(x=episodeId,y=time), color = "blue", size = 1)+
    theme_bw()
  
}

character_name_list <- appearances %>% pull(name) %>% unique()


got_map <- function(){
  borderland = "ivory3"  
  ggplot(allDatas)+
    + geom_sf(aes(fill = type), size = 0.1) +
    geom_sf(data = locations,fill = "black",color = "black") +
    scale_fill_manual("Lands category", values = cols) +
    theme_minimal()+coord_sf(expand = 0,ndiscr = 0)+
    theme(panel.background = element_rect(fill = colriver,color=NA)) +
    labs(title = "GoT",caption = "Etiennne Côme, 2020",x="",y="")
}


continents$type="continent"
islands$type="island"
lakes$type="lake"
rivers$type="river"
roads$type="road"
wall$type="wall"

allDatas = bind_rows( continents,islands, landscape, rivers,lakes,roads,wall)

spaces = c(
  "continent",
  "forest",
  "mountain",
  "stepp",
  "swamp",
  "lake",
  "river",
  "road",
  "island",
  "location",
  "wall",
  "political",
  "desert",
  "land",
  "shore",
  "water"
)

cols = c(
  "ivory",
  "green",
  "gray88",
  "#669933",
  "cyan4",
  "blue",
  "cyan3",
  "darkgray",
  "gold",
  "black",
  "gold4",
  "orangered3",
  "darkgoldenrod1",
  "gray",
  "yellow",
  "#33CCFF"
)


names(cols) = spaces
levels(allDatas$type) = spaces