plot4.R

#set working directory, pull file into a table with headers separated by a ";"
setwd("~/Desktop/CourseraR")
file <- "household_power_consumption.txt"
hpcDat <- read.table(file, header = TRUE, sep=";")

hpcDat$Date <- as.Date(hpcDat$Date, format = "%d/%m/%Y") #change Date column into date format
hpcDates <- hpcDat[(hpcDat$Date=="2007-02-01") | (hpcDat$Date=="2007-02-02"),] #select only the respective dates from the data
hpcDates$Global_active_power <- as.numeric(as.character(hpcDates$Global_active_power)) #set the global active power to a numeric
hpcDates <- transform(hpcDates, time=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") #transform the date and time using POSIXct to the correct format

hpcDates$Sub_metering_1 <- as.numeric(as.character(hpcDates$Sub_metering_1)) #set all of the sub_metering variables to numerics
hpcDates$Sub_metering_2 <- as.numeric(as.character(hpcDates$Sub_metering_2))
hpcDates$Sub_metering_3 <- as.numeric(as.character(hpcDates$Sub_metering_3))


hpcDates$Global_reactive_power <- as.numeric(as.character(hpcDates$Global_reactive_power)) #make grp numeric (same way as gap)
hpcDates$Voltage <- as.numeric(as.character(hpcDates$Voltage)) #turn voltage variable into numeric 

par(mfrow = c(2,2)) #set parameters of the graph to be 2x2 in nr by nc array

plot(hpcDates$time,hpcDates$Global_active_power, type="l", xlab="", ylab="Global Active Power") 
#Plot 1: days vs. gap

plot(hpcDates$time,hpcDates$Voltage, type="l", xlab="datetime", ylab="Voltage") 
#Plot 2: days vs. voltage

plot(hpcDates$time, hpcDates$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(hpcDates$time, hpcDates$Sub_metering_2, col = "red")
lines(hpcDates$time, hpcDates$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1), bty = "n", cex=0.4)
#Plot 3: days vs. sub metering, added bty and cex to change the size of the legend and remove boundaries (source: https://rstudio-pubs-static.s3.amazonaws.com/30642_583ee54e7d944ca6a17bdb6cdf85d32a.html)

plot(hpcDates$time,hpcDates$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
#Plot 4: days vs. grp

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()