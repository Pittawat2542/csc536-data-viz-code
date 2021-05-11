# -*- coding: utf-8 -*-
"""CSC536_Term_Project.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1JNh6McP_9l19xJ6wVke714GLEZPOfvt_

# Education Statistics Dataset
by Pittawat Taveekitworachai 61130500220

Data Source: [World Bank](https://datacatalog.worldbank.org/dataset/education-statistics)

# Setup

## Import required dependencies
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib.dates import DateFormatter
import matplotlib.dates as mdates

"""## General config"""

sns.set_style("darkgrid")

from google.colab import drive
drive.mount('/gdrive')

prefix_path = '/gdrive/MyDrive/Colab Notebooks/CSC536/'

"""## Import dataset and Data Examination"""

country = pd.read_csv(f'{prefix_path}country.csv')
education = pd.read_csv(f'{prefix_path}education.csv')

country.head()

education.head()

country.info()

education.info()

country.describe()

education.describe()

country.isnull().sum()

education.isnull().sum()

"""# Data Preparation"""

country['Unnamed: 31'].unique()

education['Unnamed: 69'].unique()

country.drop('Unnamed: 31', axis='columns', inplace=True)
education.drop('Unnamed: 69', axis='columns', inplace=True)

education = education.melt(id_vars=['Country Name', 'Country Code', 'Indicator Name', 'Indicator Code'], 
        var_name='Year', 
        value_name='Value')

education.info()

education.info()

education['Year'] = pd.to_datetime(education['Year'], format='%Y')

education.info()

education.head()

education = education.dropna()

education['Indicator Name'].unique()

"""# Data Visualization

## GDP per capita, PPP (current international $) Thailand vs World
"""

gdp = education[(education['Indicator Name'] == 'GDP per capita, PPP (current international $)') & (education['Year'] >= '2000-01-01') & (education['Year'] <= '2015-12-31')]

gdp_th_world = gdp[(gdp['Country Name'] == 'Thailand') | (gdp['Country Name'] == 'World')]
gdp_th_world.head()

plt.figure(figsize=(20,15))

ax = sns.lineplot(data=gdp_th_world, x="Year", y="Value", hue='Country Name')

ax.set_title("GDP per capita, PPP (current international $) of Thailand vs World from 2000 to 2015")
ax.set_xlabel('Year')
ax.set_ylabel('GDP per capita, PPP (current international $)')

"""In this time-series plot, it shows that gross domestic product scaled with purchasing power parity and current international dollars. It means the GDP is scaled to the current value of dollars unit and apply the scaling on the price of common goods to have the same scale for comparison. It can be seen that comparing Thailand to the average of the world, Thailand is doing quite good. Because the GDP (PPP) of Thailand over time is around the average from 2000 to 2015. GDP is one of a very good indicator on how each country doing in term of economic. As generally know that economic status can affect other aspects of the country, for example, education, politics, health services."""

plt.figure(figsize=(20,15))

ax = sns.boxplot(x="Value", data=gdp)

ax.set_title("GDP per capita, PPP (current international $) of whole World from 2000 to 2015")
ax.set_xlabel('GDP per capita, PPP (current international $)')

"""Observing the boxplot and it can be seen that most country fall below the average, so Thailand doing around average is quite good to be said. But the maximum and minimum also very wide. So, some countries has very high and extremely low GDP.

## PISA Thailand vs World
"""

pisa_math = education[education['Indicator Name'] == 'PISA: Mean performance on the mathematics scale']
pisa_read = education[education['Indicator Name'] == 'PISA: Mean performance on the reading scale']
pisa_sci = education[education['Indicator Name'] == 'PISA: Mean performance on the science scale']

pisa_math_th = pisa_math[pisa_math['Country Name'] == 'Thailand']
pisa_read_th = pisa_read[pisa_read['Country Name'] == 'Thailand']
pisa_sci_th = pisa_sci[pisa_sci['Country Name'] == 'Thailand']

pisa_math_mean_world = pisa_math.groupby('Year', as_index=False).mean()
pisa_math_mean_world['Country Name'] = 'World'
pisa_math_mean_world['Country Code'] = 'WRD'
pisa_math_mean_world['Indicator Name'] = 'PISA: Mean performance on the mathematics scale'
pisa_math_mean_world['Indicator Code'] = 'LO.PISA.MAT'
pisa_math_mean_world.head()

pisa_read_mean_world = pisa_read.groupby('Year', as_index=False).mean()
pisa_read_mean_world['Country Name'] = 'World'
pisa_read_mean_world['Country Code'] = 'WRD'
pisa_read_mean_world['Indicator Name'] = 'PISA: Mean performance on the reading scale'
pisa_read_mean_world['Indicator Code'] = 'LO.PISA.REA'
pisa_read_mean_world.head()

