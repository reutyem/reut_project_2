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

coal_combustion_sources <- merged_data %>%
  filter(grepl("Comb", Short.Name) & grepl("Coal", Short.Name))


coal_combustion_emissions <- coal_combustion_sources %>%
  group_by(year) %>%
  summarise(total_emissions = sum(Emissions))

png("plot4_2.png", width = 480, height = 480)

ggplot(coal_combustion_emissions, aes(x = year, y = total_emissions)) +
  geom_line(color = "red") +
  geom_point() +
  labs(x = "Year",
       y = expression('Total PM'[2.5]*" Emission (in tons)"),
       title = expression('Changes in PM'[2.5]*" Emissions from Coal Combustion-Related Sources")) +
  theme_minimal()


dev.off()
