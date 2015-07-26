#load(plyr)
library(plyr)
data <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
codes <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
#find aggregate by year and by sum all emmissions per year. 
aggregate_data <- with(data,aggregate(Emissions, by=list(year),FUN = sum,na.rm=TRUE))
aggregate_data <- as.matrix(aggregate_data)
#barplot in png graphics device 
png(filename = "plot1.png")
barplot(aggregate_data[,2], names.arg=aggregate_data[,1],main='total emissions of PM2.5',xlab='year',ylab='total emissions per annum in tonnes')
dev.off()
