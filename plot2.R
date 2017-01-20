# This file creates the second plot for the Coursera Exploratory Data Analysis Week 1 course.
# It uses the "Individual household electric power consumption Data Set" from the UC Irvine Machine Learning Repository

# This .R file obtains and unzips the data if it's not present in the working directory
# Formats the date and time fields to native date data types
# Extracts a subset of the data for the first two days in February 2007
# And writes a plot of the global active power values against time to a png file
# Finally it displays the same plot to the screen

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
png(filename = "./plot2.png", width = 480, height = 480, units = "px")
# draw the plot using lines and label the y axis
with(feb.power.data, plot(Time, Global_active_power, type="l", 
                          xlab = "", ylab = "Global Active Power (kilowatts)"))
# close the device
dev.off()
# display the same plot to the screen to feedback to the user
with(feb.power.data, plot(Time, Global_active_power, type="l", 
                          xlab = "", ylab = "Global Active Power (kilowatts)"))
