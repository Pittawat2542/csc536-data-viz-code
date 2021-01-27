
# 26 Jan. 2021
# By Pornchai Mongkolnam


# make a vector
my_val <- c(2,4,6,9,10)
# check the data first to better understand it
str(my_val)
typeof(my_val)
class(my_val)

# do some simple statistics
range(my_val)
mean(my_val)
sd(my_val)
summary(my_val)
# find a quantile
quantile(my_val)
# Produce box-and-whisker plot(s)
boxplot(my_val)
boxplot(my_val, horizontal = TRUE)
boxplot(my_val, horizontal = TRUE, col = "lightblue", 
        main = "My first boxplot", xlab = "Simple values")

# try and compare to this new dataset
my_val <- c(2,4,6,9,10,30,50)
boxplot(my_val)

my_val[4] = 10
my_val
table(my_val)
sort(table(my_val))

# Install tidyverse packange and load it
# Also install socviz, gapminder package and load it

library(tidyverse)
library(socviz)
library(gapminder)

# datasets of GDP of variouns countries
gapminder
gap <- gapminder
# plot and see
ggplot(data =gap,mapping = aes(x = gdpPercap, y = lifeExp))+geom_point()

# try different plots
p <- ggplot(data =gap,mapping = aes(x = gdpPercap, y = lifeExp,
                               size = pop, color = continent)) + 
  geom_point() + 
  coord_cartesian() + 
  #scale_x + 
  labs(x = "GDP", y = "Life expectancy", title = "Gap for all")
# plot it
p
# try to make a log-10 scale of x
new_p <- p + scale_x_log10(labels=scales::dollar) + labs(x = "log GDP")
new_p

# try other looks
q <- ggplot(data = gapminder, mapping = aes(x =gdpPercap, y=lifeExp))
q + geom_smooth()
q + geom_point() + geom_smooth()
q + geom_point() + geom_smooth(method = "lm")


# select just Thailand's
tgap <- gap[gap$country == "Thailand",]
