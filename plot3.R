data <- read.csv("household_power_consumption.txt", sep=";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
b <- data$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02"))
data <- data[b,]
fromfactors <- function(v) { 
	sapply(v, function(p) {
		if (p == "?") { 
			NA 
		} else { 
			as.numeric(as.character(p)) 
		}
	}) 
}

data$Time <- strptime(paste(as.character(data$Date), data$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")
data$Sub_metering_1 <- fromfactors(data$Sub_metering_1)
data$Sub_metering_2 <- fromfactors(data$Sub_metering_2)
data$Sub_metering_3 <- fromfactors(data$Sub_metering_3)

quartz()

plot(data$Time, data$Sub_metering_1, type="n", ylab="Energy sub metering")
lines(data$Time, data$Sub_metering_1, col="black")
lines(data$Time, data$Sub_metering_2, col="red")
lines(data$Time, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("black", "red", "blue"))

dev.copy(device=png, filename="plot3.png", width=480, height=480)
dev.off()