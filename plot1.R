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

data$Global_active_power = fromfactors(data$Global_active_power)

quartz()
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(device=png, filename="plot1.png", width=480, height=480)
dev.off()
