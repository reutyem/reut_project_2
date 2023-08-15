library(readr)
library( stringr)
library(dplyr)
setwd("C:/R cor")
file <- "Source_Classification_Code.rds"
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


BaltimoreData <- NEI[NEI$fips == "24510", ]
total_emissions <- BaltimoreData %>%
  group_by(year) %>%
  summarise(total_pm25_emissions = sum(Emissions))
png("plot2_2.png", width = 480, height = 480)

plot(total_emissions$year, total_emissions$total_pm25_emissions,
     col = "red",
     type = "l", 
     xlab = "Year",
     ylab = expression('Total PM'[2.5]*" Emission (in tons)"),
     main = expression('Total PM'[2.5]*" Emissions in Baltimore city, Maryland (1999-2008)"))

points(total_emissions$year, total_emissions$total_pm25_emissions, pch = 16, col = "red")

dev.off()
