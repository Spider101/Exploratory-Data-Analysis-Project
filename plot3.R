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

#group the summary data by year and then calculate the total emmission in each
#year and then plot the results
annualEmissions <- summaryData %>%
    filter(fips == "24510") %>%
    mutate(type=as.factor(type)) %>%
    group_by(type, year) %>%
    summarize(emissions = sum(Emissions))

#open a png graphic device (default dimension are 480x480)
png("plot3.png")

#with(annualEmissions, plot(year, emissions))
plot <- qplot(year, emissions, color=type, data=annualEmissions, geom="point",
              xlab="Years", ylab="Total PM2.5 Emission (Tonnes)", 
              main="Annual PM2.5 Emission in Baltimore City") 
plot <- plot + geom_smooth(method="lm", se = F)
print(plot)

#close the png graphic device
dev.off()
