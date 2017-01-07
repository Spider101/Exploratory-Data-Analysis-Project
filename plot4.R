###############################################################################

## Coursera - Exploratory Data Analysis Course
## Author - Abhimanyu Banerjee
## Date Created - 1/5/2017

## File Description: 

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

mergedData <- inner_join(summaryData, dataSubset, by="SCC")

#group the resulting data by year and then calculate the total emmission in each
#year and then plot the results
annualEmissions <- mergedData %>%
    group_by(year) %>%
    summarize(emissions = sum(Emissions)) %>%
    mutate(emissions = emissions / 10^6)


#open a png graphic device (default dimension are 480x480)
png("plot4.png")

#with(annualEmissions, plot(year, emissions))
plot <- qplot(year, emissions, geom="point", data=annualEmissions, 
              xlab="Years", ylab="Total PM2.5 Emission (Megatonnes)", 
              main="Annual US PM2.5 Emission from Coal Combustion Sources") + geom_line()
print(plot)

#close the png graphic device
dev.off()
