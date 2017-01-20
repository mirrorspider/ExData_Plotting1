# This file creates the fourth set of plots for the Coursera Exploratory Data Analysis Week 1 course.
# It uses the "Individual household electric power consumption Data Set" from the UC Irvine Machine Learning Repository

# This .R file obtains and unzips the data if it's not present in the working directory
# Formats the date and time fields to native date data types
# Extracts a subset of the data for the first two days in February 2007
# And writes a 4 plots summarising the data to a png file
# Finally it displays the same plots to the screen

data.file <- "./household_power_consumption.txt"
# check for the existence of the data file
if(!file.exists(data.file)){
        data.zip.file <- "./power_consumption.zip"
        # check for the existence of the zip file
        if(!file.exists(data.zip.file)){
                # if the file doesn't exist, download it
                data.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(data.url, "./power_consumption.zip")
        }
        # once the zip file is downloaded, unzip it
        unzip("./power_consumption.zip")
}
# read the data into a data frame. The data is semi-colon separated and uses ? for missing values
power.data <- read.table(data.file, header = TRUE, sep = ";", na.strings = "?")
# Turn the time value into a POSIXlt data type
power.data$Time <- strptime(paste(power.data$Date, power.data$Time), format = "%d/%m/%Y %H:%M:%S")
# Turn the date value into a POSIXlt data type
power.data$Date <- as.Date(power.data$Date, format = "%d/%m/%Y")
# create a subset of the data covering 1st February 2007 - 2nd February 2007
feb.power.data <- power.data[power.data$Date == "2007-02-01" | power.data$Date == "2007-02-02",]
# Open a png device to write a png file
png(filename = "./plot4.png", width = 480, height = 480, units = "px")
# create a 2x2 canvas for the plots with reduced margins
par(mfrow = c(2,2), mar = c(4,4,1,2))
# create the four plots
# plot 1 - Time ~ Global_active_power
with(feb.power.data, plot(Time, Global_active_power, type="l", 
                          xlab = "", ylab = "Global Active Power (kilowatts)"))
# plot 2 - Time ~ Voltage
with(feb.power.data, plot(Time, Voltage, type="l", 
                          xlab = "datetime", ylab = "Voltage"))
# plot 3 - Time ~ sub metering
with(feb.power.data, plot(Time, Sub_metering_1, type="l", col = "black", ylab = "Energy sub metering", xlab = ""))
with(feb.power.data, lines(Time, Sub_metering_2, col = "red"))
with(feb.power.data, lines(Time, Sub_metering_3, col = "blue"))
# add a legend in the top right hand corner
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = "1", bty = "n")
# plot 4 - Time ~ Global_reactive_power
with(feb.power.data, plot(Time, Global_reactive_power, type="l", 
                          xlab = "datetime", ylab = "Global_reactive_power"))
# close the device
dev.off()
# recreate the same plots to the screen to feedback to the user
# set up canvas
par(mfrow = c(2,2), mar = c(4,4,1,2))
# plot 1
with(feb.power.data, plot(Time, Global_active_power, type="l", 
                          xlab = "", ylab = "Global Active Power (kilowatts)"))
# plot 2
with(feb.power.data, plot(Time, Voltage, type="l", 
                          xlab = "datetime", ylab = "Voltage"))
# plot 3
with(feb.power.data, plot(Time, Sub_metering_1, type="l", col = "black", ylab = "Energy sub metering", xlab = ""))
with(feb.power.data, lines(Time, Sub_metering_2, col = "red"))
with(feb.power.data, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = "1", bty = "n")
#plot 4
with(feb.power.data, plot(Time, Global_reactive_power, type="l", 
                          xlab = "datetime", ylab = "Global_reactive_power"))
