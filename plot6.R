###############################################################################

## Coursera - Exploratory Data Analysis Course
## Author - Abhimanyu Banerjee
## Date Created - 1/5/2017

## File Description: This script attempts to compare the emission levels in 
## Baltimore City against the levels in Los Angeles County from 1999 to 2008. It 
## does so by summating the emission levels recorded at various monitors for Los
## Angeles County and for Baltimore City over the period 1999-2008 for each of 
## the years that the observations were made. The result of the summation is 
## then plotted to visualize any trends which can answer the question.

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

#filter the resulting dataset for records corresponding to either Baltimore City
#or Los Angeles County, group the result by year, then calculate the total 
#emission in each group and finally plot the results
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
              main="Annual Motor Vehicle PM2.5 Emission") 
plot<- plot + geom_line() + geom_smooth(linetype="dotted", method="lm", se=F)

#sourcing R scripts have autoprinting disabled, so have to print the plot manually
print(plot) 


#close the png graphic device
dev.off()
