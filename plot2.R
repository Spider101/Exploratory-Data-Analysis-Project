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

#open a png graphic device (default dimension are 480x480)
png("plot2.png")

#group the summary data by year and then calculate the total emmission in each
#year and then plot the results
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

