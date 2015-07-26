#load plyr and ggplot2 packages
library(plyr)
library(ggplot2)
data <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
codes <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
#aggregate data for total emmisions for baltimore fips == 24510
balt <- data[data$fips == 24510,]
#turn type into factor in order to catergorise dataset by type. 
aggregate_balt <- with(balt,aggregate(balt$Emissions, by=list(year,type),FUN = sum,na.rm=TRUE))
aggregate_balt[,2] <- as.character(aggregate_balt[,2])
Pollutant_type <- aggregate_balt[,2]
#plot in PNG graphics device 
png(filename = "plot3.png")
qplot(aggregate_balt[,1],aggregate_balt[,3],group = Pollutant_type, color=Pollutant_type,geom = c("point","line"), ylab = "Total Emissions, PM[2.5]", xlab = "Year", main = "Total Emissions in Baltimore City by Type of Pollutant")
dev.off()