pisa_sci_mean_world = pisa_sci.groupby('Year', as_index=False).mean()
pisa_sci_mean_world['Country Name'] = 'World'
pisa_sci_mean_world['Country Code'] = 'WRD'
pisa_sci_mean_world['Indicator Name'] = 'PISA: Mean performance on the science scale'
pisa_sci_mean_world['Indicator Code'] = 'LO.PISA.SCI'
pisa_sci_mean_world.head()

pisa_th_world = pd.concat([pisa_math_th, pisa_math_mean_world, pisa_read_th, pisa_read_mean_world, pisa_sci_th, pisa_sci_mean_world])
pisa_th_world

plt.figure(figsize=(20,15))

ax = sns.lineplot(data=pisa_th_world, x="Year", y="Value", hue='Country Name', style='Indicator Name', markers=True)

ax.set_title("PISA Score of Thailand vs World from 2000 to 2015")
ax.set_xlabel('Year')
ax.set_ylabel('PISA Score')

"""The Programme for International Student Assessment (PISA) is a worldwide study by the Organisation for Economic Co-operation and Development (OECD) in member and non-member nations intended to evaluate educational systems by measuring 15-year-old school pupils' scholastic performance on mathematics, science, and reading. PISA is held every three years. This graph stated all three types of PISA test's scores, mathematics, reading, and science. This chart comapres the score between Thailand and the average score on the world. The PISA score scaled to fit normal distribution, so maximum and minimum score does not really matter much. In this comparison, Thailand performs poorly compare to the world average. Despite the fact that Thailand performs quite well on the GDP that comparable to the average.

## Average Years of Primary Schooling of Thailand vs World
"""

primary_schooling = education[education['Indicator Name'] == 'Barro-Lee: Average years of primary schooling, age 15+, total']

primary_schooling_world = primary_schooling.groupby('Year', as_index=False).mean()
primary_schooling_world['Country Name'] = 'World'
primary_schooling_world['Country Code'] = 'WTD'
primary_schooling_world['Indicator Name'] = 'Barro-Lee: Average years of primary schooling, age 15+, total'
primary_schooling_world['Indicator Code'] = 'BAR.PRM.SCHL.15UP'
primary_schooling_world.head()

primary_schooling_th = primary_schooling[primary_schooling['Country Name'] == 'Thailand']
primary_schooling_th.head()

primary_schooling_th_world = pd.concat([primary_schooling_th, primary_schooling_world])

plt.figure(figsize=(20,15))

ax = sns.lineplot(data=primary_schooling_th_world, x="Year", y="Value", hue='Country Name')

ax.set_title("Thailand Average Years of Schooling (15+ years population)")
ax.set_xlabel('Year')
ax.set_ylabel('Average Years of Schooling (15+ years population)')

"""This chart shows the average years of schooling of population with age over 15 in Thailand compare to the world average. It can be clearly seen that Thailand's primary schooling years is longer than the average of the world. So, we can roughly say that with longer priamry education time, population maybe better at basic skills such as mathematics and reading. But the trend of Thailand years is not that steep compare to the world average. So, the world puts more effort to accelerate the rate of change in primary schooling years."""

primary_schooling_2010 = primary_schooling[primary_schooling['Year'] == '2010-01-01']

plt.figure(figsize=(20,15))

ax = sns.histplot(primary_schooling_2010, x="Value")

ax.set_title("Average Years of Schooling (15+ years population) on 2010")
ax.set_xlabel('Primary Schooling Years')
ax.set_ylabel('Count')

"""This histogram shows that most of the countries population has around 5 to 6 years (Thailand has around this number). This may not be surprising, since primary education usually take around 6 years for most of the countries. However, compare the left side and right side of the mean. It can be seen that most of the countries have less than 5 years of primary schooling.

## TIMSS of Thailand vs World
"""

timss_math_four = education[education['Indicator Name'] == 'TIMSS: Mean performance on the mathematics scale for fourth grade students, total']
timss_math_eight = education[education['Indicator Name'] == 'TIMSS: Mean performance on the mathematics scale for eighth grade students, total']
timss_sci_four = education[education['Indicator Name'] == 'TIMSS: Mean performance on the science scale for fourth grade students, total']
timss_sci_eight = education[education['Indicator Name'] == 'TIMSS: Mean performance on the science scale for eighth grade students, total']

timss_math_four_th = timss_math_four[timss_math_four['Country Name'] == 'Thailand']
timss_math_eight_th = timss_math_eight[timss_math_eight['Country Name'] == 'Thailand']
timss_sci_four_th = timss_sci_four[timss_sci_four['Country Name'] == 'Thailand']
timss_sci_eight_th = timss_sci_eight[timss_sci_eight['Country Name'] == 'Thailand']

