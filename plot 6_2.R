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
BaltimorelosData <- merged_data[merged_data$fips %in% c("24510","06037"), ]

motor_vehicle_sources <- BaltimorelosData %>%
  filter(grepl("Vehicle", Short.Name))

motor_vehicle_emissions <- motor_vehicle_sources %>%
  group_by(fips, year) %>%
  summarise(total_emissions = sum(Emissions))

png("plot6_2.png", width = 480, height = 480)

ggplot(motor_vehicle_emissions, aes(x = year, y = total_emissions, fill = fips)) +
  geom_bar(aes(fill = fips), position = "dodge", stat="identity") +
  labs(x = "City",
       y = expression('Total PM'[2.5]*" Emission (in tons)"),
       title = expression('Changes in PM'[2.5]*" Emissions from Motor Vehicle-Related Sources")) +
  theme_minimal() +
  scale_fill_manual(values = c("24510" = "24510", "06037" = "06037"),
                    labels = c("24510" = "Baltimore", "06037" = "Los Angeles")) +
  scale_x_discrete(labels = c("24510" = "Baltimore", "06037" = "Los Angeles")) +
  guides(fill = guide_legend(title = "City"))

dev.off()
