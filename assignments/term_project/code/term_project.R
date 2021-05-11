library(tidyverse)
library(ggplot2)

df <- read_csv('../../datasets/primary_completed.csv')

thailand <- df[df["Country Code"] == "THA", 5:7]

ggplot(data = thailand, mapping = aes(x = Year, y = Value)) +
  geom_line() +
  labs(title = "Percentage of Primary Education Completed of Thailand from 1970 - 2010", xlab = "Year",
       ylab =  "%") +
  scale_x_date(date_breaks = "3 years", date_labels = "%Y") +
  scale_y_continuous(breaks = round(seq(0,
                                        100,
                                        5)), limits = c(0, NA)) +
  theme_minimal()
