---
title: "Bike Shares Daily"
output: 
  flexdashboard::flex_dashboard:
    orientation: columns
    vertical_layout: fill
    storyboard: true
---

```{r setup, include=FALSE}
library(flexdashboard)
library(readr)
library(leaflet)
library(DT)
library(tidyverse)
library(lubridate)
library(plotly)

trips_df <- read_csv('https://assets.datacamp.com/production/repositories/1448/datasets/1f12031000b09ad096880bceb61f6ca2fd95e2eb/sanfran_bikeshare_joined_oneday.csv')
```

### Most bikes are used only a few times, but a few are used a lot

```{r}

trips_per_bike_df <- trips_df %>%
  group_by(bike_number) %>%
  summarize(n_trips = n()) %>%
  arrange(desc(n_trips)) 

bike_plot <- trips_per_bike_df %>%
  ggplot(aes(x = n_trips)) +
  geom_histogram(binwidth = 1) +
  ylab('') +
  xlab('Trips per bike') 

ggplotly(bike_plot)

```

### Where did the most used bike go?

```{r}

trips_df %>%
  filter(bike_number == trips_per_bike_df$bike_number[1]) %>%
  rename(latitude = start_latitude,
         longitude = start_longitude) %>%
  group_by(start_station_id, latitude, longitude) %>%
  count() %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers()

```


