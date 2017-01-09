###############################################################################

## Coursera - Exploratory Data Analysis Course
## Author - Abhimanyu Banerjee
## Date Created - 1/5/2017

## File Description: This script attempts to answer the question if the emission
## levels in Baltimore City, specifically, have decreased from 1999 to 2008. It 
## does so by summating the emission levels recorded at various monitors in 
## Baltimore City over the period 1999-2008 for each of the years the observations 
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

#open a png graphic device (default dimension are 480x480)
png("plot2.png")

#filter the summary data for records corresponding to Baltimore City, then group
#the results by year and calculate the total emission in each group, and finally 
#plot the results
annualEmissions <- summaryData %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarize(emissions = sum(Emissions))



with(annualEmissions, plot(year, emissions, xlab = "Years", 
                           ylab="Total PM2.5 Emission (Tonnes)", 
                           main="Annual PM2.5 Emmission in Baltimore, Maryland", 
                           type="l", col="purple"))
with(annualEmissions, points(year, emissions, pch=19, col="purple"))

#close the png graphic device
dev.off()

