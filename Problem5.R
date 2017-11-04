##Library
library(ggplot2)
library(plyr)

##Set work directory and load Data
Sumry <- readRDS("summarySCC_PM25.rds")
Clasify <- readRDS("Source_Classification_Code.rds")

Clasify.motor <- grep("motor", Clasify$Short.Name, ignore.case = TRUE)
Clasify.motor <- Clasify[Clasify.motor, ]
Clasify.identifiers <- as.character(Clasify.motor$Clasify)
Sumry$Clasify <- as.character(Sumry$Clasify)
Sumry.motor <- Sumry[Sumry$Clasify %in% Clasify.identifiers, ]

Sumry.motor.24510 <- Sumry.motor[which(Sumry.motor$fips == "24510"), ]

aggregate.motor.24510 <- with(Sumry.motor.24510, aggregate(Emissions, by = list(year), sum))

plot(aggregate.motor.24510, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions from Motor Vehicle Sources")