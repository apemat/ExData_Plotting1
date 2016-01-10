# Read dataset and change data type to Date
dataset <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

# Filtering to get only '01/02/2007' and '02/02/2007' data
fb0102 <- dataset[dataset$Date %in% c(as.Date('01/02/2007', '%d/%m/%Y'), as.Date('02/02/2007', '%d/%m/%Y')), ]
fb0102$Global_active_power <- as.numeric(as.character(sub("," , ".", fb0102$Global_active_power)))

# Create PNG device and draw the graphic
png("plot1.png", height = 480, width = 480)
hist(fb0102$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
