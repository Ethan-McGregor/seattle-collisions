
#Require shiny
library(shiny)
library(plotly)
library('leaflet')

shinyUI(fluidPage(
  
  titlePanel("Exploring Collisions in Seattle"),
 
  sidebarLayout( position = "right",
                 
    sidebarPanel(
      
      #slider to change number of variables
      sliderInput("integer", "Number of Variables", min=2, max=10, value=2)

    ),
    
    mainPanel(
      
      #window for map view
      tabsetPanel(
        tabPanel("Collisons in Seattle", leafletOutput("heat",width="90%",height="700px"))
        
      )
    )
  )
))
