library(magrittr)
library(dplyr)
library("colorspace")

df <- read.csv("../datasets/pollution.csv")

clean_df <- na.omit(df)

boxplot(
  clean_df$CO.AQI,
  clean_df$SO2.AQI,
  clean_df$NO2.AQI,
  clean_df$O3.AQI,
  horizontal = TRUE,
  main = "Multiple boxplots of each type of AQI",
  names = c("CO", "SO2", "NO2", "O3"),
  col = rainbow_hcl(4),
  xlab = "AQI",
  ylab = "Type",
  border = rainbow_hcl(4),
  medcol = "white"
)

co_aqi_by_state <-
  aggregate(clean_df[, c("CO.AQI")], list(clean_df$State), mean)

b <- barplot(
  co_aqi_by_state$x,
  names = co_aqi_by_state$Group.1,
  col = rainbow_hcl(length(co_aqi_by_state$Group.1)),
  xlab = "",
  ylab = "CO AQI (Mean)",
  main = "Average CO AQI by state",
  ylim=range(0, 20),
  las=2
)
par(mar=c(10,6,4,1)+.1)
text(b, co_aqi_by_state$x + 0.4 , format(round(co_aqi_by_state$x, digits=2), nsmall = 2))
mtext("State", side=1)

clean_df$Date.Local <- as.Date(clean_df$Date.Local)

plot(clean_df$Date.Local, clean_df$CO.AQI, 
     main="CO AQI over time", 
     xlab="Time", 
     ylab="CO AQI",
     col=rainbow_hcl(1),
     type="p"
     )


