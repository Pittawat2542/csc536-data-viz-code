# 26 Jan. 2021
# US Pollution dataset (2000-2016)

# Read in the CSV file
# Ref: https://www.kaggle.com/sogun3/uspollution
pol <- read.csv("pollution_us_2000_2016.csv")

# Check dimenion (rows and columns)
dim(pol)
nrow(pol)
ncol(pol)


# Show the first or last few rows
head(pol)
tail(pol)


# Look into a structure of the dataset
str(pol)

# Check for unique states in the US
unique(pol$State)
# sort in an alphabetical order
sort(unique(pol$State))

# Select only some particular rows/observations
phx <- pol[which((pol$State == "Arizona") & (pol$City=="Phoenix")),]
# or try another method
phx_a <- pol[pol$State == "Arizona" & pol$City == "Phoenix",]
# now select some particular columns, not all
phx_c <- phx_a[,c("State","City", "O3.AQI")]

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
qplot(y, binwidth = 1)

# try a boxplot of different gases for Phoenix and Pittsburgh
phx_pitt_o3 <- pol[pol$City == "Phoenix" | pol$City == "Pittsburgh", 
                   c("State","City", "O3.AQI")]
# check the structure
str(phx_pitt_o3)
unique(phx_pitt_o3$City)
unique(phx_pitt_o3$State)
# draw a boxplot  
boxplot(O3.AQI ~ City, data=phx_pitt_o3, 
        horizontal = TRUE, col =  c("cyan",rgb(.4,.3,0,0.5)))


