library(plyr)
library(ggplot2)
library(data.table)

##Set your work director and then load the file

##Read Data
Summary <- readRDS("summarySCC_PM25.rds")
Classification <- readRDS("Source_Classification_Code.rds")

total.emissions <- with(Summary, aggregate(Emissions, by = list(year), sum))

##Opening the Device`
png(filename = "plot1.png", width = 480, height = 480, units = "px")

##Plot
plot(total.emissions, type = "b", pch = 18, col = "green", ylab = "Emissions",xlab = "Year", main = "Annual Emissions")

##Closing the Device
dev.off()