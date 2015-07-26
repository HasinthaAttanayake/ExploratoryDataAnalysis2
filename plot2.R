#load(plyr)
library(plyr)
data <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
codes <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
#aggregate data for total emmisions for baltimore fips == 24510
balt <- data[data$fips == 24510,]
aggregate_balt <- with(balt,aggregate(balt$Emissions, by=list(year),FUN = sum,na.rm=TRUE))
aggregate_balt <- as.matrix(aggregate_balt)
#barplot in PNG graphics device
png(filename = "plot2.png")
barplot(aggregate_balt[,2],names.arg = aggregate_balt[,1],main='total emissions of PM2.5 for Baltimore',xlab='year',ylab='total emissions per annum in tonnes')
dev.off()
