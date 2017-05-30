library(plotly)
library(dplyr)
library('tidyr')

# read in dataset
collision <- read.csv('../data/SDOT_Collisions.csv', stringsAsFactors = FALSE)

# choose needed columns
df <- data.frame(collision$SEVERITYCODE, collision$SEVERITYDESC, collision$WEATHER, collision$ROADCOND, stringsAsFactors = FALSE)

# filter out rows with missing data
df <- df %>% filter(collision.WEATHER != "") %>% filter(collision.WEATHER != "Unknown") %>% 
  filter(collision.ROADCOND != "") %>% filter(collision.ROADCOND != "Unknown") %>% 
  filter(collision.SEVERITYCODE != "0")

# count collisions based on weather and road condition
avg <- df %>% group_by(collision.WEATHER, collision.SEVERITYDESC) %>% summarise(count = n())
df.wide <- spread(avg, collision.SEVERITYDESC, count) 
get.col.names <- make.names(colnames(counts), unique=TRUE)
colnames(df.wide) <- get.col.names

# display graph 
# insert bar graph by severity
p <- plot_ly(df.wide, x = ~collision.WEATHER, y = ~Fatality.Collision, type = "bar", marker = list(color = "Purple")) %>%
  add_trace(y = ~Injury.Collision, name = "Injury Collision", marker = list(color = "Blue")) %>% 
  add_trace(y = ~Property.Damage.Only.Collision, name = "Property Damage", marker = list(color = "Red")) %>% 
  add_trace(y = ~Serious.Injury.Collision, name = "Serious Injury Collision", marker = list(color = "Yellow")) %>% 
  layout(title = "Weather & Car Collision Severity", xaxis = list(title = "Weather"),
         yaxis = list(title = "Count"), barmode = "Stack")
p

#average severity of crashes in certain weathers

