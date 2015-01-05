library(dplyr)

setwd("~/Documents/ExploratoryDataAnalysis/ExData_Plotting1")

# Read header
colnames <- read.table("household_power_consumption.txt", nrows=1, sep=";", colClasses="character")
# Read data for the two days
dt_consumption <- tbl_df(read.table("household_power_consumption.txt", header=FALSE,
                                    skip=66637, nrows=2880, col.names=colnames, 
                                    sep=";", colClasses=c("character", "character", "numeric", 
                                                          "numeric", "numeric", "numeric", 
                                                          "numeric", "numeric", "numeric"),
                                    na.strings="?"))
# Convert date and time
dt_consumption$Time <- strptime(do.call(paste, c(dt_consumption[c("Date", "Time")], sep = " ")), format="%d/%m/%Y %H:%M:%S")
dt_consumption$Date <- as.Date(dt_consumption$Date, format="%d/%m/%Y")



# Plot graph
png("plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
with(dt_consumption, {
    # Graph 1
    plot(Time, Global_active_power, type="l",
         xlab="", ylab="Global Active Power")
    # Graph 2
    plot(Time, Voltage, type="l", 
         xlab="datetime", ylab="Voltage")
    # Graph 3
    plot(Time, Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
    lines(Time, Sub_metering_1, col="black")
    lines(Time, Sub_metering_2, col="red")
    lines(Time, Sub_metering_3, col="blue")
    legend("topright", lty=c(1,1,1), bty="n",
           col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    # Graph 4
    plot(Time, Global_reactive_power, type="l", 
         xlab="datetime", ylab="Global_reactive_power")
})
dev.off()