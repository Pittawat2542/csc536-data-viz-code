df <- read.csv("../datasets/pollution.csv")

# Check class
class(1)

# Check type
typeof(1)

# Structure
str(df)

# Statistic
mean(c(1, 2, 3))
sd(c(1, 2, 3))
summary(c(1, 2, 3))
quantile(c(1, 2, 3))


# Access data via index (Start from 1 not 0)
a <- c(1, 2, 3, 4, 5, 5)
a[1]
table(a)

# Show only unique
unique(df$State)

# Sort data by alphabetical order
sort(unique(df$State))

# Select only some rows
df[which((df$State == "Arizona") & (df$City == "Phoenix"))), ]
# OR
df[df$State == "Arizona" & df$City == "Phoenix", ]

# Select only some columns
# c() return vector (1d-array), c() can also use to concat two vectors
df[, c("State", "City", "O3.AQI")]

# Return range of data
range(df$O3.AQI)

# Display histogram
hist(df$O3.AQI)

library(ggplot2)
qplot(df$O3.AQI)
qplot(df$O3.AQI, binwidth=1)

boxplot(O3.AQI ~ City, data=df, horizontal = TRUE, col=c("Cyan", rgb(.3, .4, 0, .5)))