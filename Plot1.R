
# Source of data for this project: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Dataset: Electric power consumption [20Mb]

# This R script does the following:

# 1.  Load the data into R.
# 2.  Filter the data for the dates 2007-02-01 and 2007-02-02.
# 3.  Load Date in format dd/mm/yyyy, and Time in format hh:mm:ss.
# 4.  Ensure missing values are coded as ?.
# 5.  Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

# Target Plot is https://github.com/johnpineda4/ExData_Plotting1/blob/master/figure/unnamed-chunk-2.png.

# Set Working Directory
setwd("~/Library/Mobile Documents/com~apple~CloudDocs/Coursera")

# Download and load the data: Electric power consumption
install.packages("data.table")
library(data.table)
install.packages("dplyr")
library(dplyr)
install.packages("stringr")
library(stringr)
install.packages("lubridate")
library(lubridate)

if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/PowerDataset.zip")

# Unzip zipfile to /data directory
unzip(zipfile="./data/PowerDataset.zip",exdir="./data")

# Read Electric power consumption data
householdpowerconsumption <- read.table("./data/household_power_consumption.txt", header =TRUE, sep=";", na.strings="?", stringsAsFactors= FALSE)

householdpowerconsumption$datefield <- as.Date(householdpowerconsumption$Date,"%d/%m/%Y")
householdpowerconsumption$timefield <- strptime(householdpowerconsumption$Time,"%H:%M:%S")


# Filter the data for the dates 2007-02-01 and 2007-02-02.
householdpowerconsumption <- householdpowerconsumption[householdpowerconsumption$datefield >= as.Date("2007-02-01") &  householdpowerconsumption$datefield <= as.Date("2007-02-02"), ]
householdpowerconsumption$datetime <- dmy_hms(str_c(householdpowerconsumption$Date," ",householdpowerconsumption$Time))

# # Plot 1
hist(householdpowerconsumption$Global_active_power, col= "red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()
