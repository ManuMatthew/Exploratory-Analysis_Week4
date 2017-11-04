##Libraries
library(lattice)
library(plyr)

##Set work directory and load Data
Sumry <- readRDS("summaryClassif_PM25.rds")
Classif <- readRDS("Source_Classification_Code.rds")

Classif.coal <- grep("coal", Classif$Short.Name, ignore.case = TRUE)
Classif.coal <- Classif[Classif.coal, ]
Classif.identifiers <- as.character(Classif.coal$Classif)

Sumry$Classif <- as.character(Sumry$Classif)
Sumry.coal <- Sumry[Sumry$Classif %in% Classif.identifiers, ]

aggregate.coal <- with(Sumry.coal, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.coal) <- c("year", "Emissions")

##Plot
plot(aggregate.coal, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", 
    xlim = c(1999, 2008))
	
polygon(aggregate.coal, col = "blue", border = "blue")