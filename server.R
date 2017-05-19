library(plotly)
library(shiny)
library(dplyr)
library(RColorBrewer)


collison <- read.csv('data/SDOT_Collisions.csv')


library('leaflet')
library('stringr')
library('dplyr')
## creates interactive map
pal <- colorFactor(c("navy", "red","blue","green","yellow"), domain = c("ship", "pirate"))
#qpal <- colorQuantile("RdYlBu", shooting.data$killed, n = 3)

# remove rows with missing data 
noNa = collison[complete.cases(collison),]

d = data.frame(str_split(as.character(noNa$Shape), " ") )



long = data.frame(unlist(d[2,]))
lat = data.frame(unlist(d[1,]))
names(lat) = "lat"
names(long) = "long"

lat = as.vector(lat$lat)
long = as.vector(long$long)


lat = str_replace(lat, "\\(",  "")
lat = str_replace(lat, "\\)",  "")
lat = str_replace(lat, "\\,",  "")

long = str_replace(long, "\\,",  "")
long = str_replace(long, "\\(",  "")
long = str_replace(long, "\\)",  "")

ma = data.frame(lat,long)

noNa$lat = as.numeric(paste(ma$lat))
noNa$lng = as.numeric(paste(ma$long))


sample =  sample_n(noNa, 500)






shinyServer(function(input, output) {
  
  
  
  
  
  # this will update heatmap with number of variables
  sliderValues <- reactive({
    
    
  }) 
  
  
  
  
  # changes values in heatmap for number of varaibles
  output$values <- renderTable({
    
  })
  
  # dedects if standard button is pushed
  observeEvent(input$standard, {
    
  })
  
  # dedects if new button is pushed
  observeEvent(input$changed, {
    
    
  })  
  
  # will render heatmap
  render <- function(){
    output$heat <- renderLeaflet({
    })
  }
  
  render()
})
