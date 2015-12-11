## Read in data file
plot4 <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

## Subset data to just show the dates 2007-02-01 and 2007-02-02
plot4_subset <- subset(plot4, as.Date(strptime(Date, "%d/%m/%Y")) == as.Date("2007-02-01") | as.Date(strptime(Date, "%d/%m/%Y")) == as.Date("2007-02-02"))

## Convert Global_active_power, Sub_metering_1, Sub_metering_2, Voltage, Global_reactive_power
## from factor to numeric type
gap <- as.numeric(levels(plot4_subset$Global_active_power))[as.integer(plot4_subset$Global_active_power)]
sm1 <- as.numeric(levels(plot4_subset$Sub_metering_1))[as.integer(plot4_subset$Sub_metering_1)]
sm2 <- as.numeric(levels(plot4_subset$Sub_metering_2))[as.integer(plot4_subset$Sub_metering_2)]
v <- as.numeric(levels(plot4_subset$Voltage))[as.integer(plot4_subset$Voltage)]
grp <- as.numeric(levels(plot4_subset$Global_reactive_power))[as.integer(plot4_subset$Global_reactive_power)]

## Set y-axis limits to range of the Sub_metering_X values
yrange <- range(c(sm1, sm2, plot4_subset$Sub_metering_3))

## Paste Date and Time together into one entity
dt <- paste(plot4_subset$Date, plot4_subset$Time)
dt2 <- strptime(dt, "%d/%m/%Y %H:%M:%S")

## Draw Plot 4
png("plot4.png", width = 480, height=480)

## Combine all 4 sub-graphs into one graph
par(mfcol=c(2, 2))

## Sub-graph 1
plot(dt2, gap, type="l", xlab="", ylab="Global Active Power")

## Sub-graph 2
plot(dt2, sm1, type="l", xlab="", ylab="Energy sub metering", yaxp = c(0, 30, 3))
lines(dt2, sm2, type="l", col="red")
lines(dt2, plot4_subset$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1), col = c("black", "red", "blue"), cex=0.8, bty="n")

## Sub-graph 3
plot(dt2, v, type = "l", xlab = "datetime", ylab = "Voltage")

## Sub-graph 4
plot(dt2, grp, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

## Save to PNG, but don't display on screen
dev.off()
