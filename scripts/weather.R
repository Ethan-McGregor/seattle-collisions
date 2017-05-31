library(plotly)
library(dplyr)
library('tidyr')

WeatherGraph <- function() {
  
  # read in dataset
  collisions <- read.csv('../data/SDOT_Collisions.csv', stringsAsFactors = FALSE)
  
  # choose needed columns
  df <- data.frame(collision$SEVERITYCODE, collision$SEVERITYDESC, collision$WEATHER, collision$ROADCOND, stringsAsFactors = FALSE)
  
  # filter out rows with missing data
  df <- df %>% filter(collision.WEATHER != "") %>% filter(collision.WEATHER != "Unknown") %>% 
    filter(collision.ROADCOND != "") %>% filter(collision.ROADCOND != "Unknown") %>% 
    filter(collision.SEVERITYCODE != "0")
  
  # count collisions based on weather and road condition
  counts <- df %>% group_by(collision.WEATHER, collision.SEVERITYDESC) %>% summarise(count = n())
  df.wide <- spread(counts, collision.SEVERITYDESC, count)
  
  # get column names and fixes them
  get.col.names <- make.names(colnames(df.wide), unique=TRUE)
  colnames(df.wide) <- get.col.names
  
  # display graph 
  bar.graph <- plot_ly(df.wide, x = ~collision.WEATHER, y = ~Fatality.Collision, type = "bar", marker = list(color = ~"cyan"), 
                       name = "Fatality Collision", hoverinfo = "text", text = ~paste(collision.WEATHER, "<br>", Fatality.Collision, "Fatality Collisions")) %>%
    add_trace(y = ~Injury.Collision, name = "Injury Collision", marker = list(color = "slateblue"),
              hoverinfo = "text", text = ~paste(collision.WEATHER, "<br>", Injury.Collision, "Injury Collisions")) %>% 
    add_trace(y = ~Property.Damage.Only.Collision, name = "Property Damage Collision", marker = list(color = "navy"),
              hoverinfo = "text", text = ~paste(collision.WEATHER, "<br>", Property.Damage.Only.Collision, "Property Damage Only Collisions")) %>% 
    add_trace(y = ~Serious.Injury.Collision, name = "Serious Injury Collision", marker = list(color = "blue"),
              hoverinfo = "text", text = ~paste(collision.WEATHER, "<br>", Serious.Injury.Collision, "Serious Injury Collisions")) %>% 
    layout(title = "Weather & Car Collision Severity", xaxis = list(title = "Weather"),
           yaxis = list(title = "# of Collisions"), barmode = "Group")
    
  return(bar.graph)

} 

