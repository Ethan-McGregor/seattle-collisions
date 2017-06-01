library(shiny)
library(leaflet)
library(plotly)
library(dplyr)
library(knitr)
library(xts)

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

# morning graph function
MorningGraph <- function(){
  dates <- data.frame(POSIXtime = seq(as.POSIXct('2004/1/1'),
                                      as.POSIXct('2016/9/9 9:13:00 PM'), len = 183521))
  morning_collisions <- subset(dates, format(POSIXtime, '%H') %in% c('01', '02', '03', '04'))
  morning.data <- substr(morning_collisions$POSIXtime, 11, 13)
  morning.data <- as.data.frame(table(morning.data))

  morning_graph <- plot_ly(morning.data, x = morning.data$morning.data, y = morning.data$Freq, type = 'bar',
                           marker = list(color = c('rgb(158,202,225)', 'black', 'black', 'black'))) %>%
    layout(title = "Collisions from 1 AM to 4 AM",
           xaxis = list(title = "Hour number"),
           yaxis = list(title = "Total collisions occured"))
  
# return graph
return(morning_graph)
}

# night graph function
NightGraph <- function(){
  dates <- data.frame(POSIXtime = seq(as.POSIXct('2004/1/1'),
                                      as.POSIXct('2016/9/9 9:13:00 PM'), len = 183521))
  night_collisions <- subset(dates, format(POSIXtime, '%H') %in% c('20', '21', '22', '23'))
  night.data <- substr(night_collisions$POSIXtime, 11, 13)
  night.data <- as.data.frame(table(night.data))
  
  night_graph <- plot_ly(night.data, x = night.data$night.data, y = night.data$Freq, type = 'bar',
                         marker = list(color = c('black', 'black', 'black', 'rgb(158,202,225)'))) %>%
    layout(title = "Collisions from 8 PM to 11 PM",
           xaxis = list(title = "Hour number"),
           yaxis = list(title = "Total collisions occured"))
  
# return graph
  return(night_graph)
}