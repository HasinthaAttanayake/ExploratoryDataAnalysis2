#load plyr and ggplot2 packages
library(plyr)
library(ggplot2)
data <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
codes <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
#aggregate data for total emmisions for baltimore fips == 24510 and motor vehicle sources i.e type == ON-ROAD
balt <- data[data$fips == 24510,]
balt$type <- as.character(balt$type)
baltonroad <- balt[balt$type == "ON-ROAD",]
aggbaltonroad <- with(baltonroad, aggregate(baltonroad$Emissions, by=list(year),FUN =sum, na.rm=TRUE))
aggbaltonroad$Group <- "Baltimore County Motor Vehicles"

#aggregate data for total emmisions for LA county fips == 06037 and motor vehicle sources i.e type == ON-ROAD
lacmot <- data[data$fips == '06037' & data$type == 'ON-ROAD',]
agglacmot <- with(lacmot, aggregate(lacmot$Emissions, by=list(year),FUN=sum, na.rm = TRUE))
agglacmot$Group <- "LA County Motor Vehicles"

#merge data 
baltlac <- rbind(aggbaltonroad,agglacmot)

#plot in png graphics device 
png("plot6.png")
qplot(baltlac[,1],baltlac[,2], geom = c("line","point"), color = baltlac[,3],group = baltlac[,3],main="PM2.5 total Emissions from motorvehicle sources", xlab = "year", ylab = "Motor Vehicle PM2.5 Emissions in Tonnes")
dev.off()
