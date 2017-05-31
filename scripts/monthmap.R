library(shiny)
library(leaflet)
library(plotly)
library(dplyr)
library(knitr)

MonthGraph <- function(){
# read in dataset
data <- read.csv('data/SDOT_Collisions.csv')

# remove missing data
acc.data <- na.omit(data)

# find most popular month
freq <- as.data.frame(table(acc.data$INCDTTM))

month.day = sub('/([^/]*)$', '', freq[,1])
month.day <- as.data.frame(table(month.day))
month.data <-  gsub( "/.*$", "", freq[,1] )
month <- as.data.frame(table(month.data))

# graph and components
bar_graph <- plot_ly(month, x = month$month.data, y = month$Freq, type = 'bar',
                   marker = list(color = c('black', 'rgb(158,202,225)', 'black', 'black', 'black',
'black', 'black', 'black', 'black', 'black', 'black', 'black'))) %>%
  layout(title = "Collisions by month",
         xaxis = list(title = "Month number"),
         yaxis = list(title = "Total collisions occured"))

# display graph
return(bar_graph)
}