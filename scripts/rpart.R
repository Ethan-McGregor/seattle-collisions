library("rpart")
library('plotly')
library('shiny')
library('leaflet')
library('stringr')
library('dplyr')

col <- read.csv('../data/SDOT_Collisions.csv')


data = data.frame(col$INJURIES,col$DISTANCE,col$VEHCOUNT)

#sample <- sample_n(data, 500)


dt = sort(sample(nrow(data), nrow(data)*.7))
trainindex <- sample(data, trunc(length(data)/2))
train<-data[dt,]
test<-data[-dt,]

class = rpart(col.INJURIES ~ col.DISTANCE + col.VEHCOUNT , 
                     data = train)



pre <- predict(class,test) 

actual <- test$col.INJURIES

rsq <- 1-sum((actual-pre)^2)/sum((actual-mean(actual))^2)

rmse <- rsq <- sqrt( mean( (actual-pre)^2 , na.rm = TRUE ) )

print(rsq)
print(rmse)