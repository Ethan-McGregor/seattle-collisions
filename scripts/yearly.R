library('plotly')
library('stringr')
library('dplyr')
library('tidyr')

YearGraph <- function(){

  collisions <- read.csv('./data/SDOT_Collisions.csv', stringsAsFactors = F)
  
  #get year from datetime
  collisions <- mutate(collisions, year = substr(collisions$INCDATE, 7, 10)) 
  collisions <- group_by(collisions, year, SEVERITYDESC)
  count <- summarise(collisions, count = n())
  
  #get data for just 2004 - 2016
  count <- count[4:68,]
  
  #go wide for stacked bar chart 
  count.wide <- spread(count, SEVERITYDESC, count) 
  
  #format column names
  tidy.name.vector <- make.names(colnames(count.wide), unique=TRUE)
  colnames(count.wide) <- tidy.name.vector
  
  #stacked bar chart of year + severity 
  chart <- plot_ly (count.wide,
              x = ~year,
              y = ~Unknown,
              type = "bar",
              name = "Unknown",
              hoverinfo = "text",
              text = ~paste(Unknown, "Unknown"),
              marker = list(color = "#ffb2b2")) %>%  
    add_trace(y = ~Property.Damage.Only.Collision,
              name = "Property Damage Only Collisions", 
              hoverinfo = "text", 
              text = ~paste(Property.Damage.Only.Collision, "Property Damage Only Collisions"),
              marker = list(color = "#ff4c4c")) %>%  
    add_trace(y = ~Injury.Collision,
              name = "Injury Collisions", 
              hoverinfo = "text", 
              text = ~paste(Injury.Collision, "Injury Collisions"),
              marker = list(color = "#cc0000")) %>%  
    add_trace(y = ~Serious.Injury.Collision, 
              name = "Serious Injury Collisions", 
              hoverinfo = "text", 
              text = ~paste(Serious.Injury.Collision, "Serious Injury Collisions"),
              marker = list(color = "#7f0000")) %>%  
    add_trace(y = ~Fatality.Collision,
              name = "Fatality Collisions", 
              hoverinfo = "text", 
              text = ~paste(Fatality.Collision, "Fatality Collisions"),
              marker = list(color = "#000000")) %>%  
    layout(title = "Seattle Collisions 2004 - 2016", 
           xaxis = list(title = "Year"),
           yaxis = list(title = "# of Collisions"), 
           barmode = "stack")
  
  return(chart)
}







