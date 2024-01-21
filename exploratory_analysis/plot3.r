library(tidyverse)

#download the zip file
# download.file(
    # "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
    #destfile = "./exploratory_analysis/household_power_consumption.zip"
)

#unzip the file
# unzip("household_power_consumption.zip")

#read the data
data <- read.table(
    "./datasets/household_power_consumption.txt",
    sep = ";",
    header = TRUE,
    na.strings = "?"
)

#change the date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# filter the data
data1 <- data %>%
    filter(
        Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")
    )

datetime <- paste(as.Date(data1$Date), data1$Time)
data1$Datetime <- as.POSIXct(datetime)

#plot the data
with(data1, {
    plot(
        Sub_metering_1 ~ Datetime,
        type = "l",
        ylab = "Energy sub metering",
        xlab = ""
        )
    lines(Sub_metering_2 ~ Datetime, col = "Red")
    lines(Sub_metering_3 ~ Datetime, col = "Blue")
    }
)

legend(
    "topright",
    col = c("black", "red", "blue"),
    lty = 1,
    lwd = 2,
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

dev.print(png, file = "./exploratory_analysis/plot3.png", width = 480, height = 480)
