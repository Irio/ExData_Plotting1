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

# plot1.R

plot1_data <- copy
plot1_data[, "Date"] <- as.Date(plot1_data[, "Date"], "%d/%m/%Y")
png("plot1.png", width=480, height=480, bg="transparent")
hist(plot1_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
