
# 1 Feb. 2021
# By Pornchai Mongkolnam

# Some code from Data Visualization: a practical introduction by Kieran Healy, 
# Princeton Univ. Press, 2019


# Again we'll work on graphics with various plots
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
  labs(x = "GDP", y = "Life expectancy", title = "Gap for all")
# plot it
p
# try to make a log-10 scale of x
new_p <- p + scale_x_log10(labels=scales::dollar) + labs(x = "log GDP")
new_p

# let's select just the 2007 data
gap2007 <- gap[gap$year == 2007,]
p2007 <- ggplot(data =gap2007,mapping = aes(x = gdpPercap, y = lifeExp,
                                            size = pop, color = continent)) + 
  geom_point() + 
  coord_cartesian() + 
  #scale_x + 
  labs(x = "GDP per capita", y = "Life expectancy", title = "Year 2007")
# plot it
p2007 <- p2007 + scale_x_log10(labels=scales::dollar) + labs(x = "log GDP")
p2007


# try other looks
q <- ggplot(data = gap2007, mapping = aes(x =gdpPercap, y=lifeExp))
q + geom_point(color = "purple") + geom_smooth(method = "lm") + 
  scale_x_log10(labels=scales::dollar) +
  labs(x = "GDP per capita", y = "Life expectancy", title = "Year 2007 only")


# try another one
q <- ggplot(data = gap2007, mapping = aes(x =gdpPercap, y=lifeExp,
                                          size = pop, color = continent))
q + geom_point(alpha = 0.4) + 
  scale_x_log10(labels=scales::dollar) +
  labs(x = "GDP per capita", y = "Life expectancy", 
       title = "2007 GDP/capita and Life Expectancy",
       subtitle = "Data points are countries",
       caption = "Source: Gapminder.")

# try further plotting ...
q <- ggplot(data = gap2007, mapping = aes(x =gdpPercap, y=lifeExp,
                                          color = continent))
q + geom_point(alpha = 0.4) + geom_smooth(method = "lm", se = FALSE) + 
  scale_x_log10(labels=scales::dollar) +
  labs(x = "GDP per capita", y = "Life expectancy", 
       title = "2007 GDP/capita and Life Expectancy",
       subtitle = "Data points are countries",
       caption = "Source: Gapminder.")

# try an alternative on the original data (gapminder) of many years
# map different lines to different continents

r <- ggplot(data = gap, mapping = aes(x =gdpPercap, y=lifeExp,
                                      color = continent,
                                      fill = continent))
r + geom_point(alpha = 0.35) + geom_smooth(method = "gam", se = TRUE) + 
  scale_x_log10(labels=scales::dollar) +
  labs(x = "GDP per capita", y = "Life expectancy", 
       title = "1952-2007 GDP/capita and Life Expectancy",
       subtitle = "Data points are country-years",
       caption = "Source: Gapminder.")

# now try to map one smoothed line to all points (from all continents)
# by setting a color to the geom...
r <- ggplot(data = gap, mapping = aes(x =gdpPercap, y=lifeExp))
r <- r + geom_point(mapping = aes(color = continent), alpha= 0.4) +
  geom_smooth(method = "loess", se = TRUE) + 
  scale_x_log10(labels=scales::dollar) +
  labs(x = "GDP per capita", y = "Life expectancy", 
       title = "1952-2007 GDP/capita and Life Expectancy",
       subtitle = "Data points are country-years",
       caption = "Source: Gapminder.")
r
# now let's save the figure that we produce
ggsave(filename = "GDPperCap.png", plot = r)
# try another way with specified size
ggsave(filename = "GDPperCap1.png", plot = r, height = 8, width = 10, units = "in")



# To do:
# Change the mappings in the aes() function so that you plot
# life expectancy against population (pop) rather than per capita
# GDP. What does that look like? What does it tell you about the
# unit of observation in the dataset?

r <- ggplot(data = gap, mapping = aes(x =pop, y=lifeExp))
r <- r + geom_point(mapping = aes(color = continent), alpha= 0.4) +
  geom_smooth(method = "loess", se = TRUE) + 
  scale_x_log10(labels=scales::comma) +
  labs(x = "Population", y = "Life expectancy", 
       title = "1952-2007 Population and Life Expectancy",
       subtitle = "Data points are country-years",
       caption = "Source: Gapminder.")
r

# Now try to compare China to the USA

twoC <- gap[gap$country == "China" | gap$country == "United States",]

s <- ggplot(data = twoC, mapping = aes(x =pop, y=lifeExp, color = country))
s <- s + geom_point() +
  geom_smooth(method = "lm", se = TRUE) + 
  scale_x_log10(labels=scales::comma) +
  labs(x = "Population", y = "Life expectancy", 
       title = "1952-2007 Population and Life Expectancy",
       subtitle = "Data points are country-years",
       caption = "Source: Gapminder.")
s


# Other plots with differnt geom() ....
# The following plots show trends of each country, on the same display

p <- ggplot(data = gapminder, mapping = aes(x = year, y = gdpPercap))
p + geom_line(aes(group = country))

# now, try on separate displays, 
# for many small multiples, using facet...

p <- ggplot(data = gapminder, mapping = aes(x = year, y = gdpPercap))
p + geom_line(aes(group = country)) + facet_wrap(~continent)

# try another look
p <- ggplot(data = gapminder, mapping = aes(x = year, y = gdpPercap))
p + geom_line(color="red", aes(group = country)) +
  geom_smooth(size = 1.1, method = "loess", se = FALSE) +
  scale_y_log10(labels=scales::dollar) +
  facet_wrap(~ continent, ncol = 5) +
  labs(x = "Year",
       y = "GDP per capita",
       title = "GDP per capita of five continents")

# try another one
# we'll plot to see the number of each continent's countries
table(gap2007$continent)
# now, plotting...
p <- ggplot(data = gap2007, mapping = aes(x = continent, fill = continent))
p + geom_bar() + labs(y = "No. of countries",
                      x = "Continent",
                      title = "Year 2007") +
  guides(fill = FALSE) # used to turn on/off the chart's legend



# set 12,000 USD to be the threshold of developing vs developed countries...
richLevel <- c()
for (i in gap2007$gdpPercap){
  if(i < 12000){
    richLevel <- append(richLevel,"Developing")
    #gap2007$gdpLevel[] <- "Developing"
  }
  else{
    #gap2007$gdpLevel <- "Developed" 
    richLevel <- append(richLevel, "Developed")
  }
}
# now try to modify the table's data by adding a new column 
gap2007$gdpLevel <- richLevel


# try a stack bar chart
p <- ggplot(data = gap2007, mapping = aes(x = continent, fill = gdpLevel))
p + geom_bar() + labs(y = "No. of countries",
                      x = "Continent",
                      title = "World in Year 2007")


