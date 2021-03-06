
# Source of data for this project: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Dataset: Electric power consumption [20Mb]

# This R script does the following:

# 1.  Load the data into R.
# 2.  Filter the data for the dates 2007-02-01 and 2007-02-02.
# 3.  Load Date in format dd/mm/yyyy, and Time in format hh:mm:ss.
# 4.  Ensure missing values are coded as ?.
# 5.  Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

# Target Plot is https://github.com/johnpineda4/ExData_Plotting1/blob/master/figure/unnamed-chunk-5.png.

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

# Plot 4
par(mfrow = c(2,2))
with(householdpowerconsumption, plot(datetime,Global_active_power, type="l", pch=NA_integer_, lty="solid", xlab="", ylab="Global Active Power (kilowatts)"))
with(householdpowerconsumption, plot(datetime,Voltage, type="l", pch=NA_integer_, lty="solid", ylab="Voltage"))
with(householdpowerconsumption, plot(datetime,Sub_metering_1, type="n", xlab="", ylab="Energy Sub metering"))
with(householdpowerconsumption, lines(datetime,Sub_metering_1, type="l", col= "black", pch=NA_integer_, lty="solid", xlab="", ylab=""))
with(householdpowerconsumption, lines(datetime,Sub_metering_2, type="l", col= "red", pch=NA_integer_, lty="solid", xlab="", ylab=""))
with(householdpowerconsumption, lines(datetime,Sub_metering_3, type="l", col= "blue", pch=NA_integer_, lty="solid", xlab="", ylab=""))
legend("topright", pch=NA_integer_, lty="solid", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n", adj=0.4, x.intersp = 6,y.intersp = 1.2)
with(householdpowerconsumption, plot(datetime,Global_reactive_power, type="l", pch=NA_integer_, lty="solid"))
dev.copy(png, file="plot4.png")
dev.off()
