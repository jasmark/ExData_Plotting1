
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

png("plot2.png", width = 480, height=480, units="px")

with(small_data, plot(small_data$FullDate, small_data$Global_active_power,
                      typ="l",
                      ylab="Global Active Power (kilowatts)",
                      xlab="",
                      col="black"))

dev.off()

