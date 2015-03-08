setwd(tempdir())

file_name <- "household_power_consumption.txt"
if(!file.exists(file_name)) {
  zip_name <- "exdata_data_household_power_consumption.zip"
  if(!file.exists(zip_name))
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", zip_name, method="curl")
  unzip(zip_name)
}

data <- read.delim(file_name, sep=";", na.strings="?")
copy <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

# plot4.R

plot4_data <- within(copy, DateTime <- strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
png("plot4.png", width=480, height=480, bg="transparent")
par(mfrow=c(2, 2))

# 1
plot(plot4_data$DateTime, plot4_data$Global_active_power, type="l", xlab=NA, ylab="Global Active Power")

# 2
plot(plot4_data$DateTime, plot4_data$Voltage, type="l", xlab=NA, ylab="Voltage")

# 3
y_range <- c(min(plot4_data$Sub_metering_1, plot4_data$Sub_metering_2, plot4_data$Sub_metering_3),
             max(plot4_data$Sub_metering_1, plot4_data$Sub_metering_2, plot4_data$Sub_metering_3))
colors <- c("black", "red", "blue")
plot(plot4_data$DateTime, plot4_data$Sub_metering_1, type="l", ylim=y_range, xlab=NA, ylab="Energy sub metering", col=colors)
par(new=TRUE)
plot(plot4_data$DateTime, plot4_data$Sub_metering_2, type="l", ylim=y_range, xlab=NA, ylab=NA, col="red")
par(new=TRUE)
plot(plot4_data$DateTime, plot4_data$Sub_metering_3, type="l", ylim=y_range, xlab=NA, ylab=NA, col="blue")
par(new=FALSE)
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=colors, bty="n")

# 4
plot(plot4_data$DateTime, plot4_data$Global_reactive_power, type="l", xlab=NA, ylab="Voltage")

dev.off()
