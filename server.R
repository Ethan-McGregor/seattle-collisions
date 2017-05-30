
#script gathers and cleens lat and long data
source('scripts/map.R')

# gets data
data <- getData()

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
  
  
})
