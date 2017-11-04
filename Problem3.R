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

Summary.24510 <- Summary[which(Summary$fips == "24510"), ]
total.emissions.baltimore <- with(Summary.24510, aggregate(Emissions, by = list(year), sum))
colnames(total.emissions.baltimore) <- c("year", "Emissions")


total.emissions.baltimore.type <- ddply(Summary.24510, .(type, year), summarize,Emissions = sum(Emissions))
total.emissions.baltimore.type$Pollutant_Type <- total.emissions.baltimore.type$type


qplot(year, Emissions, data = total.emissions.baltimore.type, group = Pollutant_Type,color = Pollutant_Type, geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")

##device off
dev.off()