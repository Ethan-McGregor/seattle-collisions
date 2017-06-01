
#script gathers and cleans lat and long data
source('scripts/map.R')

# gets data
data <- getData()

collisions <- read.csv('./data/SDOT_Collisions.csv', stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  dataType  <- reactiveValues(data = data)
  
  observeEvent(input$integer, {
    dataType$data <-  sample_n(data, input$integer * 100) 
  })
  
  observeEvent(input$standard, {
    dataType$data <-  sample_n(data, input$integer * 100) 
  })  
  
  observeEvent(input$lt, {
    dataType$data <- filter(dataType$data, COLLISIONTYPE == "Left Turn")
  })  
  
  observeEvent(input$rt, {
    dataType$data <- filter(dataType$data, COLLISIONTYPE == "Right Turn")
  })
  
  observeEvent(input$sw, {
    dataType$data <- filter(dataType$data, COLLISIONTYPE == "Sideswipe")
  })
  
  observeEvent(input$an, {
    dataType$data <- filter(dataType$data, COLLISIONTYPE == "Angles")
  })
  
  observeEvent(input$cy, {
    dataType$data <- filter(dataType$data, COLLISIONTYPE == "Cycles")
  })
  
  observeEvent(input$ped, {
    dataType$data <- filter(dataType$data, COLLISIONTYPE == "Pedestrian")
  })
  
  observeEvent(input$re, {
    dataType$data <- filter(dataType$data, COLLISIONTYPE == "Rear Ended")
  })
  
  
  #By WEATHER
  observeEvent(input$rain, {
    dataType$data <- filter(dataType$data, WEATHER == "Raining")
  })
  
  observeEvent(input$over, {
    dataType$data <- filter(dataType$data, WEATHER == "Overcast")
  })
  
  observeEvent(input$clear, {
    dataType$data <- filter(dataType$data, WEATHER == "Clear or Partly Cloudy")
  })
  
  observeEvent(input$sand, {
    dataType$data <- filter(dataType$data, WEATHER == "Blowing Sand or Dirt or Snow")
  })
  
 
  
  #By Light Condition
  observeEvent(input$day, {
    dataType$data <- filter(dataType$data, LIGHTCOND == "Daylight")
  })
  
  observeEvent(input$dawn, {
    dataType$data <- filter(dataType$data, LIGHTCOND == "Dawn")
  })
  
  observeEvent(input$dusk, {
    dataType$data <- filter(dataType$data, LIGHTCOND == "Dusk")
  })
  
  observeEvent(input$dark, {
    dataType$data <- filter(dataType$data, LIGHTCOND == "Dark - Street Lights On")
  })
  
  
  # will render heatmap
  render <- function(){
    output$heat <- renderLeaflet({
      leaflet(data = dataType$data) %>%
        addTiles() %>% 
        addCircleMarkers(~lng, ~lat, color= "red",fillOpacity = .5,fill = FALSE,label = data$hover)   })
  }
  
  render()
  
  output$yearly <- renderPlotly({
    source('scripts/yearly.R')
    YearGraph()
  })
  
  output$weather <- renderPlotly({
    source('scripts/weather.R')
    if (input$roadcond == "Wet") {
     plot.data <- collisions %>% filter(ROADCOND == "Wet")
    } else if (input$roadcond == "Dry") {
      plot.data <- collisions %>% filter(ROADCOND == "Dry")
    } else if (input$roadcond == "Ice") {
      plot.data <- collisions %>% filter(ROADCOND == "Ice")
    } else {
      plot.data <- collisions
    }
    WeatherGraph(plot.data)
  })

  output$monthmap <- renderPlotly({
    source('scripts/monthmap.R')
    MonthGraph()
    MorningGraph()
    NightGraph()
})})
