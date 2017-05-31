
#Require shiny
library(shiny)
library(plotly)
library('leaflet')

shinyUI(navbarPage("Exploring Collisions in Seattle",
  
  tabPanel("Map", 
 
    sidebarLayout(position = "right",
                 
      sidebarPanel(
        #slider to change number of variables
        sliderInput("integer", "Number of collsions shown (In hundreds)", min=2, max=10, value=2),
        
        h3("Filter by type of crash"),
        
        actionButton("standard", "All Crashes"),
        actionButton("lt", "Left Turns") ,
        actionButton("rt", "Right Turn"),
        actionButton("sw", "Sideswipe"),
        actionButton("cy", "Cycles"),
        actionButton("ped", "Pedestrain"),
        actionButton("an", "Angles"),
        actionButton("re", "Rear Ended"),
        
        h3("Filter by Weather"),
        
        
        actionButton("rain", "Raining") ,
        actionButton("over", "Overcast"),
        actionButton("clear", "Clear or Partly Cloudy"),
        actionButton("sand", "Blowing Sand, Dirt or Snow"),
        
        h3("Filter by light condition"),
        
        actionButton("day", "Daylight") ,
        actionButton("dawn", "Dawn"),
        actionButton("dusk", "Dusk"),
        actionButton("dark", "Dark")
        ),
      
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
  
  tabPanel("Monthly",
           
           mainPanel(
             plotlyOutput('monthmap')
           )
  ),
  
  tabPanel("Weather",
      sidebarLayout(
          sidebarPanel(
                selectInput(inputId = "roadcond",
                           label = "Road Condition",
                           choices = c("Wet", "Dry", "All"),
                           selected = "All")
          ),
             
          mainPanel(
              plotlyOutput('weather')
          )
      )
  ),

  
  tabPanel("About",
           
           mainPanel(
             includeMarkdown('README.md')
           ))
))
