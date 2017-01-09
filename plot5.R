###############################################################################

## Coursera - Exploratory Data Analysis Course
## Author - Abhimanyu Banerjee
## Date Created - 1/5/2017

## File Description: This script attempts to answer the question how the emission
## levels in Baltimore City, specifically have changed from 1999 to 2008. It does 
## so by summating the emission levels recorded at various monitors in Baltimore
## City over the period 1999-2008 for each of the years the observations were 
## made. The result of the summation is then plotted to visualize any trends 
## which can answer the question.

###############################################################################

#set up data dir and other basic variables if they don't exist already
if (!exists("summaryData")){
    if(file.exists("envSetup.R")){
        source("envSetup.R")
    }
    else{
        stop("envSetup.R is a dependent file. Please download it to run this file")
    }
}

#using ggplot2
library(ggplot2)

#using the EI.Sector variable to decide if the source is motor vehicle related
#and then subset the source description dataset based on this criteria
vehicleRows <- with(sourceDescrData, grep("[Vv]ehicles", EI.Sector))
dataSubset <- sourceDescrData[vehicleRows, ]

#perform an inner join between the summary data and the data subset computed above
mergedData <- inner_join(summaryData, dataSubset, by="SCC")

#filter the resulting dataset for records corresponding to Baltimore City, group
#the result by year, then calculate the total emission in each group and finally 
#plot the results
annualEmissions <- mergedData %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarize(emissions = sum(Emissions))


#open a png graphic device (default dimension are 480x480)
png("plot5.png")

plot <- qplot(year, emissions, geom="point", data=annualEmissions, 
              xlab="Years", ylab="Total PM2.5 Emission (Tonnes)", 
              main="Annual Baltimore City PM2.5 Emission from Coal Combustion Sources") 
plot <- plot + geom_line()

#sourcing R scripts have autoprinting disabled, so have to print the plot manually
print(plot) 

#close the png graphic device
dev.off()
