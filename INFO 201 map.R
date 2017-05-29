library(shiny)
library(leaflet)
library(plotly)
library(dplyr)

data <- read.csv('data/SDOT_Collisions.csv')

# remove missing data
acc.data <- na.omit(data)

# find most popular month
freq <- as.data.frame(table(acc.data$INCDTTM))
january <- substr(freq, 1, 2)
substring(freq$Var1, "1", "/")
