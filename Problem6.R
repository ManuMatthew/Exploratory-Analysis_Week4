##library
library(plyr)
library(ggplot2)

##Set work directory and load Data
Sumry <- readRDS("summarySCC_PM25.rds")
Clasify <- readRDS("Source_Classification_Code.rds")


Clasify.motor <- grep("motor", Clasify$Short.Name, ignore.case = TRUE)
Clasify.motor <- Clasify[Clasify.motor, ]
Clasify.identifiers <- as.character(Clasify.motor$Clasify)
Sumry$Clasify <- as.character(Sumry$Clasify)
Sumry.motor <- Sumry[Sumry$Clasify %in% Clasify.identifiers, ]
Sumry.motor.24510 <- Sumry.motor[which(Sumry.motor$fips == "24510"), ]
aggregate.motor.24510 <- with(Sumry.motor.24510, aggregate(Emissions, by = list(year),     sum))


Clasify.motor <- grep("motor", Clasify$Short.Name, ignore.case = TRUE)
Clasify.motor <- Clasify[Clasify.motor, ]
Clasify.identifiers <- as.character(Clasify.motor$Clasify)


Sumry$Clasify <- as.character(Sumry$Clasify)
Sumry.motor <- Sumry[Sumry$Clasify %in% Clasify.identifiers, ]

Sumry.motor.24510 <- Sumry.motor[which(Sumry.motor$fips == "24510"), ]
Sumry.motor.06037 <- Sumry.motor[which(Sumry.motor$fips == "06037"), ]

aggregate.motor.24510 <- with(Sumry.motor.24510, aggregate(Emissions, by = list(year),     sum))
aggregate.motor.24510$group <- rep("Baltimore County", length(aggregate.motor.24510[,     1]))


aggregate.motor.06037 <- with(Sumry.motor.06037, aggregate(Emissions, by = list(year),     sum))
aggregate.motor.06037$group <- rep("Los Angeles County", length(aggregate.motor.06037[,     1]))

aggregated.motor.zips <- rbind(aggregate.motor.06037, aggregate.motor.24510)
aggregated.motor.zips$group <- as.factor(aggregated.motor.zips$group)

colnames(aggregated.motor.zips) <- c("Year", "Emissions", "Group")

qplot(Year, Emissions, data = aggregated.motor.zips, group = Group, color = Group, 
    geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Comparison of Total Emissions by County")