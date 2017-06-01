library(plotly)
library(dplyr)
library('tidyr')

WeatherGraph <- function(data) {

  # choose needed columns
  df <- data %>% select(SEVERITYCODE, SEVERITYDESC, WEATHER, ROADCOND)
  
  # filter out rows with missing data or not related
  df <- df %>% filter(WEATHER != "") %>% filter(WEATHER != "Blowing Sand or Dirt or Snow") %>% 
    filter(SEVERITYCODE != "0") %>% filter(WEATHER != "Severe Crosswind")
  
  # count collisions based on weather and road condition
  counts <- df %>% group_by(WEATHER, SEVERITYDESC) %>% summarise(count = n())
  
  # change dataframe from long to wide
  df.wide <- spread(counts, SEVERITYDESC, count)
  
  # get column names and fixes them
  get.col.names <- make.names(colnames(df.wide), unique=TRUE)
  colnames(df.wide) <- get.col.names
  

  # display graph using plotly
  bar.graph <- plot_ly(df.wide, x = ~WEATHER, y = ~Property.Damage.Only.Collision, name = "Property Damage Collision", marker = list(color = "navy"), type = "bar", 
                       name = "Property Damage Only Collision", hoverinfo = "text", text = ~paste(WEATHER, "<br>", Property.Damage.Only.Collision, "Property Damage Only Collisions")) %>%
    add_trace(y = ~Injury.Collision, name = "Injury Collision", marker = list(color = "slateblue"),
              hoverinfo = "text", text = ~paste(WEATHER, "<br>", Injury.Collision, "Injury Collisions")) %>% 
    add_trace(y = ~Fatality.Collision, name = "Fatality Collision", marker = list(color = ~"cyan"),
              hoverinfo = "text", text = ~paste(WEATHER, "<br>", Fatality.Collision, "Fatality Collisions")) %>% 
    add_trace(y = ~Serious.Injury.Collision, name = "Serious Injury Collision", marker = list(color = "blue"),
              hoverinfo = "text", text = ~paste(WEATHER, "<br>", Serious.Injury.Collision, "Serious Injury Collisions")) %>% 
    layout(title = "Weather & Car Collision Severity", xaxis = list(title = "Weather"),
           yaxis = list(title = "# of Collisions"), barmode = "Group", margin = list(b = 250, t = 50), height = 700)
    
  return(bar.graph)

}