timss_math_four_world = timss_math_four.groupby('Year', as_index=False).mean()
timss_math_four_world['Country Name'] = 'World'
timss_math_four_world['Country Code'] = 'WRD'
timss_math_four_world['Indicator Name'] = 'TIMSS: Mean performance on the mathematics scale for fourth grade students, total'
timss_math_four_world['Indicator Code'] = 'LO.TIMSS.MAT4'

timss_math_eight_world = timss_math_eight.groupby('Year', as_index=False).mean()
timss_math_eight_world['Country Name'] = 'World'
timss_math_eight_world['Country Code'] = 'WRD'
timss_math_eight_world['Indicator Name'] = 'TIMSS: Mean performance on the mathematics scale for eighth grade students, total'
timss_math_eight_world['Indicator Code'] = 'LO.TIMSS.MAT8'

timss_sci_four_world = timss_sci_four.groupby('Year', as_index=False).mean()
timss_sci_four_world['Country Name'] = 'World'
timss_sci_four_world['Country Code'] = 'WRD'
timss_sci_four_world['Indicator Name'] = 'TIMSS: Mean performance on the science scale for fourth grade students, total'
timss_sci_four_world['Indicator Code'] = 'LO.TIMSS.SCI4'

timss_sci_eight_world = timss_sci_eight.groupby('Year', as_index=False).mean()
timss_sci_eight_world['Country Name'] = 'World'
timss_sci_eight_world['Country Code'] = 'WRD'
timss_sci_eight_world['Indicator Name'] = 'TIMSS: Mean performance on the science scale for eighth grade students, total'
timss_sci_eight_world['Indicator Code'] = 'LO.TIMSS.SCI8'

timss = pd.concat([timss_math_four_th, timss_math_eight_th, timss_sci_four_th, timss_sci_eight_th, timss_math_four_world, timss_math_eight_world, timss_sci_four_world, timss_sci_eight_world])
timss.head()

timss_four_math = pd.concat([timss_math_four_th, timss_math_four_world])
timss_eight_math = pd.concat([timss_math_eight_th, timss_math_eight_world])
timss_four_sci = pd.concat([timss_sci_four_th, timss_sci_four_world])
timss_eight_sci = pd.concat([timss_sci_eight_th, timss_sci_eight_world])

plt.figure(figsize=(20,15))

# ax.set_title("TIMSS of Thailand vs World")
# ax.set_xlabel('Year')
# ax.set_ylabel('TIMSS')

fig, axs = plt.subplots(2, 2, figsize=(20, 15))
fig.suptitle('TIMSS Score of Thailand vs World')

sns.lineplot(ax=axs[0, 0], data=timss_four_math, x="Year", y="Value", hue='Country Name')
axs[0, 0].set_title("TIMSS Mathematics Score of Fourth Grade Student")
axs[0, 0].set_xlabel('Year')
axs[0, 0].set_ylabel('Mathematics Score (4th Grade)')
axs[0, 0].set_ylim(420, 530)

sns.lineplot(ax=axs[0, 1], data=timss_eight_math, x="Year", y="Value", hue='Country Name')
axs[0, 1].set_title("TIMSS Mathematics Score of Eighth Grade Student")
axs[0, 1].set_xlabel('Year')
axs[0, 1].set_ylabel('Mathematics Score (8th Grade)')
axs[0, 1].set_ylim(420, 530)

sns.lineplot(ax=axs[1, 0], data=timss_four_sci, x="Year", y="Value", hue='Country Name')
axs[1, 0].set_title("TIMSS Science Score of Fourth Grade Student")
axs[1, 0].set_xlabel('Year')
axs[1, 0].set_ylabel('Science Score (4th Grade)')
axs[1, 0].set_ylim(420, 530)

sns.lineplot(ax=axs[1, 1], data=timss_eight_sci, x="Year", y="Value", hue='Country Name')
axs[1, 1].set_title("TIMSS Science Score of Eighth Grade Student")
axs[1, 1].set_xlabel('Year')
axs[1, 1].set_ylabel('Science Score (8th Grade)')
axs[1, 1].set_ylim(420, 530)

"""Trends in International Mathematics and Science Study (TIMSS) is an international assessment focused on mathematics and science. Participants in tests are fourth and eighth grade students (or equivalent). In this visuals, it focuses on Thailand performance compare to the world average. From the graphs, we can see that Thailand performance is acceptable on all subjects in almost every years. While eighth students performing around the average, the score performed by fourth grade student is a little bit lower than the world average. So, this confirms that average performance of students in Thailand on mathematics is on avereage. And, Thai student are better at mathematics because study heavier and deeper is a myth. It is a truth that Thai students can achieved many academic internations awards. But look at the whole picture of every students in Thailand, that does not seem to be the case. Another interesting trend is that Thai mathematics and science scores except the science score by fourth grade students has decreasing trend, while the world seems to be an increasing trend after 2007. This could show a sign of a problem that we are moving backwards in term of academic perforamnce at global scale."""

