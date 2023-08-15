library(readr)
library( stringr)
library(dplyr)
setwd("C:/R cor")
file <- "Source_Classification_Code.rds"
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
total_emissions <- NEI %>%
  group_by(year) %>%
  summarise(total_pm25_emissions = sum(Emissions))


png("plot1_2.png", width = 480, height = 480)

plot(total_emissions$year, total_emissions$total_pm25_emissions,
     col = "blue",
     type = "l", 
     xlab = "Year",
     ylab = expression('Total PM'[2.5]*" Emission (in tons)"),
     main = expression('Total PM'[2.5]*" Emissions in the United States (1999-2008)"))

points(total_emissions$year, total_emissions$total_pm25_emissions, pch = 16, col = "blue")

dev.off()
