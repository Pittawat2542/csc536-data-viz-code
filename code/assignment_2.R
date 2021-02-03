library(tidyverse)
library(ggplot)
library("colorspace")

gdp_data <- read_csv("../datasets/gdp.csv")
country_data <- read_csv("../datasets/gdp_meta_country.csv")
full_data <- merge(gdp_data, country_data, by = "Country Code")

thailand <- full_data[full_data["Country Name"] == "Thailand", 5:64]

thailand_day <- list()
thailand_day <-
  as.Date(paste(colnames(thailand), "-01-01", sep = ""))

thailand_gdp <- list()
for (col in colnames(thailand)) {
  thailand_gdp <- c(thailand_gdp, thailand[[col]])
  
}

thailand_processed <- data.frame()

for (i in seq_along(thailand_day)) {
  thailand_processed[i, 'day'] <- thailand_day[i]
  thailand_processed[i, 'value'] <- thailand_gdp[i]
}

ggplot(data = thailand_processed, mapping = aes(x = day, y = value)) +
  geom_line() +
  labs(title = "GDP of Thailand from 1960 - 2019", xlab = "Year", ylab =
         "GDP") +
  scale_x_date(date_breaks = "7 years", date_labels = "%Y") +
  scale_y_continuous(breaks = round(seq(
    min(thailand_processed$value),
    max(thailand_processed$value),
    1000
  )), limits = c(0, NA)) +
  theme_minimal()

full_data$Mean <- rowMeans(full_data[, 5:64], na.rm = TRUE)

top_ten_mean_country <-
  head(full_data[order(-full_data$Mean),], n = 10)
top_ten_mean_country$`Country Name` <-
  factor(top_ten_mean_country$`Country Name`, levels = top_ten_mean_country$`Country Name`)

ggplot(data = top_ten_mean_country, aes(x = `Country Name`, y = Mean)) +
  geom_bar(stat = "identity") +
  labs(title = "Top 10 countries with the most average GDP from 1960 - 2019") +
  xlab("Country") +
  ylab("Average GDP") +
  coord_flip() +
  theme_minimal()

asean = c(
  "Indonesia",
  "Thailand",
  "Malaysia",
  "Singapore",
  "Philippines",
  "Vietnam",
  "Myanmar",
  "Cambodia",
  "Brunei Darussalam",
  "Cambodia"
)

colors <-
  c(
    "red",
    "green",
    "blue",
    "pink",
    "purple",
    "yellow",
    "orange",
    "#91ACE1",
    "#C29DDE",
    "#DE94C8"
  )
days <- as.Date(paste(colnames(thailand), "-01-01", sep = ""))
p <- ggplot()
idx <- 1

for (country in asean) {
  current_country <-
    full_data[full_data["Country Name"] == country, 5:64]
  
  gdp <- list()
  for (col in colnames(current_country)) {
    gdp <- c(gdp, current_country[[col]])
  }
  
  processed <- data.frame()
  
  for (i in seq_along(thailand_day)) {
    processed[i, 'country'] <- asean[idx]
    processed[i, 'day'] <- days[i]
    processed[i, 'value'] <- gdp[i]
  }
  p <-
    p + geom_line(
      data = processed,
      aes(x = day, y = value, color=country),
      show.legend = TRUE
    )
    idx <- idx + 1
}

p +
  labs(title = "GDP of ASEAN countries from 1960 - 2019") +
  xlab("Year") +
  ylab("GDP") +
  scale_x_date(date_breaks = "7 years", date_labels = "%Y") +
  scale_color_manual(
    name = "Country",
    values = colors
  ) +
  theme_minimal()