timss_math_four_2015 = timss_math_four[timss_math_four['Year'] == '2015-01-01']
timss_math_eight_2015 = timss_math_eight[timss_math_eight['Year'] == '2015-01-01']
timss_sci_four_2015 = timss_sci_four[timss_sci_four['Year'] == '2015-01-01']
timss_sci_eight_2015 = timss_sci_eight[timss_sci_eight['Year'] == '2015-01-01']

fig, axs = plt.subplots(2, 2, figsize=(20, 15), sharey=True)
fig.suptitle('2015 TIMSS Score Distribution')

sns.histplot(ax=axs[0, 0], data=timss_math_four_2015, x="Value")
axs[0, 0].set_title("TIMSS Mathematics Score of Fourth Grade Student")
axs[0, 0].set_xlabel('Mathematics Score (4th Grade)')
axs[0, 0].set_ylabel('Count')
axs[0, 0].set_xlim(300, 630)

sns.histplot(ax=axs[0, 1], data=timss_math_eight_2015, x="Value")
axs[0, 1].set_title("TIMSS Mathematics Score of Eighth Grade Student")
axs[0, 1].set_xlabel('Mathematics Score (8th Grade)')
axs[0, 1].set_ylabel('Count')
axs[0, 1].set_xlim(300, 630)

sns.histplot(ax=axs[1, 0], data=timss_sci_four_2015, x="Value")
axs[1, 0].set_title("TIMSS Science Score of Fourth Grade Student")
axs[1, 0].set_xlabel('Science Score (4th Grade)')
axs[1, 0].set_ylabel('Count')
axs[1, 0].set_xlim(300, 630)

sns.histplot(ax=axs[1, 1], data=timss_sci_eight_2015, x="Value")
axs[1, 1].set_title("TIMSS Science Score of Eighth Grade Student")
axs[1, 1].set_xlabel('Science Score (8th Grade)')
axs[1, 1].set_ylabel('Count')
axs[1, 1].set_xlim(300, 630)

"""In this chart, it shows the distribution of 2015 TIMSS scores. While the score performing by the eighth students show that mostly flat distributed. The score performed by fourth grade student crowded around 500 - 550. """

fig, axs = plt.subplots(2, 2, figsize=(20, 15))
fig.suptitle('2015 TIMSS Score Top Ten Countries')

sns.barplot(ax=axs[0, 0], data=timss_math_four_2015.nlargest(10, 'Value'), x="Value", y='Country Name', color="#0E86D4")
axs[0, 0].set_title("TIMSS Mathematics Score of Fourth Grade Student")
axs[0, 0].set_xlabel('Mathematics Score (4th Grade)')
axs[0, 0].set_ylabel('')

sns.barplot(ax=axs[0, 1], data=timss_math_eight_2015.nlargest(10, 'Value'), x="Value", y='Country Name', color="#0E86D4")
axs[0, 1].set_title("TIMSS Mathematics Score of Eighth Grade Student")
axs[0, 1].set_xlabel('Mathematics Score (8th Grade)')
axs[0, 1].set_ylabel('')

sns.barplot(ax=axs[1, 0], data=timss_sci_four_2015.nlargest(10, 'Value'), x="Value", y='Country Name', color="#0E86D4")
axs[1, 0].set_title("TIMSS Science Score of Fourth Grade Student")
axs[1, 0].set_xlabel('Science Score (4th Grade)')
axs[1, 0].set_ylabel('')

sns.barplot(ax=axs[1, 1], data=timss_sci_eight_2015.nlargest(10, 'Value'), x="Value", y='Country Name', color="#0E86D4")
axs[1, 1].set_title("TIMSS Science Score of Eighth Grade Student")
axs[1, 1].set_xlabel('Science Score (8th Grade)')
axs[1, 1].set_ylabel('')

"""The charts show the top ten countries with highest 2015 score in each category. The highest scores in all categories achieved by Singapore. So, it can said that Singapore students is very strong in mathematics and science skills. Korea Republic, Hong Kong, and Japan seems to be very competitive in term of the score as well. The top three in each categories do not have a large gap in the score, but rather very close cut. Surprisingly, Kazakhastan which has an image of third world country also performing very well and can be included in a top ten in very categories.

# Data Wrangling for R/Orange
"""

education[education['Indicator Name'] == 'Gross enrolment ratio, primary, both sexes (%)']

education[education['Indicator Name'] == 'Gross enrolment ratio, primary, both sexes (%)'].to_csv('school_enrollment.csv')

education[education['Indicator Name'] == 'Barro-Lee: Percentage of population age 15+ with primary schooling. Completed Primary']

education[education['Indicator Name'] == 'Barro-Lee: Percentage of population age 15+ with primary schooling. Completed Primary'].to_csv('primary_completed.csv')