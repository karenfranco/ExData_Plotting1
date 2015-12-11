## Read in data file
plot3 <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

## Subset data to just show the dates 2007-02-01 and 2007-02-02
plot3_subset <- subset(plot3, as.Date(strptime(Date, "%d/%m/%Y")) == as.Date("2007-02-01") | as.Date(strptime(Date, "%d/%m/%Y")) == as.Date("2007-02-02"))

## Convert Sub_metering_1, Sub_metering_2 from factor to numeric type
sm1 <- as.numeric(levels(plot3_subset$Sub_metering_1))[as.integer(plot3_subset$Sub_metering_1)]
sm2 <- as.numeric(levels(plot3_subset$Sub_metering_2))[as.integer(plot3_subset$Sub_metering_2)]

## Set y-axis limits to range of the Sub_metering_X values
yrange <- range(c(sm1, sm2, plot3_subset$Sub_metering_3))

## Paste Date and Time together into one entity
dt <- paste(plot3_subset$Date, plot3_subset$Time)
dt2 <- strptime(dt, "%d/%m/%Y %H:%M:%S")

## Draw Plot 3
png("plot3.png", width = 480, height=480)
plot(dt2, sm1, type="l", xlab="", ylab="Energy sub metering", yaxp = c(0, 30, 3))
lines(dt2, sm2, type="l", col="red")
lines(dt2, plot3_subset$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1), col = c("black", "red", "blue"), cex=0.8)

## Save to PNG, but don't display on screen
dev.off()
