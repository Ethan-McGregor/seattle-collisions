
#script gathers and cleans lat and long data
source('scripts/map.R')

# gets data
data <- getData()

#collisions <- read.csv('./data/SDOT_Collisions.csv', stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  # this will update heatmap with number of variables
  sliderValues <- reactive({
    sample <- getSample()
  
  }) 
  
  #retunrs dataFrame with new variables
  getSample <- function(){
    
    sample <- sample_n(data, input$integer * 100)
    
    return(sample)
  }
  
 
  
  # will render heatmap
  render <- function(){
    output$heat <- renderLeaflet({
      leaflet(data = sliderValues()) %>%
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
    #if (input$roadcond == "Wet") {
     # plot.data <- collisions %>% filter(ROADCOND == "Wet")
    #} else if (input$roadcond == "Dry") {
     # plot.data <- collisions %>% filter(ROADCOND == "Dry")
    #} else if (input$roadcond == "Snow/Slush") {
     # plot.data <- collisions %>% filter(ROADCOND == "Snow/Slush")
    #} else if (input$roadcond == "Sand/Mud/Dirt") {
     # plot.data <- collisions %>% filter(ROADCOND == "Sand/Mud/Dirt") 
    #} else if (input$roadcond == "Other") {
     # plot.data <- collisions %>% filter(ROADCOND == "Other")
    #} else {
    #  plot.data <- collisions
    #}
    #WeatherGraph(plot.data)
  })

  output$monthmap <- renderPlotly({
    source('scripts/monthmap.R')
    MonthGraph()
})})
