library(plotly)
library(dplyr)
library('tidyr')

WeatherGraph <- function(data) {

  # choose needed columns
  df <- data %>% select(SEVERITYCODE, SEVERITYDESC, WEATHER, ROADCOND)
  
  # filter out rows with missing data
  df <- df %>% filter(WEATHER != "") %>% filter(WEATHER != "Unknown") %>% 
    filter(ROADCOND != "") %>% filter(ROADCOND != "Unknown") %>% 
    filter(SEVERITYCODE != "0")
  
  # count collisions based on weather and road condition
  counts <- df %>% group_by(WEATHER, SEVERITYDESC) %>% summarise(count = n())
  df.wide <- spread(counts, SEVERITYDESC, count)
  
  # get column names and fixes them
  get.col.names <- make.names(colnames(df.wide), unique=TRUE)
  colnames(df.wide) <- get.col.names
  
  # display graph 
  bar.graph <- plot_ly(df.wide, x = ~WEATHER, y = ~Fatality.Collision, type = "bar", marker = list(color = ~"cyan"), 
                       name = "Fatality Collision", hoverinfo = "text", text = ~paste(WEATHER, "<br>", Fatality.Collision, "Fatality Collisions")) %>%
    add_trace(y = ~Injury.Collision, name = "Injury Collision", marker = list(color = "slateblue"),
              hoverinfo = "text", text = ~paste(WEATHER, "<br>", Injury.Collision, "Injury Collisions")) %>% 
    add_trace(y = ~Property.Damage.Only.Collision, name = "Property Damage Collision", marker = list(color = "navy"),
              hoverinfo = "text", text = ~paste(WEATHER, "<br>", Property.Damage.Only.Collision, "Property Damage Only Collisions")) %>% 
    add_trace(y = ~Serious.Injury.Collision, name = "Serious Injury Collision", marker = list(color = "blue"),
              hoverinfo = "text", text = ~paste(WEATHER, "<br>", Serious.Injury.Collision, "Serious Injury Collisions")) %>% 
    layout(title = "Weather & Car Collision Severity", xaxis = list(title = "Weather"),
           yaxis = list(title = "# of Collisions"), barmode = "Group")
    
  return(bar.graph)

}

plot.data <- collisions %>% filter(ROADCOND == "Wet")
WeatherGraph(plot.data)
