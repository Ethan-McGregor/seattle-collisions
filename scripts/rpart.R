library("rpart")
library('plotly')
library('shiny')
library('leaflet')
library('stringr')
library('dplyr')
library('randomForest')

col <- read.csv('../data/SDOT_Collisions.csv',stringsAsFactors=FALSE )



data = data.frame(col$INJURIES,col$DISTANCE,col$VEHCOUNT,col$PERSONCOUNT, col$ST_COLCODE, col$WEATHER,stringsAsFactors=FALSE )



data$col.INJURIES <- replace(data$col.INJURIES , data$col.INJURIES != "0", 1)
data$col.INJURIES <- replace(data$col.INJURIES , data$col.INJURIES != "1", 0)

data$col.WEATHER <- replace(data$col.WEATHER ,data$col.WEATHER == "Raining", 0)
data$col.WEATHER <- replace(data$col.WEATHER ,data$col.WEATHER == "Overcast", 1)
data$col.WEATHER <- replace(data$col.WEATHER ,data$col.WEATHER == "Clear or Partly Cloudy", 2)
data$col.WEATHER <- replace(data$col.WEATHER ,data$col.WEATHER == "Unknown", 3)
data$col.WEATHER <- replace(data$col.WEATHER ,data$col.WEATHER == "Other", 4)
data$col.WEATHER <- replace(data$col.WEATHER ,data$col.WEATHER == "Snowing", 5)
data$col.WEATHER <- replace(data$col.WEATHER ,data$col.WEATHER == "Fog/Smog/Smoke", 6)
data$col.WEATHER <- replace(data$col.WEATHER ,data$col.WEATHER == "Sleet/Hail/Freezing Rain", 7)
data$col.WEATHER <- replace(data$col.WEATHER ,data$col.WEATHER == "Severe Crosswind", 8)
data$col.WEATHER <- replace(data$col.WEATHER ,data$col.WEATHER == "Blowing Sand or Dirt or Snow", 9)
data$col.WEATHER <- replace(data$col.WEATHER ,data$col.WEATHER == "", 3)


data$col.WEATHER <- replace(data$col.WEATHER , is.na(data$col.WEATHER) , 0)
data$col.INJURIES <- replace(data$col.INJURIES ,is.na(data$col.INJURIES), 0)
data$col.DISTANCE <- replace(data$col.DISTANCE ,is.na(data$col.DISTANCE), 0)
data$col.VEHCOUNT <- replace(data$col.VEHCOUNT , is.na(data$col.VEHCOUNT), 0)
data$col.PERSONCOUNT <- replace(data$col.PERSONCOUNT , is.na(data$col.PERSONCOUNT) , 0)
data$col.ST_COLCODE <- replace(data$col.ST_COLCODE ,is.na(data$col.ST_COLCODE ), 0)


data$col.WEATHER <- factor(data$col.WEATHER)
data$col.INJURIES <- factor(data$col.INJURIES)
data$col.DISTANCE <- factor(data$col.DISTANCE)
data$col.VEHCOUNT <- factor(data$col.VEHCOUNT)
data$col.PERSONCOUNT <- factor(data$col.PERSONCOUNT)
data$col.ST_COLCODE <- factor(data$col.ST_COLCODE)


data = na.roughfix(data)
#sample <- sample_n(data, 500)

data$col.WEATHER <- as.numeric(data$col.WEATHER)
data$col.INJURIES <- as.numeric(data$col.INJURIES)
data$col.DISTANCE <- as.numeric(data$col.DISTANCE)
data$col.VEHCOUNT <- as.numeric(data$col.VEHCOUNT)
data$col.PERSONCOUNT <- as.numeric(data$col.PERSONCOUNT)
data$col.ST_COLCODE <- as.numeric(data$col.ST_COLCODE)

dt = sort(sample(nrow(data), nrow(data)*.7))
trainindex <- sample(data, trunc(length(data)/2))
train<-data[dt,]
test<-data[-dt,]




class <- randomForest(col.INJURIES ~ col.DISTANCE + col.VEHCOUNT + col.PERSONCOUNT + col.ST_COLCODE + col.WEATHER,
                     data = train, importance = TRUE,  ntree = 100)


pre <- predict(class,test) 


actual <- test$col.INJURIES

preAct <- data.frame(pre,actual)
rsq <- 1-sum((actual-pre)^2)/sum((actual-mean(actual))^2)

rmse <- rsq <- sqrt( mean( (actual-pre)^2 , na.rm = TRUE ) )

print(rsq)
print(rmse)
