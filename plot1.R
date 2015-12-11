## Read in data file
plot1 <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

## Subset data to just show the dates 2007-02-01 and 2007-02-02
plot1_subset <- subset(plot1, as.Date(strptime(Date, "%d/%m/%Y")) == as.Date("2007-02-01") | as.Date(strptime(Date, "%d/%m/%Y")) == as.Date("2007-02-02"))

## Convert Global_active_power from factor to numeric type
gap <- as.numeric(levels(plot1_subset$Global_active_power))[as.integer(plot1_subset$Global_active_power)]

## Draw Plot 1
hist(gap, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

## Save to PNG file
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()