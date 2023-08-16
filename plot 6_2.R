library(readr)
library( stringr)
library(dplyr)
library(ggplot2)
setwd("C:/R cor")
file <- "Source_Classification_Code.rds"
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


merged_data <- NEI %>%
  left_join(SCC, by = "SCC")
BaltimoreData <- merged_data[merged_data$fips == "24510", ]

motor_vehicle_sources <- BaltimoreData %>%
  filter(grepl("Vehicle", Short.Name))

motor_vehicle_emissions <- motor_vehicle_sources %>%
  group_by(year) %>%
  summarise(total_emissions = sum(Emissions))

png("plot5_2.png", width = 480, height = 480)
ggplot(motor_vehicle_emissions, aes(x = year, y = total_emissions)) +
  geom_line(color = "blue") +
  geom_point() +
  labs(x = "Year",
       y = expression('Total PM'[2.5]*" Emission (in tons)"),
       title =  expression('Changes in PM'[2.5]*" Emissions from Motor Vehicle-Related Sources")) +
  theme_minimal()


dev.off()
