###############################################################################

## Coursera - Exploratory Data Analysis Course
## Author - Abhimanyu Banerjee
## Date Created - 1/5/2017

## File Description: This is a script that sets up the environment for the other
## plotting scripts. It checks if the data directory exists, if not it creates
## the directory, downloads the EPA PM2.5 dataset and unzips
## it.

###############################################################################

## Setup

#clean the workspace
rm(list = ls())

#using data.table_1.10.0 and dplyr_0.5.0
require("data.table")
require("dplyr")

dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataZipPath <- "./data/epa_pm_data.zip"

#create data directory if it doesn't already exist
if(!file.exists("data")){
    dir.create("data")    
    download.file(dataUrl, dataZipPath)
    unzip(dataZipPath, exdir = "./data")
}

match <- grep(".rds", dir("./data"))
if(length(match) == 0){
    stop(paste("Error: Something went wrong with unzipping the dataset!",
       "Please delete the data directory created by this script and try again"))
}

dataPath <- dir("./data", full.names = T)[match]   

#summaryData <- readRDS(dataPath[1])
#sourceDescrData <- readRDS(dataPath[2])