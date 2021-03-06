data <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=F, na.strings=c("?"))
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
b <- data$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02"))
data <- data[b,]
tonum <- function(v) { 
	sapply(v, function(p) {
		as.numeric(as.character(p)) 
	}) 
}

data$Time <- strptime(paste(as.character(data$Date), data$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")
data$Sub_metering_1 <- tonum(data$Sub_metering_1)
data$Sub_metering_2 <- tonum(data$Sub_metering_2)
data$Sub_metering_3 <- tonum(data$Sub_metering_3)
data$Global_active_power <- tonum(data$Global_active_power)
data$Global_reactive_power <- tonum(data$Global_reactive_power)
data$Voltage <- tonum(data$Voltage)

quartz()
par(mfrow=c(2,2))

with(data, {
	plot(data$Time, data$Global_active_power,type="l", ylab="Global Active Power", xlab="")
	
	plot(data$Time, data$Voltage,type="l", ylab="Voltage", xlab="datetime")
	
	plot(data$Time, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
	lines(data$Time, data$Sub_metering_1, col="black")
	lines(data$Time, data$Sub_metering_2, col="red")
	lines(data$Time, data$Sub_metering_3, col="blue")
	legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("black", "red", "blue"))
	
	plot(data$Time, data$Global_reactive_power,type="l", ylab="Global_reactive_power", xlab="datetime")
})

dev.copy(device=png, filename="plot4.png", width=480, height=480)
dev.off()