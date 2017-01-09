###############################################################################

## Coursera - Exploratory Data Analysis Course
## Author - Abhimanyu Banerjee
## Date Created - 1/5/2017

## File Description: This script attempts to answer the question if the emission
## levels for any of the four emission sources have decreased from 1999 to 2008. 
## It does so by summating the emission levels recorded at various monitors over
## the period 1999-2008 for each of the years the observations were made. The 
## result of the summation is then plotted, with the data points belonging to 
## each source type in a different color inorder to visualize any trends which 
## can answer the question.

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

#filter the summary data for records corresponding to Baltimore City, group the 
#results by type and year (ties broken by year), then calculate the total 
#emission in each group and finally plot the results
annualEmissions <- summaryData %>%
    filter(fips == "24510") %>%
    mutate(type=as.factor(type)) %>%
    group_by(type, year) %>%
    summarize(emissions = sum(Emissions))

#open a png graphic device (default dimension are 480x480)
png("plot3.png")

plot <- qplot(year, emissions, color=type, data=annualEmissions, geom="point",
              xlab="Years", ylab="Total PM2.5 Emission (Tonnes)", 
              main="Annual PM2.5 Emission in Baltimore City") 
plot <- plot + geom_smooth(method="lm", se = F)

#sourcing R scripts have autoprinting disabled, so have to print the plot manually
print(plot) 

#close the png graphic device
dev.off()
