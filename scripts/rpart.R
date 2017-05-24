library("rpart")
library('plotly')
library('shiny')
library('leaflet')
library('stringr')
library('dplyr')
library('randomForest')
col <- read.csv('../data/SDOT_Collisions.csv')


data = data.frame(col$INJURIES,col$DISTANCE,col$VEHCOUNT,col$PERSONCOUNT, col$ST_COLCODE)

#sample <- sample_n(data, 500)

data = na.roughfix(data)
dt = sort(sample(nrow(data), nrow(data)*.7))
trainindex <- sample(data, trunc(length(data)/2))
train<-data[dt,]
test<-data[-dt,]


class <- randomForest(col.INJURIES ~ col.DISTANCE + col.VEHCOUNT + col.PERSONCOUNT + col.ST_COLCODE, 
                     data = train, importance = TRUE,  ntree = 100)


pre <- predict(class,test) 

actual <- test$col.INJURIES

rsq <- 1-sum((actual-pre)^2)/sum((actual-mean(actual))^2)

rmse <- rsq <- sqrt( mean( (actual-pre)^2 , na.rm = TRUE ) )

print(rsq)
print(rmse)
