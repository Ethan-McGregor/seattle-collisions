library('plotly')
library('shiny')
library('leaflet')
library('stringr')
library('dplyr')

collison <- read.csv('./data/SDOT_Collisions.csv')

## Exploring Seattle's Car Collisions

# remove rows with missing data 
noNa = collison[complete.cases(collison),]

d = data.frame(str_split(as.character(noNa$Shape), " ") )

# Unfactor lat and long
long = data.frame(unlist(d[2,]))
lat = data.frame(unlist(d[1,]))
names(lat) = "lat"
names(long) = "long"
lat = as.vector(lat$lat)
long = as.vector(long$long)

# Replace random char with nothing
lat = str_replace(lat, "\\(",  "")
lat = str_replace(lat, "\\)",  "")
lat = str_replace(lat, "\\,",  "")

#repeat for long
long = str_replace(long, "\\,",  "")
long = str_replace(long, "\\(",  "")
long = str_replace(long, "\\)",  "")

#turned lat and lng into own dataframe
ma = data.frame(lat,long)

#turns into double from string
noNa$lat = as.numeric(paste(ma$lat))
noNa$lng = as.numeric(paste(ma$long))

# function used by server to get data
getData <- function(){
  return(noNa)
}
