
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
  
  tabPanel("By Year",  
           
      sidebarLayout(
                         
          sidebarPanel(
            
            h3("Collisions by Year"),
            p("This graph shows all collisions in Seattle between 2004 and 2016."),
            p("Click on the legend to filter by collision severity. Hover over each column to view the exact number of collisions.")
            
          ),

          mainPanel(
            plotlyOutput('yearly')
          )
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
                h3("Collision Road Conditions and Weather"),
                p("This graph shows the road conditions and weather for collisions in Seattle."),
                p("Click on the legend to filter by collision severity. Hover over each column to view the exact number of collisions."),
                selectInput(inputId = "roadcond",
                           label = "Road Condition",
                           choices = c("Wet", "Dry", "Ice", "All"),
                           selected = "All")
          ),
             
          mainPanel(
              plotlyOutput('weather')
          )
      )
  ),

  
  tabPanel("Random Forest",
           
           mainPanel(
             includeMarkdown('scripts/mlmarkdown.rmd')
           )),
  
  tabPanel("About",
           
           mainPanel(
             includeMarkdown('README.md')
           ))
))
