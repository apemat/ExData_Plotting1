# Read dataset and change data types
dataset <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
dataset$newTime <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

# Filtering to get only '01/02/2007' and '02/02/2007' data and change the necessary datatype
fb0102 <- dataset[dataset$Date %in% c(as.Date('01/02/2007', '%d/%m/%Y'), as.Date('02/02/2007', '%d/%m/%Y')), ]
fb0102$Global_active_power <- as.numeric(as.character(sub("," , ".", fb0102$Global_active_power)))

# Create PNG device and draw the graphic
png("plot2.png", height = 480, width = 480)
with(fb0102, plot(newTime, Global_active_power,type="l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
