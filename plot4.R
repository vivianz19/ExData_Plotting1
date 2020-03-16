#Reading in data from text file to R
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

#Converting date and time columns to relevant Date and Time formats
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")
data$Time <- format(data$Time, "%H:%M:%S")
data$Date_Time <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

#Setting date conditions to filter the data (dates need to be between 2007-02-01 and 2007-02-02)
datecondition1 <- data$Date >= as.Date("2007-02-01", format = "%Y-%m-%d")
datecondition2 <- data$Date <= as.Date("2007-02-02", format = "%Y-%m-%d")

#Filtering the data for the correct dates and excluding missing data
filtered_data <- data[datecondition1 & datecondition2, ]
filtered_data2 <- filtered_data[!(as.character(filtered_data$Global_active_power) == "?"), ]

#Opening a png file
png("plot4.png", width = 480, height = 480)

#Plotting four different graphs of Global Active Power against datetime, Voltage against datetime, various submetering against datetime and global reactive power against datetime.
#Note: 'Global active power' column is converted to numeric in order to plot the histogram

#Setting global parameter so plot of 2 x 2 can be displayed
par(mfrow = c(2,2))
#Plot 1 - Global active power vs datetime
plot(filtered_data2$Date_Time, as.numeric(filtered_data2$Global_active_power), xlab = "", ylab = "Global Active Power", type = "l", col = "black")

#Plot 2 - voltage vs datetime
plot(filtered_data2$Date_Time, as.numeric(filtered_data2$Voltage), xlab = "datetime", ylab = "Voltage", col = "black", type = "l")

#Plot 3 - Energy sub metering vs datetime
plot(filtered_data2$Date_Time, as.numeric(filtered_data2$Sub_metering_1), xlab = "", ylab = "Energy sub metering", type = "l", col = "black")
lines(filtered_data2$Date_Time, as.numeric(filtered_data2$Sub_metering_2), col = "red", type = "l")
lines(filtered_data2$Date_Time, as.numeric(filtered_data2$Sub_metering_3), col = "blue", type = "l")
legend("topright", lty = 1, bty = 'n', col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Plot 4 - Global reactive power vs datetime
plot(filtered_data2$Date_Time, as.numeric(filtered_data2$Global_reactive_power), xlab = "datetime", ylab = "Global_reactive_power", type = "l")

#Closing device
dev.off()