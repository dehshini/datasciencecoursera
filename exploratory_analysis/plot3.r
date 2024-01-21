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

#plot the data
plot(
    data1$Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power (kilowatts)"
)