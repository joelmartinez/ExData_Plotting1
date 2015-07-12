data <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=F, na.strings=c("?"))
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
b <- data$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02"))
data <- data[b,]
tonum <- function(v) { 
	sapply(v, function(p) {
		as.numeric(as.character(p)) 
	}) 
}

data$Global_active_power <- tonum(data$Global_active_power)
data$Time <- strptime(paste(as.character(data$Date), data$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")

quartz()
plot(data$Time, data$Global_active_power,type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(device=png, filename="plot2.png", width=480, height=480)
dev.off()