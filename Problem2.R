library(plyr)
library(ggplot2)
library(data.table)

##Set your work director and then load the file

##Read Data
Summary <- readRDS("summarySCC_PM25.rds")
Classification <- readRDS("Source_Classification_Code.rds")

total.emissions <- with(Summary, aggregate(Emissions, by = list(year), sum))


Summary.baltimore <- Summary[which(Summary$fips == "24510"),]
total.emissions.baltimore <- with(Summary.baltimore, aggregate(Emissions, by = list(year),sum))
colnames(total.emissions.baltimore) <- c("year", "Emissions")

##Open Device
png(filename = "plot2.png", width = 480, height = 480, units = "px")

##Graph
plot(total.emissions.baltimore$year, total.emissions.baltimore$Emissions, type = "b", pch = 18, col = "green", ylab = "Emissions", xlab = "Year", main = "Baltimore Emissions")

##Close Device
dev.off()
