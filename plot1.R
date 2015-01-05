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



# Plot histogram
png("plot1.png", width=480, height=480, units="px")
hist(dt_consumption$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     col="red")
dev.off()
