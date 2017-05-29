library(shiny)
library(leaflet)
library(plotly)
library(dplyr)

data <- read.csv('data/SDOT_Collisions.csv')

# remove missing data
acc.data <- na.omit(data)

# find most popular month
freq <- as.data.frame(table(acc.data$INCDTTM))
##january <- substr(freq, 1, 2)
##substring(freq$Var1, "1", "/")
#month = substring(freq[,1], 1, 3) 
month.day = sub('/([^/]*)$', '', freq[,1])
month.day <- as.data.frame(table(month.day))
month.data <-  gsub( "/.*$", "", freq[,1] )
month <- as.data.frame(table(month.data))



p <- plot_ly(
  x =month$month,
  y =  month$Freq,
  name = "SF Zoo",
  type = "bar"
)

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
p
