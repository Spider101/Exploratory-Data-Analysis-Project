###############################################################################

## Coursera - Exploratory Data Analysis Course
## Author - Abhimanyu Banerjee
## Date Created - 1/5/2017

## File Description: This script attempts to answer the question how the emission
## levels in USA from coal combustion related sources have changed from 1999 to 
## 2008. It does so by first finding the records which correspond to coal 
## combustion related sources and then summating the associated emission levels 
## recorded over the period 1999-2008 for each of the years that the observations 
## were made. The result of the summation is then plotted to visualize any trends 
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

#since there are two indicators - Short.Name and EI.Sector for whether the 
#source is coal combustion related, there maybe entries in one that 
#are not present in the other and vice versa. So we do a union of the records
#wherein an entry in either indicator variable suggests the source is coal
#combustion related
coalOneRows <- with(sourceDescrData, grep("Comb.*Coal", EI.Sector))
coalTwoRows <- with(sourceDescrData, grep("Comb.*Coal", Short.Name))
dataSubset <- sourceDescrData[union(coalOneRows, coalTwoRows), ]

#perform an inner join between the summary data and the data subset computed above
mergedData <- inner_join(summaryData, dataSubset, by="SCC")

#group the resulting data by year and then calculate the total emission in each
#group and then plot the results
annualEmissions <- mergedData %>%
    group_by(year) %>%
    summarize(emissions = sum(Emissions)) %>%
    mutate(emissions = emissions / 10^6)


#open a png graphic device (default dimension are 480x480)
png("plot4.png")

plot <- qplot(year, emissions, geom="point", data=annualEmissions, 
              xlab="Years", ylab="Total PM2.5 Emission (Megatonnes)", 
              main="Annual US PM2.5 Emission from Coal Combustion Sources") + geom_line()

#sourcing R scripts have autoprinting disabled, so have to print the plot manually
print(plot) 

#close the png graphic device
dev.off()
