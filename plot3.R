library(lubridate)
library(dplyr)

# read the table from file 
data <- read.table("./household_power_consumption.txt", header = TRUE, 
                   sep = ";", stringsAsFactors = FALSE)

# change time and numeric format, filter the days:
data <- data %>% mutate(datetime = dmy_hms(paste(Date, Time)))
data <- data %>% filter(datetime >= ymd("2007-02-01"), datetime < ymd("2007-02-03"))
data[,3:9] <- sapply(data[,3:9], as.numeric)

# make png file of the plot
png("plot3.png", width = 480, height = 480, units = "px")
with(data, plot(Sub_metering_1 ~ datetime, type = "n",
                ylab = "Energy submetering", xlab = NA))
lines(data$datetime, data$Sub_metering_1, col = "black")
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
