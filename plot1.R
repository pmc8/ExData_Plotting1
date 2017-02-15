library(lubridate)
library(dplyr)

# read the table from file 

data <- read.table("./household_power_consumption.txt", header = TRUE, 
                    sep = ";", stringsAsFactors = FALSE)

data <- data %>% mutate(datetime = dmy_hms(paste(Date, Time)))
data <- data %>% filter(datetime >= ymd("2007-02-01"), datetime < ymd("2007-02-03"))


data[,3:9] <- sapply(data[,3:9], as.numeric)

png("plot1.png", width = 480, height = 480, units = "px")
with(data, hist(Global_active_power, 
                col = "red", 
                xlab = "Global Active Power (kilowatts)", 
                main = "Global Active Power"))
dev.off()
