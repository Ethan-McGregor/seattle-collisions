library(plotly)
library(dplyr)

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


