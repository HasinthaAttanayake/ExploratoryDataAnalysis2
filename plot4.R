#load plyr and ggplot2 packages
library(plyr)
library(ggplot2)
data <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
codes <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

#extract coal related observation SCC(s)
coalcode <- codes[grep("coal",codes$Short.Name, ignore.case = TRUE),]
coalcode_identity <- as.character(coalcode$SCC)
data$SCC <- as.character(data$SCC)
coaldata <- data[data$SCC %in% coalcode_identity,]

#find aggregate per year for all coal sources 
aggregatecoaldata <- with(coaldata,aggregate(coaldata$Emissions, by=list(year),FUN = sum,na.rm=TRUE))

#plot in PNG graphics device 
png("plot4.png")
qplot(aggregatecoaldata[,1],aggregatecoaldata[,2],geom = c("point","line"),main = "Total Emissions PM2.5 from US Coal Sources", xlab = "Year", ylab = "PM2.5 Emission in Tonnes")
dev.off()
