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
png("plot2.png", width = 480, height = 480, units = "px")
with(data, plot(Global_active_power ~ datetime, 
                ylab = "Global active power (kilowatts)", 
                xlab = NA,  type = "l"))
dev.off()
