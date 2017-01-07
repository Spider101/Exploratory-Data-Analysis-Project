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
vehicleRows <- with(sourceDescrData, grep("[Vv]ehicles", EI.Sector))
dataSubset <- sourceDescrData[vehicleRows, ]

mergedData <- inner_join(summaryData, dataSubset, by="SCC")

#group the resulting data by year and then calculate the total emmission in each
#year and then plot the results
annualEmissions <- mergedData %>%
    filter(fips == "24510" | fips == "06037") %>%
    group_by(fips, year) %>%
    summarize(emissions = sum(Emissions)) %>%
    mutate(county = ifelse(fips == "06037", "Los Angeles", "Baltimore"))


#open a png graphic device (default dimension are 480x480)
png("plot6.png")

#with(annualEmissions, plot(year, emissions))
plot <- qplot(year, emissions, color=county, geom="point", data=annualEmissions, 
              xlab="Years", ylab="Total PM2.5 Emission (Tonnes)", 
              main="Annual Motor Vehicle PM2.5 Emission") + geom_line()
print(plot)

#close the png graphic device
dev.off()
