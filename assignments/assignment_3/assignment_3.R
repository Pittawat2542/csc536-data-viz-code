library(ggplot2)
library(plotly)
library(gganimate)
library(socviz)

df <- gss_lon

p <- ggplot(data = df, aes(fill = sex, x = degree))
p + geom_bar(position = "stack") +
  facet_wrap( ~ race) +
  ggtitle("Number of People in Each Level of Education Separated by Race") +
  labs(caption = "Source: https://gss.norc.org",
       fill = "Gender") +
  xlab("Education Level") +
  ylab("Count") +
  theme(
    plot.title = element_text(size = 16, face = 'bold'),
    axis.title.x = element_text(vjust = -3),
    axis.title.y = element_text(vjust = 2),
    axis.text.x = element_text(angle = 90),
    strip.text.x = element_text(face = "bold", size = 10)
  )

p <- ggplot(data = df, aes(x = age, fill = sex))
p + geom_bar(position = 'dodge',
             binwidth = 5,
             stat = "bin") +
  facet_grid(race ~ degree) +
  ggtitle("Number of People in Each Age Range Separated by Race and Level of Education") +
  labs(caption = "Source: https://gss.norc.org",
       fill = "Gender") +
  xlab("Age") +
  ylab("Count") +
  theme(
    plot.title = element_text(size = 16, face = 'bold'),
    axis.title.x = element_text(vjust = -3),
    axis.title.y = element_text(vjust = 2),
    axis.text.x = element_text(angle = 90),
    strip.text.x = element_text(face = "bold", size = 10),
    strip.text.y = element_text(face = "bold", size = 10)
  )

df$happy <- addNA(df$happy)
levels(df$happy) <- 3:0
df$happy <- as.numeric(df$happy)
groupped_by_year_df <-
  aggregate(df[, 18],
            list(df$year),
            mean,
            na.rm = TRUE,
            na.action = na.pass)
groupped_by_year_df$Group.1 <-
  as.Date(paste(groupped_by_year_df$Group.1, "-01-01", sep = ""))

p <-
  ggplot(data = groupped_by_year_df, mapping = aes(x = Group.1, y = happy))
p + geom_line(color = "skyblue") +
  geom_point(color = "steelblue") +
  ggtitle("Average Happiness Level from 1972 - 2016",
          subtitle = 'Happiness level: 0 = NA, 1 = Not Too Happy, 2 = Pretty Happy, 3 = Very Happy') +
  labs(caption = "Source: https://gss.norc.org") +
  xlab("Year") +
  ylab("Happiness level") +
  scale_x_date(
    date_breaks = "3 years",
    date_labels = "%Y",
    limit = c(
      min(groupped_by_year_df$Group.1),
      max(groupped_by_year_df$Group.1)
    )
  ) +
  ylim(2.6, 3.5) +
  theme(
    plot.title = element_text(size = 16, face = 'bold'),
    plot.subtitle = element_text(size = 10),
    axis.title.x = element_text(vjust = -3),
    axis.title.y = element_text(vjust = 2)
  )
