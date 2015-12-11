## Read in data file
plot2 <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

## Subset data to just show the dates 2007-02-01 and 2007-02-02
plot2_subset <- subset(plot2, as.Date(strptime(Date, "%d/%m/%Y")) == as.Date("2007-02-01") | as.Date(strptime(Date, "%d/%m/%Y")) == as.Date("2007-02-02"))

## Convert Global_active_power from factor to numeric type
gap <- as.numeric(levels(plot2_subset$Global_active_power))[as.integer(plot2_subset$Global_active_power)]

## Paste Date and Time together into one entity
dt <- paste(plot2_subset$Date, plot2_subset$Time)
dt2 <- strptime(dt, "%d/%m/%Y %H:%M:%S")

## Draw Plot 2
plot(dt2, gap, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Save to PNG file
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()