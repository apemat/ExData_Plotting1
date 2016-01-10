# Read dataset and change data types
dataset <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
dataset$newTime <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

# Filtering to get only '01/02/2007' and '02/02/2007' data and change the necessary datatype
fb0102 <- dataset[dataset$Date %in% c(as.Date('01/02/2007', '%d/%m/%Y'), as.Date('02/02/2007', '%d/%m/%Y')), ]
fb0102$Global_active_power <- as.numeric(as.character(sub("," , ".", fb0102$Global_active_power)))
fb0102$Voltage <- as.numeric(as.character(sub("," , ".", fb0102$Voltage)))
fb0102$Sub_metering_1 <- as.numeric(as.character(sub("," , ".", fb0102$Sub_metering_1)))
fb0102$Sub_metering_2 <- as.numeric(as.character(sub("," , ".", fb0102$Sub_metering_2)))
fb0102$Sub_metering_3 <- as.numeric(as.character(sub("," , ".", fb0102$Sub_metering_3)))
fb0102$Global_reactive_power <- as.numeric(as.character(sub("," , ".", fb0102$Global_reactive_power)))

# Create PNG device and draw the graphic
png("plot4.png", height = 480, width = 480)
par(mfrow = c(2,2))
with(fb0102, plot(newTime, Global_active_power,type="l", ylab = "Global Active Power", xlab = ""))
with(fb0102, plot(newTime, Voltage,type="l", ylab = "Voltage", xlab = "datetime"))

with(fb0102, plot(newTime, Sub_metering_1,type="l", ylab = "Energy Sub metering", xlab = "", col= "black"))
with(fb0102, lines(newTime, Sub_metering_2, col = "red"))
with(fb0102, lines(newTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(fb0102, plot(newTime, Global_reactive_power,type="l", ylab = "Global_reactive_power", xlab = "datetime"))

dev.off()
