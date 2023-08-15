library(readr)
library( stringr)
library(dplyr)
library(ggplot2)
setwd("C:/R cor")
file <- "Source_Classification_Code.rds"
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


BaltimoreData <- NEI[NEI$fips == "24510", ]
total_emissions <- BaltimoreData %>%
  group_by(type,year) %>%
  summarise(total_pm25_emissions = sum(Emissions))


png("plot3_2.png", width = 480, height = 480)

ggplot(total_emissions,aes(year,total_pm25_emissions,color = type))+
  geom_point()+
  geom_line()+
  labs(x = "Year",
       y = expression('Total PM'[2.5]*" Emission (in tons)"),
       title = expression('Total PM'[2.5]*" Emissions in Baltimore city, Maryland (1999-2008)")) +
  scale_color_discrete(name = "Source Type") +
  theme_minimal()

dev.off()
