#Reading in data from text file to R
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

#Converting date and time columns to relevant Date and Time formats
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")

#Setting date conditions to filter the data (dates need to be between 2007-02-01 and 2007-02-02)
datecondition1 <- data$Date >= as.Date("2007-02-01", format = "%Y-%m-%d")
datecondition2 <- data$Date <= as.Date("2007-02-02", format = "%Y-%m-%d")

#Filtering the data for the correct dates and excluding missing data
filtered_data <- data[datecondition1 & datecondition2, ]
filtered_data2 <- filtered_data[!(as.character(filtered_data$Global_active_power) == "?"), ]

#Opening a png file
png("plot1.png", width = 480, height = 480)

#Creating a histogram of Global Active Power in kilowatts
#Note: 'Global active power' column is converted to numeric in order to plot the histogram
hist(as.numeric(filtered_data2$Global_active_power), main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

#Closing device
dev.off()