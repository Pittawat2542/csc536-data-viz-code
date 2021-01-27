pollution <- read.csv("../datasets/pollution.csv") # Give a DataFrame ~ Table in DB
# observation = row, variable = column

# Check dimension (rows and columns)
dim(pollution) # 1746661      29
nrow(pollution) # 1746661
ncol(pollution) # 29

# Show a first and last few rows
head(pollution)
tail(pollution)

# Show structure of the data
str(pollution)

# $ use to access properties
# Show all unique states
unique(pollution$State)

# Select only some particular rows/observations
# Filter only state "Arizona" and "Phoenix"
phx <- pollution[which((pollution$State == "Arizona") & (pollution$City=="Phoenix")),]

x <- phx$Date.Local
y <- phx$O3.AQI

# Check range value
range(y)

# Plot a simple histogram
hist(y)

# Import ggplot2 library after its package installation
# ggplot2 is a data visualization package 
library(ggplot2)
qplot(y)  # just another histogram
qplot(y, binwidth = 1) # histogram but change bin size
