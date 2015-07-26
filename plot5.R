#load plyr and ggplot2 packages
library(plyr)
library(ggplot2)
data <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
codes <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
#aggregate data for total emmisions for baltimore fips == 24510 and motor vehicle sources i.e type == Onroad
balt <- data[data$fips == 24510,]
balt$type <- as.character(balt$type)
baltonroad <- balt[balt$type == "ON-ROAD",]
aggbaltonroad <- with(baltonroad, aggregate(baltonroad$Emissions, by=list(year),FUN =sum, na.rm=TRUE))
#plot in png graphics device
png(filename = "plot5.png")
qplot(aggbaltonroad[,1],aggbaltonroad[,2],geom = c("point","line"),main="PM2.5 total Emissions from motorvehicle sources Baltimore City", xlab = "year", ylab = "Motor Vehicle PM2.5 Emissions in Tonnes")
dev.off()
