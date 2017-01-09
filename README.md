# Exploratory-Data-Analysis-Project

This repository consists of the R scripts and corresponding plot graphics for (Coursera) Exploratory Data Analysis' second peer reviewed assignment.

## Overview

This project is an attempt to perform exploratory data analysis on the National Emissions database maintained by the EPA. The R scripts attempt to answer the following questions about the data:

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

The datasets were obtained from [this link](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip).

## Notes for using the repository

The envSetup.R script downloads the dataset, unzips and stores it in a subdirectory called data in your working directory. This script is used as a helper script by each of the plotting scripts. So, after cloning the repository or downloading the source files directly, simply source the plotting scripts and the corresponding plot graphics will be generated in the current directory as *.png* files.

