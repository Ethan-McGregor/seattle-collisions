
#Require shiny
library(shiny)
library(plotly)
library('leaflet')

shinyUI(navbarPage("Exploring Collisions in Seattle",
  
  tabPanel("Map", 
 
    sidebarLayout(position = "right",
                 
      sidebarPanel(
        #slider to change number of variables
        sliderInput("integer", "Number of collsions shown (In hundreds)", min=2, max=10, value=2)),
      
      mainPanel(
        #window for map view
        leafletOutput("heat",width="90%",height="700px"))
    )
  ),
  
  tabPanel("By Year", fluid = TRUE,  

        mainPanel(fluid = TRUE,
            plotlyOutput('yearly')
        )
    
  ),
  
  tabPanel("Weather",
           
           mainPanel(
            plotlyOutput('weather')
           )
  )
))
