# set working directory to location of "household_power_consumption.txt" input file
setwd("/Users/jason/Downloads")

library(dplyr)
library(lubridate)

data = read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE)

small_data = data %>% mutate(Date = lubridate::dmy(Date)) %>%
  mutate(Time = lubridate::hms(Time)) %>%
  mutate(FullDate = Date + Time) %>%
  mutate(Global_active_power = as.numeric(Global_active_power)) %>%
  filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

png("plot4.png", width = 480, height=480, units="px")

par(mfrow=c(2,2))

with(small_data, plot(small_data$FullDate, small_data$Global_active_power,
                      typ="l",
                      ylab="Global Active Power",
                      xlab="",
                      col="black"))

plot(small_data$FullDate, small_data$Voltage, typ="l", ylab="Voltage", xlab="datetime")



with(small_data, plot(FullDate, Sub_metering_1, type = "n", ylab="Energy sub metering", xlab=""))
  lines(small_data$FullDate, small_data$Sub_metering_1, col="black")
  lines(small_data$FullDate, small_data$Sub_metering_2, col="red")
  lines(small_data$FullDate, small_data$Sub_metering_3, col="blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))

plot(small_data$FullDate, small_data$Global_reactive_power, typ="l", ylab="Global_reactive_power", xlab="datetime")

dev.off()
